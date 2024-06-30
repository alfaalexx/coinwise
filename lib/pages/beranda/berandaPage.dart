import 'package:coinwise/widget/drawer_content_page.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:video_player/video_player.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  bool _showInput = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static const double ActionWidgetSize = 60.0;
  static const double ActionIconSize = 35.0;
  static const double ShareActionIconSize = 25.0;
  static const double ProfileImageSize = 50.0;
  static const double FollowActionIconSize = 25.0;

  final List<Map<String, dynamic>> videos = [
    {
      "username": "@Day Hawk",
      "title": "Lorem ipsum dolor amet, consectetur...",
      "content_video": "assets/videos/video1.mp4",
      "imageUrl":
          "https://secure.gravatar.com/avatar/ef4a9338dca42372f15427cdb4595ef7",
      "isLiked": false,
      "isSave": false,
    },
    {
      "username": "@Betty Cricket",
      "title": "Kenali skema penipuan pada crypto",
      "content_video": "assets/videos/Logo-coinwise-vid.mp4",
      "imageUrl":
          "https://secure.gravatar.com/avatar/ef4a9338dca42372f15427cdb4595ef7",
      "isLiked": false,
      "isSave": false,
    },
    // Add more video data here
  ];

  int videoIndex = 0;
  late VideoPlayerController _controller;
  late PageController _pageController;
  Future<void>? _initializeVideoPlayerFuture;

  Future<void> _initializeVideoPlayer() async {
    String videoPath = videos[videoIndex]['content_video']!;
    _controller = VideoPlayerController.asset(videoPath);
    _initializeVideoPlayerFuture = _controller.initialize();
    await _initializeVideoPlayerFuture;
    _controller.setLooping(true);
    _controller.play();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _initializeVideoPlayer();
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _toggleLike(int index) {
    setState(() {
      videos[index]['isLiked'] = !videos[index]['isLiked'];
    });
  }

  void _toggleSave(int index) {
    setState(() {
      videos[index]['isSave'] = !videos[index]['isSave'];
    });
  }

  // showdialog subscribe function
  void showSubscribedialog(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(60)),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Color.fromRGBO(217, 217, 217, 1),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/lock_icon.png'),
                SizedBox(
                  height: 10,
                ),
                Text("Khusus",
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                SizedBox(
                  height: 20,
                ),
                Text(
                  textAlign: TextAlign.center,
                  "Untuk pengalaman pengguna yang lebih menyenangkan",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(140, 135, 135, 1)),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Subscribe",
                      style: TextStyle(
                          letterSpacing: 1,
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            Color.fromRGBO(2, 62, 138, 1))),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget videoDescription(Map<String, dynamic> videoData) => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                videoData['username']!,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18),
              ),
              SizedBox(height: 10.0),
              Text(
                videoData['title']!,
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      );

  Widget get actionsToolbar => Container(
        width: 85.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _getProfileVideoAction(),
            GestureDetector(
              onTap: () => _toggleLike(videoIndex),
              child: _getVideoAction(
                  title: '3.2m',
                  isCustomIcon: true,
                  iconPath: videos[videoIndex]['isLiked']
                      ? "assets/images/like_aktif.png"
                      : "assets/images/like_icon.png"),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  backgroundColor: Colors.white,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 550,
                      child: Center(
                          child: Stack(
                        children: [
                          ListView(
                            children: [
                              // comment pertama
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 25, 0, 0),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 28, 6, 0),
                                          child: CircleAvatar(),
                                        ),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    2, 20, 5, 6),
                                                padding: EdgeInsets.all(8),
                                                width: 340,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Reza Rahardian",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(
                                                      "founder starup",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: Color.fromRGBO(
                                                              131,
                                                              131,
                                                              131,
                                                              1)),
                                                    ),
                                                    SizedBox(
                                                      height: 6,
                                                    ),
                                                    Text(
                                                      "Untuk  itu,  diperlukan  pemahaman  yang "
                                                      "baik  bagi  masyarakat  termasuk manfaat, "
                                                      "potensi,  dan  risiko  dari  perdagangan "
                                                      "aset  kripto. Biar tidak salah prediksinya berinvestasi",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 14),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "3h ago",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Color.fromRGBO(
                                                            131, 131, 131, 1)),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  TextButton(
                                                      onPressed: () {},
                                                      style:
                                                          TextButton.styleFrom(
                                                        minimumSize: Size.zero,
                                                        padding:
                                                            EdgeInsets.zero,
                                                        tapTargetSize:
                                                            MaterialTapTargetSize
                                                                .shrinkWrap,
                                                      ),
                                                      child: Text(
                                                        "Balas",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    2,
                                                                    62,
                                                                    138,
                                                                    1),
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12),
                                                      )),
                                                  SizedBox(width: 205),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .thumb_up_alt_outlined,
                                                        size: 20,
                                                      ),
                                                      Text(" 33")
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    10, 4, 0, 5),
                                                width: 75,
                                                height: 22,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Color.fromRGBO(
                                                        2, 62, 138, 1)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 2, 6, 6),
                                                  child: Text(
                                                    "2 Basalan",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // end comment pertama
                            ],
                          ),
                          Positioned(
                              top: 0,
                              right: 0,
                              left: 0,
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1,
                                            color: Color.fromRGBO(
                                                217, 217, 217, 1))),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20))),
                                child: Center(
                                    child: Text(
                                  "Comments",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                              )),

                          // Input komentar
                          AnimatedPositioned(
                            duration: Duration(milliseconds: 300),
                            bottom: _showInput ? 0 : -60,
                            left: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                      top: BorderSide(
                                          width: 1,
                                          style: BorderStyle.solid,
                                          color: Color.fromRGBO(
                                              217, 217, 217, 1)))),
                              padding: EdgeInsets.fromLTRB(20, 12, 0, 12),
                              height: 60,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor:
                                              Color.fromRGBO(229, 235, 243, 1),
                                          hintText: "Tuliskan komentar...",
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              height: 3.5,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(15))),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Image.asset(
                                      "assets/images/send.png",
                                      height: 30,
                                    ),
                                    onPressed: () {
                                      // Action for sending the comment
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                    );
                  },
                );
              },
              child: _getVideoAction(
                  title: '16.4k',
                  isCustomIcon: true,
                  iconPath: "assets/images/comment_icon.png"),
            ),
            GestureDetector(
              onTap: () => _toggleSave(videoIndex),
              child: _getVideoAction(
                  title: '7k',
                  isCustomIcon: true,
                  iconPath: videos[videoIndex]["isSave"]
                      ? "assets/images/save_aktif.png"
                      : "assets/images/save_icon.png"),
            ),
            SizedBox(height: 100),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: DrawerContentPage(),
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 90,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: IconButton(
            icon: Image.asset('assets/images/menu_white.png'),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: IconButton(
              onPressed: () {},
              icon: Image.asset("assets/images/search_icon.png"),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showSubscribedialog(context),
        backgroundColor: Color.fromRGBO(2, 62, 138, 1),
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: Stack(
        children: [
          PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: videos.length,
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                videoIndex = index;
              });
              _controller.dispose();
              _initializeVideoPlayer();
            },
            itemBuilder: (context, index) {
              final video = videos[index];
              return FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            });
                          },
                          child: VideoPlayer(_controller),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              videoDescription(video),
                              actionsToolbar,
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _getVideoAction(
      {required String title,
      IconData? icon,
      String? iconPath,
      bool isCustomIcon = false,
      bool isShare = false}) {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        width: ActionWidgetSize,
        height: ActionWidgetSize,
        child: Column(children: [
          isCustomIcon && iconPath != null
              ? Image.asset(iconPath,
                  width: ActionIconSize, height: ActionIconSize)
              : Icon(icon,
                  size: isShare ? ShareActionIconSize : ActionIconSize,
                  color: Colors.grey[300]),
          Padding(
            padding: EdgeInsets.only(top: isShare ? 5.0 : 2.0),
            child: Text(title,
                style: TextStyle(
                    fontSize: isShare ? 10.0 : 12.0, color: Colors.white)),
          )
        ]));
  }

  Widget _getProfileVideoAction({String}) {
    return Stack(children: [
      Container(
          margin: EdgeInsets.only(top: 10.0),
          width: ActionWidgetSize,
          height: ActionWidgetSize,
          child: Column(children: [
            Container(
              padding: EdgeInsets.all(1.0),
              height: ProfileImageSize,
              width: ProfileImageSize,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(2, 62, 138, 1),
                  border: Border.all(
                      width: 1, color: Color.fromRGBO(2, 62, 138, 1)),
                  borderRadius: BorderRadius.circular(ProfileImageSize / 2)),
              child: CachedNetworkImage(
                imageUrl:
                    "https://secure.gravatar.com/avatar/ef4a9338dca42372f15427cdb4595ef7",
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ])),
      Positioned(
          width: 15.0,
          height: 15.0,
          bottom: 5,
          left: ((ActionWidgetSize / 2) - (15 / 2)),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
          )),
      Positioned(
          bottom: 0,
          left: ((ActionWidgetSize / 2) - (FollowActionIconSize / 2)),
          child: Icon(Icons.add_circle,
              color: Color.fromARGB(255, 255, 43, 84),
              size: FollowActionIconSize))
    ]);
  }
}
