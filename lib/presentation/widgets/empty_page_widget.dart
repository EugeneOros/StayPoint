import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_booking_app/theme/colors.dart';
import 'package:hotel_booking_app/theme/dimens.dart';
import 'package:hotel_booking_app/theme/text_theme.dart';

const Duration _animationDuration = Duration(seconds: 4);
const double _levitationDistance = 5.0;

class EmptyPageWidget extends StatefulWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final double? imageWidth;
  final double? imageHeight;

  const EmptyPageWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    this.imageWidth,
    this.imageHeight,
  });

  @override
  State<EmptyPageWidget> createState() => _EmptyPageWidgetState();
}

class _EmptyPageWidgetState extends State<EmptyPageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _animationDuration, vsync: this)
      ..repeat(reverse: true);

    _animation = Tween<double>(
      begin: -_levitationDistance,
      end: _levitationDistance,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(Dimens.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _animation.value),
                  child: child,
                );
              },
              child: SvgPicture.asset(
                widget.imagePath,
                width: widget.imageWidth ?? 200,
                height: widget.imageHeight ?? 200,
              ),
            ),
            SizedBox(height: Dimens.xl),
            Text(
              widget.title,
              style: AppTextTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Dimens.m),
            Text(
              widget.subtitle,
              style: AppTextTheme.labelSmall.copyWith(
                color: AppColors.contentSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
