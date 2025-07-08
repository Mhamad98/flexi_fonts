import 'package:flutter/material.dart';

import '../models/font_option.dart';

/// A widget for filtering fonts by category
class FontCategoryFilter extends StatelessWidget {
  /// The currently selected category
  final FontCategory? selectedCategory;
  
  /// Callback when a category is selected
  final Function(FontCategory?) onCategorySelected;
  
  /// Whether to show the "All" option
  final bool showAllOption;
  
  /// Constructor
  const FontCategoryFilter({
    super.key,
    this.selectedCategory,
    required this.onCategorySelected,
    this.showAllOption = true,
  });

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            if (showAllOption)
              _buildCategoryChip(
                context,
                null,
                isRtl ? 'هەموو' : 'All',
              ),
            _buildCategoryChip(
              context,
              FontCategory.sansSerif,
              isRtl ? 'سانس سێریف' : 'Sans Serif',
            ),
            _buildCategoryChip(
              context,
              FontCategory.serif,
              isRtl ? 'سێریف' : 'Serif',
            ),
            _buildCategoryChip(
              context,
              FontCategory.display,
              isRtl ? 'نمایشی' : 'Display',
            ),
            _buildCategoryChip(
              context,
              FontCategory.handwriting,
              isRtl ? 'دەستنووس' : 'Handwriting',
            ),
            _buildCategoryChip(
              context,
              FontCategory.monospace,
              isRtl ? 'مۆنۆسپەیس' : 'Monospace',
            ),
          ],
        ),
      ),
    );
  }

  /// Build a chip for a category
  Widget _buildCategoryChip(
    BuildContext context,
    FontCategory? category,
    String label,
  ) {
    final isSelected = category == selectedCategory || 
        (category == null && selectedCategory == null);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          if (selected) {
            onCategorySelected(category);
          } else if (isSelected && showAllOption) {
            // If deselecting the current category and "All" is an option,
            // select "All" (null)
            onCategorySelected(null);
          }
        },
        backgroundColor: Theme.of(context).colorScheme.surface,
        selectedColor: Theme.of(context).colorScheme.primaryContainer,
        checkmarkColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}