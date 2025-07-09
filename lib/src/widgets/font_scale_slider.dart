import 'package:flutter/material.dart';

/// A widget that allows the user to adjust the font scale
class FontScaleSlider extends StatelessWidget {
  /// The current font scale value
  final double value;

  /// Callback when the font scale changes
  final ValueChanged<double> onChanged;

  /// Minimum scale value
  final double min;

  /// Maximum scale value
  final double max;

  /// Number of divisions in the slider
  final int? divisions;

  /// Label to display above the slider
  final String? label;

  /// Constructor
  const FontScaleSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0.8,
    this.max = 1.5,
    this.divisions = 7,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              label!,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),

        // Slider with labels
        Row(
          children: [
            const Icon(Icons.text_decrease, size: 20),
            Expanded(
              child: Slider(
                value: value,
                min: min,
                max: max,
                divisions: divisions,
                label: value.toStringAsFixed(1),
                onChanged: onChanged,
              ),
            ),
            const Icon(Icons.text_increase, size: 20),
          ],
        ),

        // Current value indicator
        Center(
          child: Text(
            Directionality.of(context) == TextDirection.rtl
                ? '${(value * 100).round()}٪' // Arabic percentage sign
                : '${(value * 100).round()}%',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
