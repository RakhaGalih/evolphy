import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evolphy/constants/constant.dart';
import 'package:evolphy/models/data_model.dart';
import 'package:evolphy/models/materi_model.dart';
import 'package:evolphy/screens/page/materi_page.dart';
import 'package:evolphy/screens/page/post_detail_screen.dart';
import 'package:evolphy/services/converter.dart';
import 'package:evolphy/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPage();
}

class _BerandaPage extends State<BerandaPage> {
  String? _username;
  final PostService _firebaseService = PostService();
  bool _isLoadingMore = false;
  final List<Map<String, dynamic>> _posts = [];
  Map<String, dynamic>? _post; // Nullable _post
  final int _limit = 1;

  @override
  void initState() {
    super.initState();
    _getDataUser();
    _loadPosts();
  }

  Future<void> _getDataUser() async {
    User? user = await AuthService().getCurrentUser();
    if (user != null) {
      String? fetchedUsername =
          await getProperty('users', user.uid, 'username');
      setState(() {
        _username = fetchedUsername;
      });
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
            if (_posts.isNotEmpty) {
              _post = _posts[0]; // Safely assign _post
            }
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

  void _navigateForum(BuildContext context, Map<String, dynamic>? post) async {
    if (post == null) return; // Return if post is null

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
    });
    await _loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1c202a),
      body: Column(
        children: [
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hai, ${_username ?? "selamat datang"}',
                        style: kSemiBoldTextStyle.copyWith(fontSize: 16),
                      ),
                      Text(
                        "Let's explore Evolphy!",
                        style: kRegularTextStyle.copyWith(
                            fontSize: 13, color: kGreySecondary),
                      )
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                      color: kAbu, borderRadius: BorderRadius.circular(100)),
                  child: Row(
                    children: [
                      Image.asset(
                        'images/diamond.png',
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '0',
                        style: kBoldTextStyle.copyWith(fontSize: 18),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 25,
                    right: 25,
                  ),
                  decoration: BoxDecoration(
                      color: const Color(0xFF5c1d8d),
                      borderRadius: BorderRadius.circular(15)),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 25),
                                  child: Text(
                                    "Yey, kamu berada di level 1!",
                                    style: TextStyle(
                                      color: Color(0xFFD7D8DB),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const Text(
                                  "Level 1: Pemahaman Fundamental Konsep",
                                  style: TextStyle(
                                      color: Color(0xFFD7D8DB), fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 25),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      backgroundColor: kWhite,
                                    ),
                                    onPressed: () {
                                      Provider.of<DataModel>(context,
                                              listen: false)
                                          .onNavBarTapped(2);
                                    },
                                    child: const Text(
                                      'Mulai Sekarang',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF560073),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 125,
                          ),
                        ],
                      ),
                      Positioned(
                        right: 0,
                        bottom: -70,
                        child: SvgPicture.asset(
                          "images/orang_ditangga.svg",
                          width: 107,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 52,
                  decoration: BoxDecoration(
                      color: const Color(0xFF481585),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: Colors.white,
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: RichText(
                          softWrap: true,
                          text: const TextSpan(
                            style: TextStyle(color: Colors.white, fontSize: 12),
                            children: [
                              TextSpan(text: 'Aplikasi '),
                              TextSpan(
                                text: 'Evolphy',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: ' masih dalam pengembangan'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                lihatSemua("Modul Materi", 1, context),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 236,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: listJudulMateris.length,
                      clipBehavior: Clip.none,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return MateriPage(
                                  materi: listJudulMateris[index]);
                            }));
                          },
                          child: Container(
                            width: 165,
                            height: 236,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: listJudulMateris[index].color,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  right: -15,
                                  bottom: 40,
                                  child: SvgPicture.asset(
                                    listJudulMateris[index].image,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 65,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Colors.white.withOpacity(0.32),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.diamond,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            listJudulMateris[index]
                                                .diamond
                                                .toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      listJudulMateris[index].title,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 15,
                        );
                      }),
                ),
                const SizedBox(
                  height: 25,
                ),
                lihatSemua("Forum", 3, context),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    _navigateForum(context, _post);
                  },
                  child: _post != null
                      ? Container(
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
                                  _post!['userImage'] != null
                                      ? CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(_post!['userImage']),
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
                                      _post!['username'],
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
                                    formatTanggal(_post!['createdAt']),
                                    style: kMediumTextStyle.copyWith(
                                        fontSize: 12, color: kAbuText),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                _post!['content'],
                                style: kMediumTextStyle,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              (_post!['image_url'] != "")
                                  ? MyNetworkImage(
                                      imageURL: _post!['image_url'])
                                  : const SizedBox(),
                              SizedBox(
                                height: (_post!['image_url'] != "") ? 20 : 0,
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
                                          _post!['postId'], _post!['isLiked']);
                                    },
                                    child: Icon(
                                      _post!['isLiked']
                                          ? Icons.favorite
                                          : Icons.favorite_outline,
                                      color: _post!['isLiked']
                                          ? Colors.red
                                          : kWhite,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    _post!['likes']
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
                                    _post!['comments']
                                        .toString(), // Convert to string
                                    style: kSemiBoldTextStyle,
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(), // Show empty box if _post is null
                ),
                const SizedBox(
                  height: 24,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget lihatSemua(String title, int index, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () {
          Provider.of<DataModel>(context, listen: false).onNavBarTapped(index);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Lihat semua ",
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
