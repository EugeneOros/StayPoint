import 'package:flutter/material.dart';
import 'package:hotel_booking_app/presentation/widgets/hotel_card/hotel_card.dart';
import 'package:hotel_booking_app/theme/colors.dart';
import 'package:hotel_booking_app/theme/dimens.dart';

const Duration _jumpAnimationDuration = Duration(milliseconds: 700);
const Duration _tapAnimationDuration = Duration(milliseconds: 200);
const double _tapScaleBegin = 1.0;
const double _tapScaleEnd = 1.3;
const double _favoritesTabXPercentage = 0.625;
const double _favoritesTabYOffset = 40.0;
const double _jumpUpwardDistance = 50.0;
const double _jumpUpwardWeight = 0.4;
const double _jumpDownwardWeight = 0.6;
const double _jumpScaleBegin = 1.0;
const double _jumpScalePeak = 1.5;
const double _jumpScaleEnd = 0.8;
const double _opacityVisibleWeight = 0.7;
const double _opacityFadeWeight = 0.3;

class FavoriteIconButton extends StatefulWidget {
  final bool isFavorite;
  final HotelCardType type;
  final VoidCallback onTap;

  const FavoriteIconButton({
    super.key,
    required this.isFavorite,
    required this.type,
    required this.onTap,
  });

  @override
  State<FavoriteIconButton> createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<FavoriteIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: _tapAnimationDuration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: _tapScaleBegin,
      end: _tapScaleEnd,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.type == HotelCardType.normal && !widget.isFavorite) {
      _animateToFavoritesTab();
    }
    widget.onTap();
  }

  void _animateToFavoritesTab() {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final startPosition = renderBox.localToGlobal(Offset.zero);
    final startSize = renderBox.size;
    final screenSize = MediaQuery.of(context).size;

    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => _JumpingIconAnimation(
        startPosition: startPosition,
        startSize: startSize,
        screenSize: screenSize,
        icon: Icons.favorite_rounded,
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(_jumpAnimationDuration, () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _controller.forward();
      },
      onTapUp: (_) {
        _controller.reverse();
        _handleTap();
      },
      onTapCancel: () {
        _controller.reverse();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Icon(
          widget.isFavorite
              ? Icons.favorite_rounded
              : Icons.favorite_border_rounded,
          color: AppColors.white,
          size: Dimens.l,
        ),
      ),
    );
  }
}

class _JumpingIconAnimation extends StatefulWidget {
  final Offset startPosition;
  final Size startSize;
  final Size screenSize;
  final IconData icon;

  const _JumpingIconAnimation({
    required this.startPosition,
    required this.startSize,
    required this.screenSize,
    required this.icon,
  });

  @override
  State<_JumpingIconAnimation> createState() => _JumpingIconAnimationState();
}

class _JumpingIconAnimationState extends State<_JumpingIconAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _xAnimation;
  late Animation<double> _yAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: _jumpAnimationDuration,
      vsync: this,
    );

    final favoritesTabX = widget.screenSize.width * _favoritesTabXPercentage;
    final favoritesTabY = widget.screenSize.height - _favoritesTabYOffset;

    _xAnimation =
        Tween<double>(
          begin: widget.startPosition.dx + widget.startSize.width / 2,
          end: favoritesTabX,
        ).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
        );

    _yAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: widget.startPosition.dy + widget.startSize.height / 2,
          end: widget.startPosition.dy - _jumpUpwardDistance,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: _jumpUpwardWeight,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: widget.startPosition.dy - _jumpUpwardDistance,
          end: favoritesTabY,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: _jumpDownwardWeight,
      ),
    ]).animate(_controller);

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: _jumpScaleBegin,
          end: _jumpScalePeak,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: _jumpUpwardWeight,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: _jumpScalePeak,
          end: _jumpScaleEnd,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: _jumpDownwardWeight,
      ),
    ]).animate(_controller);

    _opacityAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.0),
        weight: _opacityVisibleWeight,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.0,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: _opacityFadeWeight,
      ),
    ]).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          left: _xAnimation.value - Dimens.l / 2,
          top: _yAnimation.value - Dimens.l / 2,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Icon(
                widget.icon,
                color: AppColors.backgroundBrand,
                size: Dimens.l,
              ),
            ),
          ),
        );
      },
    );
  }
}
