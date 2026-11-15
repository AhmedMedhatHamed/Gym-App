import 'package:gym_app/core/utils/app_colors.dart';
import 'package:material_ui/material_ui.dart';
import 'package:video_player/video_player.dart';

class WorkoutVideoPreview extends StatefulWidget {
  const WorkoutVideoPreview({
    super.key,
    required this.videoPath,
    required this.imagePath,
    this.onPlayPressed,
  });

  final String videoPath;
  final String imagePath;
  final VoidCallback? onPlayPressed;

  @override
  State<WorkoutVideoPreview> createState() => _WorkoutVideoPreviewState();
}

class _WorkoutVideoPreviewState extends State<WorkoutVideoPreview> {
  VideoPlayerController? _controller;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  @override
  void didUpdateWidget(covariant WorkoutVideoPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoPath != widget.videoPath) {
      _disposeController();
      _hasError = false;
      _initController();
    }
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  void _initController() {
    final controller = VideoPlayerController.asset(widget.videoPath);
    _controller = controller;
    controller.setLooping(true);
    controller.addListener(_onControllerUpdated);
    controller.initialize().then((_) {
      if (mounted && _controller == controller) {
        setState(() {});
      }
    }).catchError((_) {
      if (mounted && _controller == controller) {
        setState(() {
          _hasError = true;
        });
      }
    });
  }

  void _disposeController() {
    _controller?.removeListener(_onControllerUpdated);
    _controller?.dispose();
    _controller = null;
  }

  void _onControllerUpdated() {
    if (mounted) {
      setState(() {});
    }
  }

  void _togglePlayPause() {
    final controller = _controller;
    if (controller != null && controller.value.isInitialized && !_hasError) {
      if (controller.value.isPlaying) {
        controller.pause();
      } else {
        controller.play();
      }
      setState(() {});
    }
    widget.onPlayPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    final bool isInitialized =
        controller != null && controller.value.isInitialized && !_hasError;
    final bool isPlaying = isInitialized && controller.value.isPlaying;

    return AspectRatio(
      aspectRatio: 16 / 10,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(
            color: AppColors.chipColor,
            width: 1.0,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _togglePlayPause,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (isInitialized)
                FittedBox(
                  fit: BoxFit.cover,
                  clipBehavior: Clip.hardEdge,
                  child: SizedBox(
                    width: controller.value.size.width,
                    height: controller.value.size.height,
                    child: VideoPlayer(controller),
                  ),
                )
              else
                Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                ),
              if (!isPlaying) ...[
                Container(
                  color: Colors.black.withValues(alpha: 0.45),
                ),
                Center(
                  child: Container(
                    width: 72.0,
                    height: 72.0,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor.withValues(alpha: 0.35),
                          blurRadius: 24.0,
                          spreadRadius: 8.0,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      color: AppColors.backgroundColor,
                      size: 42.0,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
