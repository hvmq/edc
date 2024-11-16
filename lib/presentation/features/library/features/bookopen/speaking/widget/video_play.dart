import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

import '../../../../../home/home.dart';
import '../../../../api/repos/impl/bookmark_api.swagger.dart';
import '../../../../core/utils/color.dart';
import '../../../../core/utils/resource/assets_constant/icon_constatnt.dart';
import '../../../../generated_code/openapi.models.swagger.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl; // Accepts video URL
  final String title;
  final int bookId;
  final int chapterId;

  const VideoPlayerWidget({
    required this.videoUrl,
    required this.title,
    required this.bookId,
    required this.chapterId,
    Key? key,
  }) : super(key: key);

  @override
  VideoPlayerWidgetState createState() => VideoPlayerWidgetState();
}

class VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late Timer _timer; // Timer to update the current position
  Duration _currentPosition = Duration.zero; // Current position of the video
  bool _isMuted = false; // Mute state
  final bool _isFullScreen = false; // Fullscreen state
  bool _isLoading = true; // Loading state for buffering
  double _playbackSpeed = 1.0;
  Duration _lastSavedPosition = Duration.zero;
  final Duration _videoDuration = Duration.zero;
  final bool _hasLoadedProgress = false;
  CreateBookmarkApiRepository createBookmarkApiRepository =
      CreateBookmarkApiRepository();
  GetBookmarkApiRepository getBookmarkApiRepository =
      GetBookmarkApiRepository();
  DeleteBookmarkApiRepository deleteBookmarkApiRepository =
      DeleteBookmarkApiRepository();
  final RxList<Bookmark> _bookmarks = <Bookmark>[].obs;

  Future<void> getBookmarks() async {
    _bookmarks.clear();
    getBookmarkApiRepository
        .get_list_bookmark(widget.bookId, widget.chapterId, 100, 1)
        .then(
      (value) {
        if (value.statusCode == 200) {
          print('Bookmarks fetched successfully!');
          _bookmarks.value = value.body!;
        } else {
          print('Failed to fetch bookmarks. Status code: ${value.statusCode}');
        }
      },
    );
  }

  void saveMark({required String title, required currentPosition}) {
    createBookmarkApiRepository
        .create_bookmark(BookmarkAppRequest(
      bookId: widget.bookId,
      chapterId: widget.chapterId,
      title: title,
      position: currentPosition,
    ))
        .then(
      (value) {
        if (value.statusCode == 201) {
          print('Bookmark saved successfully!');
        } else {
          print('Failed to save bookmark. Status code: ${value.statusCode}');
        }
      },
    );
  }

  void deleteMark(int id) {
    deleteBookmarkApiRepository.delete_bookmark(id).then(
      (value) {
        if (value.statusCode == 200) {
          getBookmarks();
          print('Bookmark deleted successfully!');
        } else {
          print('Failed to delete bookmark. Status code: ${value.statusCode}');
        }
      },
    );
  }

  // Method to retrieve the current progress of the book from the server
  Future<void> _loadReadingProgress() async {
    final String accessToken = Get.find<HomeController>().accessToken;
    try {
      final response = await http.get(
        Uri.parse(
            'https://lib-dev.educhain.tech/app/api/app/reading-progress/user/${widget.bookId}'),
        headers: {
          'Authorization': 'Bearer $accessToken', // Replace with valid token
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Ensure currentPage is in milliseconds for seeking correctly
        final int currentPageMs = data[0]['currentPage'] ?? 0;

        setState(() {
          _lastSavedPosition = Duration(milliseconds: currentPageMs);
        });

        // Seek to saved position only after the video is initialized
        _initializeVideoPlayerFuture.then((_) {
          _controller.seekTo(_lastSavedPosition);
          _controller.play(); // Auto-play after seeking to the saved position
        });
      } else {
        print('Failed to load reading progress: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading reading progress: $e');
    }
  }

  // Method to save the current progress
  Future<void> _saveReadingProgress() async {
    final currentPosition = _controller.value.position;
    final totalDuration = _controller.value.duration;
    final String accessToken = Get.find<HomeController>().accessToken;
    try {
      print('currentPosition: ${currentPosition.inMilliseconds}');

      final response = await http.post(
        Uri.parse('https://lib-dev.educhain.tech/app/api/app/reading-progress'),
        headers: {
          'Authorization': 'Bearer $accessToken', // Replace with valid token
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'bookId': widget.bookId,
          'currentChapter': 0, // Use chapter ID here
          'totalChapters': 1,
          'currentPage':
              currentPosition.inMilliseconds, // Use minutes for simplicity
          'totalPage': totalDuration.inMilliseconds,
        }),
      );

      if (response.statusCode == 201) {
        print('Reading progress saved successfully.');
      } else {
        print('Failed to save reading progress: ${response.statusCode}');
      }
    } catch (e) {
      print('Error saving reading progress: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    final String accessToken = Get.find<HomeController>().accessToken;
    // Set up video player controller with video URL and headers
    _controller = VideoPlayerController.network(
      widget.videoUrl,
      httpHeaders: {
        'Authorization': 'Bearer $accessToken', // Add Bearer token here
      },
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    _initializeVideoPlayerFuture.then((_) {
      // Play the video automatically and load the saved position
      _loadReadingProgress();
    });
    // Add a listener to track video state changes
    _controller.addListener(() {
      setState(() {
        _isLoading =
            !_controller.value.isPlaying && !_controller.value.isBuffering;
        _currentPosition =
            _controller.value.position; // Update current position
      });
    });

    // Add listener to save progress periodically
    _controller.addListener(() {
      if (_controller.value.isPlaying &&
          _controller.value.position > const Duration(seconds: 5)) {
        _saveReadingProgress(); // Save every 5 seconds of playtime
      }
    });

    // Start a timer to update the current position every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_controller.value.isInitialized && _controller.value.isPlaying) {
        setState(() {
          _currentPosition =
              _controller.value.position; // Update current position
        });
      }
    });

    // Play the video automatically when the widget is initialized
    _initializeVideoPlayerFuture.then((_) {
      _controller.play();
    });
  }

  void _setPlaybackSpeed(double speed) {
    setState(() {
      _playbackSpeed = speed;
      _controller.setPlaybackSpeed(speed);
    });
  }

  void _toggleFullScreen() {
    if (_isFullScreen) {
      Navigator.of(context).pop(); // Exit fullscreen mode
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => FullScreenVideoPlayer(controller: _controller),
        ),
      ); // Navigate to fullscreen mode
    }
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when disposing
    _controller.dispose();
    _saveReadingProgress(); // Save progress when exiting the widget
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }

  void _rewind() {
    final newPosition = _currentPosition - const Duration(seconds: 15);
    _controller.seekTo(newPosition);
  }

  void _fastForward() {
    final newPosition = _currentPosition + const Duration(seconds: 15);
    _controller.seekTo(newPosition);
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted; // Toggle mute state
      _controller.setVolume(_isMuted ? 0 : 1); // Set volume to 0 or 1
    });
  }

  void _togglePlay() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause(); // Pause video
      } else {
        _controller.play(); // Play video
      }
    });
  }

  void _onSliderChanged(double value) {
    final newPosition = Duration(milliseconds: value.toInt());
    _controller.seekTo(newPosition);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Video container with a fixed height and width
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        height: 300, // Fixed height for the frame
                        width: MediaQuery.of(context)
                            .size
                            .width, // Full screen width
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Colors.blue), // Use AppColor here
                        ),
                        child: FittedBox(
                          child: SizedBox(
                            width: _controller
                                .value.size.width, // Actual video width
                            height: _controller.value.size.height,
                            child: VideoPlayer(_controller), // Display video
                          ),
                        ),
                      ),
                      // Loading indicator
                      // if (_isLoading)
                      //   CircularProgressIndicator(color: AppColor.primaryColor),
                    ],
                  ),
                  // Display title
                  Container(
                    margin:
                        const EdgeInsets.only(bottom: 4, left: 12, right: 12),
                    alignment: Alignment.center,
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        color: AppColor.textColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  // Slider for video progress
                  Slider(
                    value: _currentPosition.inMilliseconds.toDouble(),
                    max: _controller.value.duration.inMilliseconds.toDouble(),
                    onChanged: _onSliderChanged,
                    activeColor: Colors.blue, // Use AppColor here
                    inactiveColor: Colors.grey,
                    divisions: _controller.value.duration.inSeconds > 0
                        ? _controller.value.duration.inSeconds
                        : 1,
                    label: _formatDuration(_currentPosition),
                  ),

                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text(
                        //   'Thời gian: ',
                        //   style: TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 14), // Use AppColor here
                        // ),
                        Text(
                          _formatDuration(_currentPosition),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14), // Use AppColor here
                        ),
                        const SizedBox(
                            width: 8,
                            child: Text('/',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12))),
                        Text(
                          _formatDuration(_controller.value.duration),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14), // Use AppColor here
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: _toggleMute,
                        icon: Icon(
                            _isMuted ? Icons.volume_off : Icons.volume_up,
                            color: Colors.white), // Use AppColor here
                        tooltip: _isMuted ? 'Unmute' : 'Mute',
                      ),
                      GestureDetector(
                        onTap: _rewind,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            padding: EdgeInsets.zero,
                            width: 24,
                            height: 24,
                            child: Image.asset(IconConstants.tua),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _togglePlay,
                        child: Container(
                          // onPressed: _togglePlay,
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                              color: AppColor.blueColor_2,
                              borderRadius: BorderRadius.circular(50)),
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            size: 36,
                            color: AppColor.textColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _fastForward,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            padding: EdgeInsets.zero,
                            width: 24,
                            height: 24,
                            child: Image.asset(IconConstants.tua1),
                          ),
                        ),
                      ),

                      IconButton(
                        onPressed: _toggleFullScreen,
                        icon: Icon(
                          _isFullScreen
                              ? Icons.fullscreen_exit
                              : Icons.fullscreen,
                          color: Colors.white,
                        ),
                        tooltip:
                            _isFullScreen ? 'Exit Fullscreen' : 'Fullscreen',
                      ),
                      // Playback speed buttons
                      PopupMenuButton<double>(
                        color: AppColor.secondaryColor,
                        onSelected: (value) => _setPlaybackSpeed(value),
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<double>>[],
                        tooltip: 'Playback Speed',
                        child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            child: Text(
                              '${_playbackSpeed}x',
                              style: TextStyle(
                                  color: AppColor.textColor, fontSize: 16),
                            )),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buttonIcon(
                          icon: IconConstants.mark,
                          onTap: () {
                            _showSaveMarkDialog(context); // Show mark dialog
                          },
                          title: 'Mark'.tr,
                        ),
                        // buttonIcon(
                        //   icon: IconConstants.chapter,
                        //   onTap: () {
                        //     showChapterListSheet(context);
                        //   },
                        //   title: 'Chapter'.tr,
                        // ),
                        buttonIcon(
                          icon: IconConstants.speed,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: AppColor.secondaryColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                              ),
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Select Playback Speed',
                                        style: TextStyle(
                                          color: AppColor.textColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      ListTile(
                                        title: Text('1x',
                                            style: TextStyle(
                                                color: AppColor.textColor)),
                                        onTap: () {
                                          _setPlaybackSpeed(1.0);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        title: Text('1.5x',
                                            style: TextStyle(
                                                color: AppColor.textColor)),
                                        onTap: () {
                                          _setPlaybackSpeed(1.5);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        title: Text('2x',
                                            style: TextStyle(
                                                color: AppColor.textColor)),
                                        onTap: () {
                                          _setPlaybackSpeed(2.0);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        title: Text('2.5x',
                                            style: TextStyle(
                                                color: AppColor.textColor)),
                                        onTap: () {
                                          _setPlaybackSpeed(2.5);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        title: Text('3x',
                                            style: TextStyle(
                                                color: AppColor.textColor)),
                                        onTap: () {
                                          _setPlaybackSpeed(3.0);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          title: 'Speed'.tr,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              // if (_isLoading)
              //   CircularProgressIndicator(color: AppColor.primaryColor),
            ],
          );
        } else {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            height: 300,
            child: Center(
              child: CircularProgressIndicator(color: AppColor.textColor),
            ),
          );
        }
      },
    );
  }

  void showBookmarkListSheet(BuildContext context) {
    getBookmarks();
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Obx(() {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Indicator bar
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Bookmarks',
                  style: TextStyle(
                    color: AppColor.textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Bookmark List
                if (_bookmarks.isEmpty)
                  Center(
                    child: Text(
                      'No bookmarks added.',
                      style: TextStyle(color: AppColor.textColor),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: _bookmarks.length,
                      itemBuilder: (context, index) {
                        final bookmark = _bookmarks[index];
                        return ListTile(
                          leading:
                              Icon(Icons.bookmark, color: AppColor.blueColor_3),
                          title: Text(
                            bookmark.title ?? 'No title',
                            style: TextStyle(
                              color: AppColor.textColor,
                            ),
                          ),
                          subtitle: Text(
                            'Position: ${(bookmark.position / 60).toInt()}:${(bookmark.position.toInt() % 60).toString().padLeft(2, '0')} sec',
                            style: TextStyle(
                              color: AppColor.greyColor,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              deleteMark(bookmark.id); // Delete bookmark
                            },
                          ),
                          onTap: () {
                            // Seek to the saved position in the audio
                            print('Seeking to position: ${bookmark.position}');
                            _controller.seekTo(
                                Duration(seconds: bookmark.position.toInt()));
                            _currentPosition =
                                Duration(seconds: bookmark.position.toInt());
                            _controller.play();

                            Navigator.pop(context); // Close the bottom sheet
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        });
      },
    );
  }

  void _showSaveMarkDialog(BuildContext context) {
    //format the current position to a readable time format
    final String currentTime =
        'Mark at ${_currentPosition.inMinutes}:${(_currentPosition.inSeconds % 60).toString().padLeft(2, '0')}';
    final TextEditingController titleController =
        TextEditingController(text: currentTime);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Save Mark'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Enter a title for the mark',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                final String title = titleController.text;
                if (title.isNotEmpty) {
                  _saveMark(title); // Save the mark
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _saveMark(String title) {
    // Call your controller or service to save the mark
    saveMark(
      title: title,
      currentPosition: _currentPosition.inSeconds,
    );

    Get.snackbar(
      'Mark Saved',
      'Mark "$title" saved at ${_currentPosition.inMinutes}:${(_currentPosition.inSeconds % 60).toString().padLeft(2, '0')}',
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
      backgroundColor: Colors.blueAccent,
    );
  }

  Widget buttonIcon(
      {required String icon,
      required Function() onTap,
      required String title}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColor.textColor.withOpacity(0.1),
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                padding: EdgeInsets.zero,
                width: 24,
                height: 24,
                child: Image.asset(icon),
              ),
            ),
            Text(
              title,
              style: TextStyle(color: AppColor.textColor),
            )
          ],
        ),
      ),
    );
  }
}

class FullScreenVideoPlayer extends StatelessWidget {
  final VideoPlayerController controller;

  const FullScreenVideoPlayer({required this.controller, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor, // Fullscreen background color
      appBar: AppBar(
        leadingWidth: 0,
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        title: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.arrow_back,
                            color: AppColor.textColor,
                          ),
                          alignment: PlaceholderAlignment.middle,
                        ),
                        const WidgetSpan(child: SizedBox(width: 12)),
                        TextSpan(
                          text: 'Back'.tr,
                          style: TextStyle(
                            color: AppColor.textColor,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        ),
      ),
      // Fullscreen controls can be added here if needed
    );
  }
}
