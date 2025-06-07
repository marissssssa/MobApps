// video_player_page.dart
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerPage extends StatefulWidget {
  final String title;
  final String videoUrl; // Bisa berupa URL lokal (assets) atau URL jaringan

  const VideoPlayerPage({
    super.key,
    required this.title,
    required this.videoUrl,
  });

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  VideoPlayerController? _videoPlayerController; // Jadikan nullable
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    // Periksa apakah videoUrl adalah aset lokal atau URL jaringan
    if (widget.videoUrl.startsWith('assets/')) {
      _videoPlayerController = VideoPlayerController.asset(widget.videoUrl);
    } else {
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    }

    try {
      await _videoPlayerController!.initialize();
      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController!,
          autoPlay: true,
          looping: false,
          // Tambahan kontrol UI
          materialProgressColors: ChewieProgressColors(
            playedColor: Colors.blue,
            handleColor: Colors.blueAccent,
            backgroundColor: Colors.grey,
            bufferedColor: Colors.lightBlue,
          ),
        );
      });
    } catch (e) {
      print('Error initializing video player: $e');
      if (mounted) { // Pastikan widget masih ada sebelum setState atau menampilkan SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error memuat video: ${e.toString()}')),
        );
        // Anda bisa menambahkan state error di sini jika ingin menampilkan UI error
      }
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose(); 
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized
            ? AspectRatio(
                aspectRatio: _videoPlayerController!.value.aspectRatio,
                child: Chewie(
                  controller: _chewieController!,
                ),
              )
            : const CircularProgressIndicator(), // Indikator loading
      ),
    );
  }
}