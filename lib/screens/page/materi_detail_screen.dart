// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:evolphy/components/back_appbar.dart';
import 'package:evolphy/components/card_garis.dart';
import 'package:evolphy/constants/constant.dart';
import 'package:evolphy/models/materi_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailMateriPage extends StatefulWidget {
  final ModelMateri materi;
  const DetailMateriPage({
    super.key,
    required this.materi,
  });

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
    videoId = YoutubePlayer.convertUrlToId(
            widget.materi.listYoutube[_selectedIndexVideo].link) ??
        "";
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
    final bytes = await rootBundle.load('pdfs${widget.materi.pdf}');
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}${widget.materi.pdf}');
    await file.writeAsBytes(bytes.buffer.asUint8List());
    setState(() {
      _file = file;
    });
  }

  void changeVideo(int index) {
    setState(() {
      _selectedIndexVideo = index;
      _controller.load(
          YoutubePlayer.convertUrlToId(widget.materi.listYoutube[index].link) ??
              "");
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
                            widget.materi.title,
                            style: kSemiBoldTextStyle.copyWith(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Materi ini menjelaskan tentang ${widget.materi.title}',
                            style: kRegularTextStyle.copyWith(
                                fontSize: 14, color: kAbuText),
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
                                for (int i = 0;
                                    i < widget.materi.listYoutube.length;
                                    i++)
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
                                                color: (i ==
                                                        _selectedIndexVideo)
                                                    ? kUngu
                                                    : kUngu.withOpacity(0.5),
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            child: Text(
                                              'Part ${i + 1}',
                                              style: kSemiBoldTextStyle.copyWith(
                                                  fontSize: 12,
                                                  color: (i ==
                                                          _selectedIndexVideo)
                                                      ? kWhite
                                                      : kWhite
                                                          .withOpacity(0.5)),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Expanded(
                                            child: Text(
                                              widget
                                                  .materi.listYoutube[i].title,
                                              style: kRegularTextStyle.copyWith(
                                                  fontSize: 12,
                                                  color: (i ==
                                                          _selectedIndexVideo)
                                                      ? kWhite
                                                      : kWhite
                                                          .withOpacity(0.5)),
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
                                  widget.materi.desc,
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
                              : const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(44),
                                    child: Text(
                                      'Rangkuman materi ini sedang dalam pengembangan.',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
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
