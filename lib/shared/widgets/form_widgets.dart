import 'package:flutter/material.dart';

/// Form utilities and helpers
class FormUtils {
  FormUtils._();

  /// Unfocus all text fields
  static void unfocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  /// Move focus to next field
  static void nextFocus(BuildContext context) {
    FocusScope.of(context).nextFocus();
  }

  /// Request focus on a specific node
  static void requestFocus(BuildContext context, FocusNode node) {
    FocusScope.of(context).requestFocus(node);
  }
}

/// Form field wrapper with label and error handling
class FormFieldWrapper extends StatelessWidget {
  final String? label;
  final String? hint;
  final Widget child;
  final String? errorText;
  final bool isRequired;
  final EdgeInsetsGeometry? margin;

  const FormFieldWrapper({
    super.key,
    this.label,
    this.hint,
    required this.child,
    this.errorText,
    this.isRequired = false,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: margin ?? const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null) ...[
            Row(
              children: [
                Text(
                  label!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (isRequired)
                  Text(' *', style: TextStyle(color: theme.colorScheme.error)),
              ],
            ),
            const SizedBox(height: 8),
          ],
          child,
          if (hint != null && errorText == null) ...[
            const SizedBox(height: 4),
            Text(
              hint!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
          if (errorText != null) ...[
            const SizedBox(height: 4),
            Text(
              errorText!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Dropdown form field with styling
class AppDropdownField<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final String? hint;
  final String? errorText;
  final bool isRequired;
  final bool enabled;

  const AppDropdownField({
    super.key,
    this.value,
    required this.items,
    this.onChanged,
    this.label,
    this.hint,
    this.errorText,
    this.isRequired = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return FormFieldWrapper(
      label: label,
      hint: hint,
      errorText: errorText,
      isRequired: isRequired,
      child: DropdownButtonFormField<T>(
        initialValue: value,
        items: items,
        onChanged: enabled ? onChanged : null,
        decoration: InputDecoration(
          hintText: hint,
          errorText: errorText,
          enabled: enabled,
        ),
      ),
    );
  }
}

/// Checkbox with label
class AppCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final String label;
  final bool enabled;

  const AppCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    required this.label,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? () => onChanged?.call(!value) : null,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Checkbox(value: value, onChanged: enabled ? onChanged : null),
            Expanded(
              child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
            ),
          ],
        ),
      ),
    );
  }
}

/// Switch with label
class AppSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final String label;
  final String? subtitle;
  final bool enabled;

  const AppSwitch({
    super.key,
    required this.value,
    this.onChanged,
    required this.label,
    this.subtitle,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      onChanged: enabled ? onChanged : null,
      title: Text(label),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      contentPadding: EdgeInsets.zero,
    );
  }
}
