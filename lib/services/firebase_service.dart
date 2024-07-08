// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evolphy/constants/constant.dart';
import 'package:evolphy/screens/auth/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthService {
  // Membuat singleton instance
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method untuk mendapatkan pengguna yang sedang masuk
  Future<User?> getCurrentUser() async {
    User? loggedInUser;
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print("User is logged in: ${user.email}");
      } else {
        print("No user is logged in.");
      }
    } catch (e) {
      print("Error getting current user: $e");
    }
    return loggedInUser;
  }
}

class PostService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> createPost(String content, File? imageFile) async {
    if (imageFile != null) {
      String imageUrl = await _uploadImage(imageFile);
      await _firestore.collection('posts').add({
        'content': content,
        'image_url': imageUrl,
        'createdAt': Timestamp.now(),
        'createdBy': _auth.currentUser?.uid,
      });
    } else {
      await _firestore.collection('posts').add({
        'content': content,
        'image_url': "",
        'createdAt': Timestamp.now(),
        'createdBy': _auth.currentUser?.uid,
      });
    }
  }

  Future<String> _uploadImage(File imageFile) async {
    String fileName = imageFile.path.split('/').last;
    Reference ref = _storage.ref().child('post_images/$fileName');
    await ref.putFile(imageFile);
    return await ref.getDownloadURL();
  }

  Stream<QuerySnapshot> getPosts(int limit) {
    return _firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots();
  }

  Future<QuerySnapshot> getPostDocument(int limit) {
    return _firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .get();
  }

  Stream<QuerySnapshot> loadMorePosts(DocumentSnapshot lastVisible, int limit) {
    return _firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .startAfterDocument(lastVisible)
        .limit(5)
        .snapshots();
  }

  Future<QuerySnapshot> loadMorePostsDocument(
      DocumentSnapshot lastVisible, int limit) {
    return _firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .startAfterDocument(lastVisible)
        .limit(5)
        .get();
  }

  Stream<QuerySnapshot> searchPosts(String query) {
    return _firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .where('content', isGreaterThanOrEqualTo: query)
        .where('content', isLessThanOrEqualTo: '$query\uf8ff')
        .snapshots();
  }

  Future<DocumentSnapshot> getUser(String userId) async {
    return await _firestore.collection('users').doc(userId).get();
  }

  Future<void> createComment(
      String postId, String content, File? imageFile) async {
    if (imageFile != null) {
      String imageUrl = await _uploadImage(imageFile);
      await _firestore.collection('comments').add({
        'postId': postId,
        'image_url': imageUrl,
        'content': content,
        'createdAt': Timestamp.now(),
        'createdBy': _auth.currentUser?.uid,
      });
    } else {
      await _firestore.collection('comments').add({
        'postId': postId,
        'image_url': null,
        'content': content,
        'createdAt': Timestamp.now(),
        'createdBy': _auth.currentUser?.uid,
      });
    }
  }

  Stream<QuerySnapshot> getComments(String postId) {
    return _firestore
        .collection('comments')
        .where('postId', isEqualTo: postId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<int> getCommentsCount(String postId) async {
    final commentsSnapshot = await _firestore
        .collection('comments')
        .where('postId', isEqualTo: postId)
        .get();
    return commentsSnapshot.size;
  }

  Future<void> likePost(String postId) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('likes').add({
        'postId': postId,
        'userId': user.uid,
        'createdAt': Timestamp.now(),
      });
    }
  }

  Future<void> unlikePost(String postId) async {
    User? user = _auth.currentUser;
    if (user != null) {
      QuerySnapshot snapshot = await _firestore
          .collection('likes')
          .where('postId', isEqualTo: postId)
          .where('userId', isEqualTo: user.uid)
          .get();

      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
    }
  }

  Future<bool> isPostLikedByUser(String postId) async {
    User? user = _auth.currentUser;
    if (user != null) {
      QuerySnapshot snapshot = await _firestore
          .collection('likes')
          .where('postId', isEqualTo: postId)
          .where('userId', isEqualTo: user.uid)
          .get();

      return snapshot.docs.isNotEmpty;
    }
    return false;
  }

  Future<int> getLikesCount(String postId) async {
    QuerySnapshot snapshot = await _firestore
        .collection('likes')
        .where('postId', isEqualTo: postId)
        .get();
    return snapshot.docs.length;
  }

  Future<void> toggleLike(String postId, bool isLiked) async {
    if (isLiked) {
      await unlikePost(postId);
    } else {
      await likePost(postId);
    }
  }

  Future<void> deletePost(String postId) async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot postDoc =
          await _firestore.collection('posts').doc(postId).get();
      if (postDoc.exists && postDoc['createdBy'] == user.uid) {
        // Hapus semua komentar yang terkait dengan post ini
        QuerySnapshot commentsSnapshot = await _firestore
            .collection('comments')
            .where('postId', isEqualTo: postId)
            .get();

        for (var commentDoc in commentsSnapshot.docs) {
          await commentDoc.reference.delete();
          // Hapus gambar dari Storage jika ada di komentar
          if (commentDoc['image_url'] != "") {
            Reference ref = _storage.refFromURL(commentDoc['image_url']);
            await ref.delete();
          }
        }

        // Hapus semua likes yang terkait dengan post ini
        QuerySnapshot likesSnapshot = await _firestore
            .collection('likes')
            .where('postId', isEqualTo: postId)
            .get();

        for (var likeDoc in likesSnapshot.docs) {
          await likeDoc.reference.delete();
        }

        // Hapus gambar dari Storage jika ada di post
        if (postDoc['image_url'] != "") {
          Reference ref = _storage.refFromURL(postDoc['image_url']);
          await ref.delete();
        }

        // Hapus post itu sendiri
        await _firestore.collection('posts').doc(postId).delete();
      } else {
        throw Exception("You can only delete your own posts.");
      }
    }
  }

  Future<bool> isMyPost(String postId) async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot postDoc =
          await _firestore.collection('posts').doc(postId).get();
      if (postDoc.exists && postDoc['createdBy'] == user.uid) {
        return true;
      }
    }
    return false;
  }

  Future<bool> isMyComment(String commentId) async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot commentDoc =
          await _firestore.collection('comments').doc(commentId).get();
      if (commentDoc.exists && commentDoc['createdBy'] == user.uid) {
        return true;
      }
    }
    return false;
  }

  Future<void> deleteComment(String commentId) async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot commentDoc =
          await _firestore.collection('comments').doc(commentId).get();
      if (commentDoc.exists && commentDoc['createdBy'] == user.uid) {
        await _firestore.collection('comments').doc(commentId).delete();
        // Hapus gambar dari Storage jika ada
        if (commentDoc['image_url'] != null) {
          Reference ref = _storage.refFromURL(commentDoc['image_url']);
          await ref.delete();
        }
      } else {
        throw Exception("You can only delete your own comments.");
      }
    }
  }
}

