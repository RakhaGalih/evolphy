import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evolphy/constants/constant.dart';
import 'package:evolphy/services/firebase_service.dart';
import 'package:flutter/material.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  final PostService _firebaseService = PostService();
  final int _limit = 3;
  DocumentSnapshot? _lastDocument;
  bool _isLoadingMore = false;
  final List<Map<String, dynamic>> _posts = [];

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    setState(() {
      _isLoadingMore = true;
    });

    final stream = _firebaseService.getPosts(_limit, _lastDocument);
    stream.listen((QuerySnapshot snapshot) async {
      if (snapshot.docs.isNotEmpty) {
        List<Map<String, dynamic>> newPosts = [];

        for (var doc in snapshot.docs) {
          DocumentSnapshot userDoc =
              await _firebaseService.getUser(doc['createdBy']);
          Map<String, dynamic> postData = doc.data() as Map<String, dynamic>;
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;

          postData['userImage'] = userData['image'];
          postData['username'] = userData['username'];

          newPosts.add(postData);
        }

        setState(() {
          _posts.addAll(newPosts);
          _lastDocument = snapshot.docs.last;
          _isLoadingMore = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              Center(
                child: Text(
                  'Forum',
                  style: kSemiBoldTextStyle.copyWith(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 15),
                              filled: true,
                              fillColor: kAbuHitam,
                              hintStyle: const TextStyle(color: kAbu),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintText: 'Cari forum')),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: kUngu, borderRadius: BorderRadius.circular(8)),
                      child: const Icon(
                        Icons.tune,
                        color: kWhite,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: _posts.length,
                    itemBuilder: (context, index) {
                      final post = _posts[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: kAbuHitam,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: kAbu, width: 0.5)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                post['userImage'] != null
                                    ? CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(post['userImage']),
                                      )
                                    : const CircleAvatar(
                                        backgroundColor: kUngu,
                                        child: Icon(Icons.person),
                                      ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(post['username']),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(post['content']),
                            SizedBox(
                              height: 20,
                            ),
                            (post['image_url'] != "")
                                ? MyNetworkImage(imageURL: post['image_url'])
                                : const SizedBox(),
                            SizedBox(
                              height: (post['image_url'] != "") ? 20 : 0,
                            ),
                            const Row(
                              children: [
                                Icon(
                                  Icons.favorite_outline,
                                  color: kWhite,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Icon(
                                  Icons.question_answer_outlined,
                                  color: kWhite,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Icon(
                                  Icons.bookmark_border,
                                  color: kWhite,
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/post');
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: kUngu, borderRadius: BorderRadius.circular(30)),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.add_circle,
                color: kWhite,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Unggah',
                style: kSemiBoldTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
