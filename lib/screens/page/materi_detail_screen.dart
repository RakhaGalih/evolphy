import 'dart:io';

import 'package:evolphy/components/back_appbar.dart';
import 'package:evolphy/components/card_garis.dart';
import 'package:evolphy/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailMateriPage extends StatefulWidget {
  const DetailMateriPage({super.key});

  @override
  State<DetailMateriPage> createState() => _DetailMateriPageState();
}

class _DetailMateriPageState extends State<DetailMateriPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late YoutubePlayerController _controller;
  int _selectedIndexVideo = 0;
  bool _viewFullPage = false;
  File? _file;
  List<String> listVideo = [
    "https://www.youtube.com/watch?v=lt4bRdWowGI",
    "https://www.youtube.com/watch?v=-l6Th8W0-iU",
    "https://www.youtube.com/watch?v=4Y_nHzSOm1c",
    "https://www.youtube.com/watch?v=MNtAXylJb7Q",
    "https://www.youtube.com/watch?v=WDAaUBWZIaI",
    "https://www.youtube.com/watch?v=YdSySM6nvM0",
    "https://www.youtube.com/watch?v=Lp62iQwES38",
    "https://www.youtube.com/watch?v=iHJI66Mqfjs"
  ];

  String videoId = "";

  @override
  void initState() {
    super.initState();
    getFile();
    _tabController = TabController(length: 2, vsync: this);
    updateVideo();
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void updateVideo() {
    videoId =
        YoutubePlayer.convertUrlToId(listVideo[_selectedIndexVideo]) ?? "";
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    setState(() {});
  }

  Future<void> getFile() async {
    final bytes = await rootBundle.load('pdfs/gerak_lurus.pdf');
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/gerak_lurus.pdf');
    await file.writeAsBytes(bytes.buffer.asUint8List());
    setState(() {
      _file = file;
    });
  }

  void changeVideo(int index) {
    setState(() {
      _selectedIndexVideo = index;
      _controller.load(YoutubePlayer.convertUrlToId(listVideo[index]) ?? "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      if (orientation == Orientation.landscape) {
        return Scaffold(body: youtubePlayer(_controller));
      } else if (_viewFullPage == true) {
        return Stack(children: [
          PDFView(
            filePath: _file!.path,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: false,
            onRender: (pages) {
              print('Document is rendered with $pages pages');
            },
            onError: (error) {
              print(error.toString());
            },
            onPageError: (page, error) {
              print('Error on page $page: $error');
            },
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: SafeArea(
                  child: Padding(
                padding: const EdgeInsets.all(24),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _viewFullPage = false;
                    });
                  },
                  child: const CardGaris(
                      child: Icon(
                    Icons.close_fullscreen,
                    color: kWhite,
                  )),
                ),
              )))
        ]);
      } else {
        return Scaffold(
            body: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackAppBar(
                title: 'Materi',
              ),
              (videoId != "")
                  ? youtubePlayer(_controller)
                  : const SizedBox(
                      height: 100,
                      child: Center(
                        child: Text('Video tidak tersedia'),
                      ),
                    ),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gerak Lurus',
                            style: kSemiBoldTextStyle.copyWith(fontSize: 20),
                          ),
                          Text(
                            'Materi ini menjelaskan tentang ',
                            style: kRegularTextStyle.copyWith(
                                fontSize: 16, color: kAbuText),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: kAbuHitam,
                              borderRadius: BorderRadius.circular(
                                25.0,
                              ),
                            ),
                            child: TabBar(
                              controller: _tabController,
                              // give the indicator a decoration (color and border radius)
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  25.0,
                                ),
                                color: kUngu,
                              ),
                              indicatorSize: TabBarIndicatorSize.tab,
                              dividerColor: Colors.transparent,
                              labelColor: kWhite,
                              unselectedLabelColor: kAbuText,
                              indicatorWeight: 1,
                              isScrollable: false,
                              tabs: [
                                // first tab [you can add an icon using the icon property]
                                Tab(
                                  child: Text(
                                    'Materi',
                                    style:
                                        kBoldTextStyle.copyWith(fontSize: 16),
                                  ),
                                ),

                                // second tab [you can add an icon using the icon property]
                                Tab(
                                  child: Text(
                                    'Rangkuman',
                                    style:
                                        kBoldTextStyle.copyWith(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sub Materi',
                                  style:
                                      kSemiBoldTextStyle.copyWith(fontSize: 16),
                                ),
                                for (int i = 0; i < listVideo.length; i++)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: GestureDetector(
                                      onTap: () {
                                        changeVideo(i);
                                      },
                                      child: CardGaris(
                                          child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                                color: kUngu,
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            child: Text(
                                              'Part ${i + 1}',
                                              style: kSemiBoldTextStyle
                                                  .copyWith(fontSize: 12),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Gerak Lurus Beraturan (GLB) dan Gerak Lurus Berubah Beraturan (GLBB)',
                                              style: kRegularTextStyle.copyWith(
                                                  fontSize: 12),
                                            ),
                                          )
                                        ],
                                      )),
                                    ),
                                  ),
                                const SizedBox(
                                  height: 24,
                                ),
                                Text(
                                  'Deskripsi Materi',
                                  style:
                                      kSemiBoldTextStyle.copyWith(fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Deskripsi Materi',
                                  style: kRegularTextStyle.copyWith(
                                      fontSize: 16, color: kAbuText),
                                ),
                              ],
                            ),
                          ),
                          _file != null
                              ? Expanded(
                                  child: Stack(children: [
                                  PDFView(
                                    filePath: _file!.path,
                                    enableSwipe: true,
                                    swipeHorizontal: true,
                                    autoSpacing: true,
                                    pageFling: false,
                                    onRender: (pages) {
                                      print(
                                          'Document is rendered with $pages pages');
                                    },
                                    onError: (error) {
                                      print(error.toString());
                                    },
                                    onPageError: (page, error) {
                                      print('Error on page $page: $error');
                                    },
                                  ),
                                  Align(
                                      alignment: Alignment.bottomRight,
                                      child: SafeArea(
                                          child: Padding(
                                        padding: const EdgeInsets.all(24),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _viewFullPage = true;
                                            });
                                          },
                                          child: const CardGaris(
                                              child: Icon(
                                            Icons.fullscreen,
                                            color: kWhite,
                                          )),
                                        ),
                                      )))
                                ]))
                              : const CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
      }
    });
  }
}

youtubePlayer(YoutubePlayerController controller) {
  return YoutubePlayer(
    controller: controller,
    showVideoProgressIndicator: true,
    progressIndicatorColor: kUngu,
    onReady: () {
      controller.addListener(() {});
    },
  );
}