Future<bool> checkDocumentExists(
    String collectionName, String documentName) async {
  try {
    DocumentSnapshot docSnap = await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(documentName)
        .get();

    if (docSnap.exists) {
      print("Dokumen ada: ${docSnap.data()}");
      return true;
    } else {
      print("Dokumen tidak ada!");
      return false;
    }
  } catch (e) {
    print("Error mengecek dokumen: $e");
    return false;
  }
}

Future<void> readDocument(String collectionName, String documentName) async {
  try {
    DocumentSnapshot docSnap = await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(documentName)
        .get();

    if (docSnap.exists) {
      print("Data dokumen: ${docSnap.data()}");
    } else {
      print("Tidak ada dokumen!");
    }
  } catch (e) {
    print("Error membaca dokumen: $e");
  }
}

Future<dynamic> getProperty(
    String collection, String docId, String property) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  try {
    DocumentSnapshot docSnapshot =
        await firestore.collection(collection).doc(docId).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey(property)) {
        return data[property];
      } else {
        print("$property does not exist in the document.");
      }
    } else {
      print("Document does not exist.");
    }
  } catch (e) {
    print("Error getting document: $e");
  }
  return null;
}

Future<void> updateProperty(
  String collection,
  String docId,
  String property,
  dynamic value,
) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    DocumentReference docRef = firestore.collection(collection).doc(docId);
    await docRef.set(
      {property: value},
      SetOptions(
          merge:
              true), // Menggunakan merge untuk menambahkan atau memperbarui properti tanpa menghapus properti lain yang ada
    );
    print("Property added/updated successfully.");
  } catch (e) {
    print("Error adding/updating property: $e");
  }
}

Future<void> logOut(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    // Redirect to login page or another appropriate action
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  } catch (e) {
    print("Error logging out: $e");
  }
}

class ImageService {
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  File? getSelectedImage() {
    return selectedImage;
  }

  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
    } else {
      print("No image selected");
    }
  }

  Future<void> uploadImage(
      String collection, String docId, String property) async {
    if (selectedImage != null) {
      try {
        // Unggah gambar ke Firebase Storage
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final storageRef = _storage.ref().child('forum/$fileName');
        UploadTask uploadTask = storageRef.putFile(selectedImage!);

        // Tunggu sampai pengunggahan selesai dan dapatkan URL unduhan
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadURL = await taskSnapshot.ref.getDownloadURL();

        // Simpan URL gambar di Firestore
        await updateProperty(collection, docId, property, downloadURL);

        print("Image uploaded successfully: $downloadURL");
      } catch (e) {
        print("Error uploading image: $e");
      }
    } else {
      print("No image selected for upload");
    }
  }

  Future<void> pickAndUploadImage(
      String collection, String docId, String property) async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File file = File(pickedFile.path);
      try {
        // Unggah gambar ke Firebase Storage
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final storageRef = storage.ref().child('images/$fileName');
        UploadTask uploadTask = storageRef.putFile(file);

        // Tunggu sampai pengunggahan selesai dan dapatkan URL unduhan
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadURL = await taskSnapshot.ref.getDownloadURL();

        // Simpan URL gambar di Firestore
        await updateProperty(collection, docId, property, downloadURL);

        print("Image uploaded successfully: $downloadURL");
      } catch (e) {
        print("Error uploading image: $e");
      }
    } else {
      print("No image selected");
    }
  }

  void clearImage() {
    selectedImage = null;
  }
}

class MyNetworkImage extends StatelessWidget {
  final String imageURL;
  final double? width;
  final double? height;
  final BoxFit? fit;
  const MyNetworkImage({
    super.key,
    required this.imageURL,
    this.width,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(imageURL, width: width, height: height, fit: fit,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) {
        return child;
      } else {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: CircularProgressIndicator(
              color: kUngu,
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
            ),
          ),
        );
      }
    }, errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
      return SizedBox(
          width: width,
          height: height,
          child: const Text('Failed to load image'));
    });
  }
}
