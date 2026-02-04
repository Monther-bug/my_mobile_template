import 'package:flutter/material.dart';

/// Responsive breakpoints
class Breakpoints {
  Breakpoints._();

  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;
  static const double largeDesktop = 1800;
}

/// Responsive utilities
class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  /// Check if current screen is mobile
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < Breakpoints.mobile;

  /// Check if current screen is tablet
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= Breakpoints.mobile && width < Breakpoints.desktop;
  }

  /// Check if current screen is desktop
  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= Breakpoints.desktop;

  /// Get current device type
  static DeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < Breakpoints.mobile) return DeviceType.mobile;
    if (width < Breakpoints.desktop) return DeviceType.tablet;
    return DeviceType.desktop;
  }

  /// Get responsive value based on screen size
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= Breakpoints.desktop) return desktop ?? tablet ?? mobile;
    if (width >= Breakpoints.mobile) return tablet ?? mobile;
    return mobile;
  }

  /// Get responsive padding
  static EdgeInsets padding(BuildContext context) {
    return value(
      context,
      mobile: const EdgeInsets.all(16),
      tablet: const EdgeInsets.all(24),
      desktop: const EdgeInsets.all(32),
    );
  }

  /// Get responsive horizontal padding
  static EdgeInsets horizontalPadding(BuildContext context) {
    return value(
      context,
      mobile: const EdgeInsets.symmetric(horizontal: 16),
      tablet: const EdgeInsets.symmetric(horizontal: 24),
      desktop: const EdgeInsets.symmetric(horizontal: 48),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width >= Breakpoints.desktop && desktop != null) {
      return desktop!;
    }
    if (width >= Breakpoints.mobile && tablet != null) {
      return tablet!;
    }
    return mobile;
  }
}

/// Device type enum
enum DeviceType { mobile, tablet, desktop }

/// Responsive builder for more control
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, DeviceType deviceType) builder;

  const ResponsiveBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return builder(context, Responsive.getDeviceType(context));
  }
}

/// Responsive grid
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final int mobileColumns;
  final int tabletColumns;
  final int desktopColumns;
  final double spacing;
  final double runSpacing;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.mobileColumns = 1,
    this.tabletColumns = 2,
    this.desktopColumns = 3,
    this.spacing = 16,
    this.runSpacing = 16,
  });

  @override
  Widget build(BuildContext context) {
    final columns = Responsive.value(
      context,
      mobile: mobileColumns,
      tablet: tabletColumns,
      desktop: desktopColumns,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth =
            (constraints.maxWidth - (spacing * (columns - 1))) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: runSpacing,
          children: children.map((child) {
            return SizedBox(width: itemWidth, child: child);
          }).toList(),
        );
      },
    );
  }
}
