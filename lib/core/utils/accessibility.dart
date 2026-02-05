import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

/// Accessibility utilities and helpers
class A11y {
  A11y._();

  /// Announce message to screen readers
  static void announce(String message, {TextDirection? textDirection}) {
    SemanticsService.announce(message, textDirection ?? TextDirection.ltr);
  }

  /// Create semantic label for buttons
  static String buttonLabel(String action, {String? target}) {
    if (target != null) {
      return '$action $target';
    }
    return action;
  }

  /// Create semantic label for images
  static String imageLabel(String description) {
    return 'Image: $description';
  }

  /// Create semantic label for icons
  static String iconLabel(String meaning) {
    return meaning;
  }
}

/// Semantic wrapper for better accessibility
class SemanticWrapper extends StatelessWidget {
  final Widget child;
  final String? label;
  final String? hint;
  final String? value;
  final bool? button;
  final bool? header;
  final bool? link;
  final bool? image;
  final bool? textField;
  final bool? slider;
  final bool? toggled;
  final bool? checked;
  final bool? selected;
  final bool? enabled;
  final bool? focused;
  final bool? hidden;
  final bool? obscured;
  final bool? multiline;
  final bool? readOnly;
  final bool? liveRegion;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onDismiss;
  final int? sortKey;

  const SemanticWrapper({
    super.key,
    required this.child,
    this.label,
    this.hint,
    this.value,
    this.button,
    this.header,
    this.link,
    this.image,
    this.textField,
    this.slider,
    this.toggled,
    this.checked,
    this.selected,
    this.enabled,
    this.focused,
    this.hidden,
    this.obscured,
    this.multiline,
    this.readOnly,
    this.liveRegion,
    this.onTap,
    this.onLongPress,
    this.onDismiss,
    this.sortKey,
  });

  @override
  Widget build(BuildContext context) {
    Widget result = Semantics(
      label: label,
      hint: hint,
      value: value,
      button: button,
      header: header,
      link: link,
      image: image,
      textField: textField,
      slider: slider,
      toggled: toggled,
      checked: checked,
      selected: selected,
      enabled: enabled,
      focused: focused,
      hidden: hidden,
      obscured: obscured,
      multiline: multiline,
      readOnly: readOnly,
      liveRegion: liveRegion,
      onTap: onTap,
      onLongPress: onLongPress,
      onDismiss: onDismiss,
      child: child,
    );

    if (sortKey != null) {
      result = MergeSemantics(
        child: Semantics(
          sortKey: OrdinalSortKey(sortKey!.toDouble()),
          child: result,
        ),
      );
    }

    return result;
  }
}

/// Accessible button with proper semantics
class AccessibleButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final String semanticLabel;
  final String? semanticHint;
  final bool enabled;

  const AccessibleButton({
    super.key,
    required this.onPressed,
    required this.child,
    required this.semanticLabel,
    this.semanticHint,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: enabled,
      label: semanticLabel,
      hint: semanticHint,
      child: ExcludeSemantics(
        child: child,
      ),
    );
  }
}

/// Accessible image with description
class AccessibleImage extends StatelessWidget {
  final ImageProvider image;
  final String semanticLabel;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const AccessibleImage({
    super.key,
    required this.image,
    required this.semanticLabel,
    this.width,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      image: true,
      label: semanticLabel,
      child: Image(
        image: image,
        width: width,
        height: height,
        fit: fit,
        semanticLabel: semanticLabel,
      ),
    );
  }
}

/// Screen reader only text (visible to screen readers but not visually)
class ScreenReaderOnly extends StatelessWidget {
  final String text;

  const ScreenReaderOnly({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: text,
      child: const SizedBox.shrink(),
    );
  }
}

/// Exclude from semantics (for decorative elements)
class Decorative extends StatelessWidget {
  final Widget child;

  const Decorative({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(child: child);
  }
}

/// Extensions for accessibility
extension AccessibilityExtensions on Widget {
  /// Add semantic label to widget
  Widget withSemanticLabel(String label) {
    return Semantics(label: label, child: this);
  }

  /// Mark widget as a button
  Widget asButton({String? label, String? hint}) {
    return Semantics(
      button: true,
      label: label,
      hint: hint,
      child: this,
    );
  }

  /// Mark widget as a header
  Widget asHeader({String? label}) {
    return Semantics(
      header: true,
      label: label,
      child: this,
    );
  }

  /// Exclude widget from screen readers
  Widget excludeSemantics() {
    return ExcludeSemantics(child: this);
  }

  /// Mark as live region (announces changes)
  Widget asLiveRegion({String? label}) {
    return Semantics(
      liveRegion: true,
      label: label,
      child: this,
    );
  }
}
