import 'package:flutter/material.dart';
import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/extensions/navigator_extension.dart';
import '../../../../core/layout/responsive_breakpoint.dart';
import '../../../../core/layout/responsive_center.dart';
import '../../../footwork/presentation/screens/setup_screen.dart';
import '../../../settings/presentation/screens/settings_screen.dart';
import '../../../tactical_board/presentation/screens/tactical_board_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.homeTitle),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: context.l10n.settings,
            onPressed: () => context.push<void>(const SettingsScreen()),
          ),
        ],
      ),
      body: ResponsiveCenter(
        maxWidth: 840,
        child: ListView(
          padding: EdgeInsets.only(
            top: 16,
            bottom: 16,
            left: context.isPhoneWidth ? 0 : 8,
            right: context.isPhoneWidth ? 0 : 8,
          ),
          physics: const ClampingScrollPhysics(),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.sports_tennis,
                          size: context.responsiveValue(
                            phone: 32.0,
                            tablet: 36.0,
                            desktop: 40.0,
                          ),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            context.l10n.welcomeTitle,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      context.l10n.welcomeDescription,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              context.l10n.trainingFeatures,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _FeatureGrid(
              children: [
                _buildFeatureCard(
                  context,
                  icon: Icons.directions_run,
                  title: context.l10n.footworkTraining,
                  description: context.l10n.footworkDescription,
                  color: Theme.of(context).colorScheme.primary,
                  onTap: () => context.push<void>(const SetupScreen()),
                ),
                _buildFeatureCard(
                  context,
                  icon: Icons.messenger_outline_sharp,
                  title: context.l10n.tacticalBoard,
                  description: context.l10n.tacticalDescription,
                  color: Theme.of(context).colorScheme.secondary,
                  onTap: () => context.push<void>(const TacticalBoardScreen()),
                ),
                _buildFeatureCard(
                  context,
                  icon: Icons.school,
                  title: context.l10n.learningHub,
                  description: context.l10n.learningDescription,
                  color: Theme.of(context).colorScheme.tertiary,
                  comingSoon: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    VoidCallback? onTap,
    bool comingSoon = false,
  }) {
    final card = Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: comingSoon ? null : onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (!comingSoon)
                Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  size: 16,
                ),
            ],
          ),
        ),
      ),
    );

    if (!comingSoon) return card;
    return Stack(
      children: [
        Opacity(opacity: 0.55, child: card),
        Positioned(
          top: 4,
          right: 4,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              context.l10n.comingSoon,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FeatureGrid extends StatelessWidget {
  const _FeatureGrid({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    if (context.isPhoneWidth) {
      return Column(
        spacing: 12,
        children: children,
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 720 || children.length < 2) {
          return Column(spacing: 12, children: children);
        }

        final columnWidth = (constraints.maxWidth - 12) / 2;
        return Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: children[0]),
                Expanded(child: children[1]),
              ],
            ),
            if (children.length > 2)
              SizedBox(width: columnWidth, child: children[2]),
          ],
        );
      },
    );
  }
}
