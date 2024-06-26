import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evolphy/constants/constant.dart';
import 'package:evolphy/screens/page/post_detail_screen.dart';
import 'package:evolphy/services/converter.dart';
import 'package:evolphy/services/firebase_service.dart';
import 'package:flutter/material.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  final PostService _firebaseService = PostService();
  final int _limitIncrement = 4;
  int _limit = 4;
  bool _isLoadingMore = false;
  final List<Map<String, dynamic>> _posts = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadPosts();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        _loadMorePosts();
      }
    }
  }

  Future<void> _loadPosts() async {
    setState(() {
      _isLoadingMore = true;
    });

    try {
      final stream = _firebaseService.getPosts(_limit);
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
            postData['postId'] = doc.id; // Adding postId to the post data
            postData['likes'] =
                await _firebaseService.getLikesCount(postData['postId']);
            postData['comments'] =
                await _firebaseService.getCommentsCount(postData['postId']);
            postData['isLiked'] =
                await _firebaseService.isPostLikedByUser(postData['postId']);

            newPosts.add(postData);
          }

          setState(() {
            _posts.addAll(newPosts);
            _isLoadingMore = false;
          });
        } else {
          setState(() {
            _isLoadingMore = false;
          });
        }
      });
    } catch (e) {
      setState(() {
        _isLoadingMore = false;
      });
      print("Error loading posts: $e");
    }
  }

  Future<void> _loadMorePosts() async {
    if (!_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
        _limit += _limitIncrement;
      });
      _loadPosts();
    }
  }

  Future<void> _searchPosts(String query) async {
    setState(() {
      _isLoadingMore = true;
      _posts.clear();
    });

    try {
      final stream = _firebaseService.searchPosts(query);
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
            postData['postId'] = doc.id; // Adding postId to the post data
            postData['likes'] =
                await _firebaseService.getLikesCount(postData['postId']);
            postData['comments'] =
                await _firebaseService.getCommentsCount(postData['postId']);
            postData['isLiked'] =
                await _firebaseService.isPostLikedByUser(postData['postId']);

            newPosts.add(postData);
          }

          setState(() {
            _posts.addAll(newPosts);
            _isLoadingMore = false;
          });
        } else {
          setState(() {
            _isLoadingMore = false;
          });
        }
      });
    } catch (e) {
      setState(() {
        _isLoadingMore = false;
      });
      print("Error loading posts: $e");
    }
  }

  void _navigatePost(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/post');

    // Check what was returned and act accordingly
    if (result != null) {
      _posts.clear(); // Clear the existing posts
      await _loadPosts(); // Reload the posts
      setState(() {});
    }
  }

  void _navigateForum(BuildContext context, Map<String, dynamic> post) async {
    final result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PostDetailScreen(post);
    }));

    // Check what was returned and act accordingly
    if (result != null) {
      _posts.clear(); // Clear the existing posts
      await _loadPosts(); // Reload the posts
      setState(() {});
    }
  }

  Future<void> _toggleLike(String postId, bool isLiked) async {
    _firebaseService.toggleLike(postId, isLiked);

    // Refresh posts to reflect the new like status
    setState(() {
      _posts.clear();
      _limit = _limitIncrement;
    });
    await _loadPosts();
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
                            hintText: 'Cari forum'),
                        onChanged: (value) async {
                          if (value.isEmpty) {
                            _posts.clear();
                            await _loadPosts();
                          } else {
                            await _searchPosts(value);
                          }
                        },
                      ),
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
                    physics: const BouncingScrollPhysics(),
                    controller: _scrollController,
                    itemCount: _posts.length,
                    itemBuilder: (context, index) {
                      final post = _posts[index];
                      bool like = false;
                      return GestureDetector(
                        onTap: () {
                          _navigateForum(context, post);
                        },
                        child: Container(
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
                                    width: 12,
                                  ),
                                  Expanded(
                                    child: Text(
                                      post['username'],
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: kSemiBoldTextStyle.copyWith(
                                          fontSize: 16),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    formatTanggal(post['createdAt']),
                                    style: kMediumTextStyle.copyWith(
                                        fontSize: 12, color: kAbuText),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                post['content'],
                                style: kMediumTextStyle,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              (post['image_url'] != "")
                                  ? MyNetworkImage(imageURL: post['image_url'])
                                  : const SizedBox(),
                              SizedBox(
                                height: (post['image_url'] != "") ? 20 : 0,
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                width: double.infinity,
                                height: 1,
                                color: kAbu,
                              ),
                              Row(
                                children: [
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      _toggleLike(
                                          post['postId'], post['isLiked']);
                                    },
                                    child: Icon(
                                      post['isLiked']
                                          ? Icons.favorite
                                          : Icons.favorite_outline,
                                      color:
                                          post['isLiked'] ? Colors.red : kWhite,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    post['likes']
                                        .toString(), // Convert to string
                                    style: kSemiBoldTextStyle,
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.question_answer_outlined,
                                    color: kWhite,
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    post['comments']
                                        .toString(), // Convert to string
                                    style: kSemiBoldTextStyle,
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              if (_isLoadingMore)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          _navigatePost(context);
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
