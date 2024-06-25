import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evolphy/components/back_appbar.dart';
import 'package:evolphy/services/firebase_service.dart';
import 'package:flutter/material.dart';

class PostDetailScreen extends StatefulWidget {
  final String postId;

  const PostDetailScreen(this.postId, {super.key});

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final PostService _firebaseService = PostService();
  final TextEditingController _commentController = TextEditingController();
  final int _limitIncrement = 4;
  int _limit = 4;
  DocumentSnapshot? _lastDocument;
  bool _isLoadingMore = false;
  final List<Map<String, dynamic>> _comments = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadComments();
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
        _loadMoreComments();
      }
    }
  }

  Future<void> _loadComments() async {
    setState(() {
      _isLoadingMore = true;
    });

    final stream = _firebaseService.getComments(
      widget.postId,
    );
    stream.listen((QuerySnapshot snapshot) async {
      if (snapshot.docs.isNotEmpty) {
        List<Map<String, dynamic>> newComments = [];

        for (var doc in snapshot.docs) {
          DocumentSnapshot userDoc =
              await _firebaseService.getUser(doc['createdBy']);
          Map<String, dynamic> commentData = doc.data() as Map<String, dynamic>;
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;

          commentData['userImage'] = userData['image'];
          commentData['username'] = userData['username'];
          commentData['commentId'] =
              doc.id; // Adding commentId to the comment data

          newComments.add(commentData);
        }

        setState(() {
          _comments.addAll(newComments);
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

  Future<void> _loadMoreComments() async {
    if (!_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
        _limit += _limitIncrement;
      });
      _loadComments();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const BackAppBar(title: 'Detail Forum'),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _comments.length,
              itemBuilder: (context, index) {
                final comment = _comments[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(comment['userImage'] ?? ''),
                  ),
                  title: Text(comment['username'] ?? 'Unknown User'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(comment['content']),
                      Text(comment['createdAt'].toDate().toString()),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      labelText: 'Add a comment',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    final content = _commentController.text;
                    if (content.isNotEmpty) {
                      await _firebaseService.createComment(
                          widget.postId, content);
                      _commentController.clear();
                      setState(() {}); // Ensure the UI is refreshed
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
