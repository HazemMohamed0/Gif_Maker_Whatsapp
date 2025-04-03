import 'package:flutter/material.dart';
import 'package:video_trimmer/video_trimmer.dart';
import '../widgets/custom_appbar.dart';

class VideoEditScreen extends StatefulWidget {
  const VideoEditScreen({super.key});

  @override
  State<VideoEditScreen> createState() => _VideoEditScreenState();
}

class _VideoEditScreenState extends State<VideoEditScreen> {
  final Trimmer _trimmer = Trimmer();
  double _startValue = 0.0;
  double _endValue = 0.0;
  bool _isPlaying = false;
  bool _progressVisibility = false;

  void _loadVideo() async {
    // In a real app, we would get the video path from the previous screen
    // For now, we'll show a placeholder message
    setState(() {
      _progressVisibility = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadVideo();
  }

  @override
  void dispose() {
    _trimmer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Edit Video'),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: Builder(
          builder: (context) {
            return Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            VideoViewer(trimmer: _trimmer),
                            Center(
                              child: _progressVisibility
                                  ? const CircularProgressIndicator()
                                  : TextButton(
                                      onPressed: () async {
                                        bool playing = await _trimmer.videoPlaybackControl(
                                          startValue: _startValue,
                                          endValue: _endValue,
                                        );
                                        setState(() {
                                          _isPlaying = playing;
                                        });
                                      },
                                      child: Icon(
                                        _isPlaying ? Icons.pause : Icons.play_arrow,
                                        size: 50,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TrimmerView(
                      trimmer: _trimmer,
                      viewerHeight: 50,
                      viewerWidth: MediaQuery.of(context).size.width * 0.9,
                      maxVideoLength: const Duration(minutes: 10),
                      onChangeStart: (value) => _startValue = value,
                      onChangeEnd: (value) => _endValue = value,
                      onChangePlaybackState: (value) => setState(() => _isPlaying = value),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            // Save trimmed video logic would go here
                            Navigator.pushNamed(context, '/gifConverter');
                          },
                          icon: const Icon(Icons.gif),
                          label: const Text('Convert to GIF'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            // Save trimmed video logic would go here
                            Navigator.pushNamed(context, '/stickerPack');
                          },
                          icon: const Icon(Icons.emoji_emotions),
                          label: const Text('Create Stickers'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}