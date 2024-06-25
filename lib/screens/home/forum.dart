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
  final int _limitIncrement = 4;
  int _limit = 4;
  DocumentSnapshot? _lastDocument;
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
      } else {
        setState(() {
          _isLoadingMore = false;
        });
      }
    });
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

  void _navigateAndDisplayResult(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/post');

    // Check what was returned and act accordingly
    if (result != null) {
      _posts.removeRange(0, _posts.length - 1);
      await _loadPosts();
      setState(() {});
    }
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
                    controller: _scrollController,
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
                                  width: 12,
                                ),
                                Text(
                                  post['username'],
                                  style:
                                      kSemiBoldTextStyle.copyWith(fontSize: 16),
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
          _navigateAndDisplayResult(context);
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
