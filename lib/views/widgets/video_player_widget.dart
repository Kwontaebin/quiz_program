import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String assetPath;
  final VoidCallback? onEnded;
  final bool isLooping;

  const VideoPlayerWidget({
    super.key,
    required this.assetPath,
    this.onEnded,
    this.isLooping = false,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  @override
  void didUpdateWidget(VideoPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.assetPath != widget.assetPath) {
      _isInitialized = false; // 새 영상 준비를 위해 상태 초기화
      if (_controller != null) {
        _controller!.removeListener(_videoListener);
        _controller!.dispose();
      }
      _initializePlayer();
    }
  }

  Future<void> _initializePlayer() async {
    final VideoPlayerController newController = VideoPlayerController.asset(widget.assetPath);
    
    try {
      await newController.initialize();
      
      if (!mounted) {
        await newController.dispose();
        return;
      }

      setState(() {
        _controller = newController;
        _isInitialized = true;
      });
      
      if (widget.isLooping) {
        await _controller!.setLooping(true);
      }
      
      _controller!.addListener(_videoListener);
      await _controller!.play();
    } catch (e) {
      debugPrint('Error initializing video player: $e');
    }
  }

  void _videoListener() {
    if (widget.isLooping) return;
    if (_controller != null && _controller!.value.position >= _controller!.value.duration) {
      _controller!.removeListener(_videoListener);
      widget.onEnded?.call();
    }
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller!.removeListener(_videoListener);
      _controller!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 초기화 전에는 빈 화면(투명)을 반환하여 뒤의 이미지가 보이게 함
    if (!_isInitialized || _controller == null) {
      return const SizedBox.shrink();
    }

    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: _controller!.value.size.width,
          height: _controller!.value.size.height,
          child: VideoPlayer(_controller!),
        ),
      ),
    );
  }
}
