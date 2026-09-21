import 'package:flutter/material.dart';

import '../../domain/enums/direction.dart';

class DirectionFlowPad extends StatelessWidget {
  const DirectionFlowPad({
    required this.activeCue,
    required this.currentShot,
    required this.pulseIn,
    this.maxSize,
    super.key,
  });

  final DirectionCue activeCue;
  final int currentShot;
  final bool pulseIn;
  final double? maxSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final fallback = MediaQuery.sizeOf(context).width * 0.9;
        final fromConstraints = constraints.hasBoundedWidth &&
                constraints.hasBoundedHeight
            ? constraints.biggest.shortestSide
            : fallback;
        final available = fromConstraints > 0 ? fromConstraints : fallback;
        final padSize = available.clamp(200.0, maxSize ?? 700.0);
        return _buildPad(context, padSize);
      },
    );
  }

  Widget _buildPad(BuildContext context, double padSize) {
    final scale = padSize / 400;
    return SizedBox(
      width: padSize,
      height: padSize,
      child: TweenAnimationBuilder<double>(
        key: ValueKey('flow_${currentShot}_$activeCue'),
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 460),
        builder: (context, t, _) {
          final outbound = t <= 0.5;
          final phase = outbound ? (t * 2) : ((t - 0.5) * 2);
          final targetStrength = outbound
              ? Curves.easeOut.transform(phase)
              : (1 - Curves.easeIn.transform(phase));
          final centerStrength = outbound
              ? (1 - Curves.easeIn.transform(phase))
              : Curves.easeOut.transform(phase);

          double cueStrength(DirectionCue cue) {
            return activeCue == cue ? targetStrength : 0;
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _directionRow([
                _cueArrow(
                  context,
                  Icons.north_west,
                  activeCue == DirectionCue.upLeft,
                  cueStrength(DirectionCue.upLeft),
                  scale,
                ),
                _cueArrow(
                  context,
                  Icons.north,
                  activeCue == DirectionCue.up,
                  cueStrength(DirectionCue.up),
                  scale,
                ),
                _cueArrow(
                  context,
                  Icons.north_east,
                  activeCue == DirectionCue.upRight,
                  cueStrength(DirectionCue.upRight),
                  scale,
                ),
              ]),
              _directionRow([
                _cueArrow(
                  context,
                  Icons.west,
                  activeCue == DirectionCue.left,
                  cueStrength(DirectionCue.left),
                  scale,
                ),
                _centerCue(
                  context,
                  activeCue == DirectionCue.center,
                  centerStrength,
                  activeCue,
                  targetStrength,
                  padSize,
                  scale,
                ),
                _cueArrow(
                  context,
                  Icons.east,
                  activeCue == DirectionCue.right,
                  cueStrength(DirectionCue.right),
                  scale,
                ),
              ]),
              _directionRow([
                _cueArrow(
                  context,
                  Icons.south_west,
                  activeCue == DirectionCue.downLeft,
                  cueStrength(DirectionCue.downLeft),
                  scale,
                ),
                _cueArrow(
                  context,
                  Icons.south,
                  activeCue == DirectionCue.down,
                  cueStrength(DirectionCue.down),
                  scale,
                ),
                _cueArrow(
                  context,
                  Icons.south_east,
                  activeCue == DirectionCue.downRight,
                  cueStrength(DirectionCue.downRight),
                  scale,
                ),
              ]),
            ],
          );
        },
      ),
    );
  }

  Widget _directionRow(List<Widget> children) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
    );
  }

  Widget _centerCue(
    BuildContext context,
    bool active,
    double cueStrength,
    DirectionCue targetCue,
    double targetStrength,
    double padSize,
    double scale,
  ) {
    final primary = Theme.of(context).colorScheme.primary;
    final strength = cueStrength.clamp(0.0, 1.0);
    final move = targetStrength.clamp(0.0, 1.0);
    final targetOffset = _movingCueOffset(targetCue, padSize);
    final showMovingCue =
        targetCue != DirectionCue.none &&
        targetCue != DirectionCue.center &&
        move > 0.01;

    final boxSize = 58 * scale;
    final dotSize = 12 * scale;
    return SizedBox(
      width: boxSize,
      height: boxSize,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            width: (34 + (4 * strength)) * scale,
            height: (34 + (4 * strength)) * scale,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primary.withValues(
                alpha: active
                    ? (0.3 + (0.1 * strength))
                    : (0.16 + (0.06 * strength)),
              ),
              border: Border.all(
                color: primary,
                width: active ? 2.6 : 2 + strength,
              ),
            ),
          ),
          if (showMovingCue)
            Transform.translate(
              offset: Offset(targetOffset.dx * move, targetOffset.dy * move),
              child: Opacity(
                opacity: 0.85,
                child: Container(
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    color: primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Offset _movingCueOffset(DirectionCue cue, double padSize) {
    final cardinal = padSize * 0.28;
    final diagonal = padSize * 0.20;
    switch (cue) {
      case DirectionCue.up:
        return Offset(0, -cardinal);
      case DirectionCue.upLeft:
        return Offset(-diagonal, -diagonal);
      case DirectionCue.upRight:
        return Offset(diagonal, -diagonal);
      case DirectionCue.left:
        return Offset(-cardinal, 0);
      case DirectionCue.right:
        return Offset(cardinal, 0);
      case DirectionCue.downLeft:
        return Offset(-diagonal, diagonal);
      case DirectionCue.downRight:
        return Offset(diagonal, diagonal);
      case DirectionCue.down:
        return Offset(0, cardinal);
      case DirectionCue.center:
      case DirectionCue.none:
        return Offset.zero;
    }
  }

  Widget _cueArrow(
    BuildContext context,
    IconData icon,
    bool active,
    double cueStrength,
    double scale,
  ) {
    final primary = Theme.of(context).colorScheme.primary;
    final strength = cueStrength.clamp(0.0, 1.0);
    return AnimatedScale(
      scale: active
          ? (1.05 + (pulseIn ? 0.05 : 0.02) + (0.20 * strength))
          : 1.0,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        padding: EdgeInsets.all(6 * scale),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: active
              ? primary.withValues(alpha: 0.12 + (0.16 * strength))
              : Colors.transparent,
        ),
        child: Icon(
          icon,
          size: (active ? (46 + (8 * strength)) : 44) * scale,
          color: active ? primary : Colors.grey[450],
        ),
      ),
    );
  }
}
