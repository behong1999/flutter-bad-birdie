import 'package:flutter/material.dart';

import '../../domain/direction.dart';

class DirectionFlowPad extends StatelessWidget {
  const DirectionFlowPad({
    super.key,
    required this.activeCue,
    required this.currentShot,
    required this.pulseIn,
  });

  final DirectionCue activeCue;
  final int currentShot;
  final bool pulseIn;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final padSize = (screenWidth * 0.9).clamp(200.0, 400.0);
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
                ),
                _cueArrow(
                  context,
                  Icons.north,
                  activeCue == DirectionCue.up,
                  cueStrength(DirectionCue.up),
                ),
                _cueArrow(
                  context,
                  Icons.north_east,
                  activeCue == DirectionCue.upRight,
                  cueStrength(DirectionCue.upRight),
                ),
              ]),
              _directionRow([
                _cueArrow(
                  context,
                  Icons.west,
                  activeCue == DirectionCue.left,
                  cueStrength(DirectionCue.left),
                ),
                _centerCue(
                  context,
                  activeCue == DirectionCue.center,
                  centerStrength,
                  activeCue,
                  targetStrength,
                  padSize,
                ),
                _cueArrow(
                  context,
                  Icons.east,
                  activeCue == DirectionCue.right,
                  cueStrength(DirectionCue.right),
                ),
              ]),
              _directionRow([
                _cueArrow(
                  context,
                  Icons.south_west,
                  activeCue == DirectionCue.downLeft,
                  cueStrength(DirectionCue.downLeft),
                ),
                _cueArrow(
                  context,
                  Icons.south,
                  activeCue == DirectionCue.down,
                  cueStrength(DirectionCue.down),
                ),
                _cueArrow(
                  context,
                  Icons.south_east,
                  activeCue == DirectionCue.downRight,
                  cueStrength(DirectionCue.downRight),
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
  ) {
    final primary = Theme.of(context).colorScheme.primary;
    final strength = cueStrength.clamp(0.0, 1.0);
    final move = targetStrength.clamp(0.0, 1.0);
    final targetOffset = _movingCueOffset(targetCue, padSize);
    final showMovingCue =
        targetCue != DirectionCue.none &&
        targetCue != DirectionCue.center &&
        move > 0.01;

    return SizedBox(
      width: 58,
      height: 58,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            width: 34 + (4 * strength),
            height: 34 + (4 * strength),
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
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(color: primary, shape: BoxShape.circle),
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
  ) {
    final primary = Theme.of(context).colorScheme.primary;
    final strength = cueStrength.clamp(0.0, 1.0);
    return AnimatedScale(
      scale: active ? (1.05 + (pulseIn ? 0.05 : 0.02) + (0.20 * strength)) : 1.0,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: active
              ? primary.withValues(alpha: 0.12 + (0.16 * strength))
              : Colors.transparent,
        ),
        child: Icon(
          icon,
          size: active ? (46 + (8 * strength)) : 44,
          color: active ? primary : Colors.grey[450],
        ),
      ),
    );
  }
}
