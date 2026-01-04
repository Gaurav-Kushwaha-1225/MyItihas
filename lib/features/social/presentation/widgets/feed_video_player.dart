import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class FeedVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final String? thumbnailUrl;
  final bool isVisible;
  final VoidCallback? onDoubleTap;

  const FeedVideoPlayer({
    super.key,
    required this.videoUrl,
    this.thumbnailUrl,
    this.isVisible = true,
    this.onDoubleTap,
  });

  @override
  State<FeedVideoPlayer> createState() => _FeedVideoPlayerState();
}

class _FeedVideoPlayerState extends State<FeedVideoPlayer>
    with SingleTickerProviderStateMixin {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _showControls = true;
  bool _isMuted = true;
  bool _hasError = false;
  Timer? _hideControlsTimer;
  bool _showLikeAnimation = false;

  late AnimationController _likeAnimationController;
  late Animation<double> _likeScaleAnimation;
  late Animation<double> _likeFadeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializePlayer();
  }

  void _initializeAnimations() {
    _likeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _likeScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.2)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
    ]).animate(_likeAnimationController);

    _likeFadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _likeAnimationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );
  }

  Future<void> _initializePlayer() async {
    if (widget.videoUrl.isEmpty) {
      setState(() => _hasError = true);
      return;
    }

    try {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      );

      await _controller!.initialize();
      _controller!.setLooping(true);
      _controller!.setVolume(_isMuted ? 0.0 : 1.0);

      _controller!.addListener(_onPlayerStateChanged);

      if (mounted) {
        setState(() => _isInitialized = true);

        if (widget.isVisible) {
          _controller!.play();
          _startHideControlsTimer();
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _hasError = true);
      }
    }
  }

  void _onPlayerStateChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didUpdateWidget(FeedVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isVisible != oldWidget.isVisible && _controller != null) {
      if (widget.isVisible) {
        _controller!.play();
        _startHideControlsTimer();
      } else {
        _controller!.pause();
        _cancelHideControlsTimer();
      }
    }

    if (widget.videoUrl != oldWidget.videoUrl) {
      _disposeController();
      _initializePlayer();
    }
  }

  void _disposeController() {
    _controller?.removeListener(_onPlayerStateChanged);
    _controller?.dispose();
    _controller = null;
    _isInitialized = false;
  }

  @override
  void dispose() {
    _cancelHideControlsTimer();
    _likeAnimationController.dispose();
    _disposeController();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_controller == null) return;

    HapticFeedback.selectionClick();
    setState(() {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
        _cancelHideControlsTimer();
      } else {
        _controller!.play();
        _startHideControlsTimer();
      }
    });
  }

  void _toggleMute() {
    if (_controller == null) return;

    HapticFeedback.selectionClick();
    setState(() {
      _isMuted = !_isMuted;
      _controller!.setVolume(_isMuted ? 0.0 : 1.0);
    });
  }

  void _showControlsTemporarily() {
    setState(() => _showControls = true);
    _startHideControlsTimer();
  }

  void _startHideControlsTimer() {
    _cancelHideControlsTimer();
    if (_controller?.value.isPlaying ?? false) {
      _hideControlsTimer = Timer(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() => _showControls = false);
        }
      });
    }
  }

  void _cancelHideControlsTimer() {
    _hideControlsTimer?.cancel();
    _hideControlsTimer = null;
  }

  void _handleDoubleTap() {
    HapticFeedback.mediumImpact();
    widget.onDoubleTap?.call();
    
    setState(() => _showLikeAnimation = true);
    _likeAnimationController.forward(from: 0.0).then((_) {
      if (mounted) {
        setState(() => _showLikeAnimation = false);
      }
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    
    if (hours > 0) {
      return '$hours:${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showControlsTemporarily,
      onDoubleTap: _handleDoubleTap,
      child: Container(
        color: Colors.black,
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildVideoContent(),

            if (_isInitialized && _controller!.value.isBuffering)
              _buildBufferingIndicator(),

            if (_showControls && _isInitialized) _buildControlsOverlay(),

            if (_isInitialized && _showControls) _buildTimeDisplay(),

            if (_isInitialized)
              Positioned(
                top: 100.h,
                right: 16.w,
                child: _buildMuteButton(),
              ),

            if (_isInitialized)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _buildProgressBar(),
              ),

            if (_showLikeAnimation) _buildLikeAnimation(),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoContent() {
    if (_hasError) {
      return _buildErrorState();
    }

    if (!_isInitialized) {
      return _buildLoadingState();
    }

    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(
        width: _controller!.value.size.width,
        height: _controller!.value.size.height,
        child: VideoPlayer(_controller!),
      ),
    );
  }

  Widget _buildLoadingState() {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (widget.thumbnailUrl != null && widget.thumbnailUrl!.isNotEmpty)
            Image.network(
              widget.thumbnailUrl!,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.grey[900],
              ),
            ),
          Center(
            child: Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.7),
                shape: BoxShape.circle,
              ),
              child: CircularProgressIndicator(
                color: colorScheme.primary,
                strokeWidth: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: Colors.grey[900],
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48.sp,
              color: colorScheme.error,
            ),
            SizedBox(height: 12.h),
            Text(
              'Failed to load video',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBufferingIndicator() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.6),
          shape: BoxShape.circle,
        ),
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 2.5,
        ),
      ),
    );
  }

  Widget _buildControlsOverlay() {
    final isPlaying = _controller?.value.isPlaying ?? false;

    return AnimatedOpacity(
      opacity: _showControls ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withValues(alpha: 0.4),
              Colors.transparent,
              Colors.black.withValues(alpha: 0.6),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: Center(
          child: GestureDetector(
            onTap: _togglePlayPause,
            child: Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                color: Colors.white,
                size: 50.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeDisplay() {
    final position = _controller?.value.position ?? Duration.zero;
    final duration = _controller?.value.duration ?? Duration.zero;

    return Positioned(
      left: 16.w,
      bottom: 40.h,
      child: AnimatedOpacity(
        opacity: _showControls ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Text(
            '${_formatDuration(position)} / ${_formatDuration(duration)}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMuteButton() {
    return AnimatedOpacity(
      opacity: _showControls ? 1.0 : 0.6,
      duration: const Duration(milliseconds: 300),
      child: GestureDetector(
        onTap: _toggleMute,
        child: Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.6),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Icon(
            _isMuted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
            color: Colors.white,
            size: 22.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return AnimatedOpacity(
      opacity: _showControls ? 1.0 : 0.3,
      duration: const Duration(milliseconds: 300),
      child: VideoProgressIndicator(
        _controller!,
        allowScrubbing: true,
        colors: VideoProgressColors(
          playedColor: Theme.of(context).colorScheme.primary,
          bufferedColor: Colors.white.withValues(alpha: 0.4),
          backgroundColor: Colors.white.withValues(alpha: 0.2),
        ),
        padding: EdgeInsets.symmetric(vertical: 4.h),
      ),
    );
  }

  Widget _buildLikeAnimation() {
    return Center(
      child: AnimatedBuilder(
        animation: _likeAnimationController,
        builder: (context, child) {
          return Opacity(
            opacity: _likeFadeAnimation.value,
            child: Transform.scale(
              scale: _likeScaleAnimation.value,
              child: Icon(
                Icons.favorite,
                color: Colors.red,
                size: 120.sp,
              ),
            ),
          );
        },
      ),
    );
  }
}
