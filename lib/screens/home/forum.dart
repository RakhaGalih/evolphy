import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evolphy/components/card_garis.dart';
import 'package:evolphy/components/forum_card.dart';
import 'package:evolphy/constants/constant.dart';
import 'package:evolphy/screens/page/post_detail_screen.dart';
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
  bool _canDeletePost = false;
  bool _isNotFound = false;
  bool _isSearching = false;
  bool _isLoadingMore = false;
  final List<Map<String, dynamic>> _posts = [];
  // Dokumen terakhir dari batch pertama
  late DocumentSnapshot lastVisible;
  int? _selectedForum;
  TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchPosts();
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
      if (_scrollController.position.pixels != 0 && !_isSearching) {
        _loadMorePosts();
      }
    }
  }

  Future<void> _fetchPosts() async {
    try {
      Stream<QuerySnapshot> stream = _firebaseService.getPosts(_limit);
      final getPosts = await _firebaseService.getPostDocument(_limit);
      lastVisible = getPosts.docs.last;
      _loadPosts(stream);
    } catch (e) {
      setState(() {
        _isLoadingMore = false;
      });
      print("Error loading posts: $e");
    }
  }

  Future<void> _loadPosts(Stream<QuerySnapshot> stream) async {
    setState(() {
      _isLoadingMore = true;
    });
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
  }

  Future<void> _loadMorePosts() async {
    if (!_isLoadingMore && !_isSearching) {
      setState(() {
        _isLoadingMore = true;
        _limit += _limitIncrement;
      });
      try {
        Stream<QuerySnapshot> stream =
            _firebaseService.loadMorePosts(lastVisible, _limitIncrement);
        final getPosts = await _firebaseService.loadMorePostsDocument(
            lastVisible, _limitIncrement);
        lastVisible = getPosts.docs.last;
        _loadPosts(stream);
      } catch (e) {
        setState(() {
          _isLoadingMore = false;
        });
        print("Error loading posts: $e");
      }
    }
  }

  Future<void> _searchPosts(String query) async {
    setState(() {
      _isLoadingMore = true;
      _posts.clear();
    });

    try {
      final stream = _firebaseService.searchPosts(query);
      await _loadPosts(stream);
      _isSearching = true;
      if (await stream.isEmpty) {
        setState(() {
          _isNotFound = true;
        });
      }
    } catch (e) {
      setState(() {
        _isLoadingMore = false;
      });
      print("Error loading posts: $e");
    }
  }

  void navigatePost(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/post');

    // Check what was returned and act accordingly
    if (result != null) {
      _posts.clear(); // Clear the existing posts
      await _fetchPosts(); // Reload the posts
      setState(() {});
    }
  }

  void navigateForum(BuildContext context, Map<String, dynamic> post) async {
    final result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PostDetailScreen(post);
    }));

    // Check what was returned and act accordingly
    if (result != null) {
      _posts.clear(); // Clear the existing posts
      await _fetchPosts(); // Reload the posts
      setState(() {});
    }
  }

  Future<void> toggleLike(String postId, bool isLiked) async {
    _firebaseService.toggleLike(postId, isLiked);

    // Refresh posts to reflect the new like status
    setState(() {
      _posts.clear();
      _limit = _limitIncrement;
    });
    await _fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
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
                            controller: searchController,
                            decoration: InputDecoration(
                                prefixIcon: GestureDetector(
                                    onTap: () async {
                                      await _searchPosts(searchController.text);
                                      if (!_isLoadingMore) {
                                        if (_posts.isEmpty) {
                                          setState(() {
                                            _isNotFound = true;
                                            _isLoadingMore = false;
                                          });
                                        } else {
                                          setState(() {
                                            _isNotFound = false;
                                          });
                                        }
                                      }
                                    },
                                    child: const Icon(Icons.search)),
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
                              if (value.isEmpty ||
                                  value == "" && !_isLoadingMore) {
                                _posts.clear();

                                setState(() {
                                  _isSearching = false;
                                  _isNotFound = false;
                                });
                                await _fetchPosts();
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
                              color: kUngu,
                              borderRadius: BorderRadius.circular(8)),
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
                    child: (_isNotFound)
                        ? const Center(
                            child: Text('Postingan tidak ditemukan :)'),
                          )
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            controller: _scrollController,
                            itemCount: _posts.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> post = _posts[index];
                              return ForumCard(
                                post: post,
                                onTap: () {
                                  navigateForum(context, post);
                                },
                                onLongPress: () async {
                                  setState(() {
                                    _canDeletePost = false;
                                  });
                                  if (await _firebaseService
                                      .isMyPost(post['postId'])) {
                                    setState(() {
                                      _canDeletePost = true;
                                    });
                                  }
                                  setState(() {
                                    _selectedForum = index;
                                  });
                                },
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
          if (_selectedForum != null)
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedForum = null;
                  });
                },
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            ),
          if (_selectedForum != null)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: (_canDeletePost)
                        ? screenHeight * 0.2
                        : screenHeight * 0.17,
                  ),
                  ForumCard(
                      post: _posts[_selectedForum!],
                      onTap: () {
                        navigateForum(context, _posts[_selectedForum!]);
                        _selectedForum = null;
                      },
                      onLongPress: () {}),
                  if (_canDeletePost)
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: GestureDetector(
                        onTap: () async {
                          await _firebaseService
                              .deletePost(_posts[_selectedForum!]['postId']);

                          _posts.clear();
                          await _fetchPosts();
                          setState(() {
                            _selectedForum = null;
                          });
                        },
                        child: CardGaris(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.delete_outline,
                                  color: Colors.red),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Delete',
                                style: kSemiBoldTextStyle.copyWith(
                                    fontSize: 16, color: Colors.red),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                ],
              ),
            )
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          navigatePost(context);
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
