import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'flexi_font_controller.dart';
import 'models/font_option.dart';
import 'widgets/font_category_filter.dart';
import 'widgets/font_preview_item.dart';
import 'widgets/font_scale_slider.dart';

/// A widget that displays a list of available fonts and allows the user to select one
class FlexiFontSelectorWidget extends StatefulWidget {
  /// Title for the font selector
  final String title;

  /// Whether to show the font scale slider
  final bool showFontScaleSlider;

  /// Whether to group fonts by category
  final bool groupByCategory;

  /// Whether to show a search field
  final bool showSearch;

  /// Whether to show a reset button
  final bool showResetButton;

  /// Sample text to display in the preview
  final String? sampleText;

  /// Callback when a font is selected
  final Function(FontOption)? onFontSelected;

  /// Constructor
  const FlexiFontSelectorWidget({
    super.key,
    this.title = 'Select Font',
    this.showFontScaleSlider = true,
    this.groupByCategory = false,
    this.showSearch = true,
    this.showResetButton = true,
    this.sampleText,
    this.onFontSelected,
  });

  @override
  State<FlexiFontSelectorWidget> createState() =>
      _FlexiFontSelectorWidgetState();
}

class _FlexiFontSelectorWidgetState extends State<FlexiFontSelectorWidget> {
  String _searchQuery = '';
  FontCategory? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Consumer<FlexiFontController>(
      builder: (context, controller, child) {
        if (!controller.isInitialized) {
          return const Center(child: CircularProgressIndicator());
        }

        final filteredFonts = _getFilteredFonts(controller);

        // Use a completely different approach - make everything scrollable
        return CustomScrollView(
          slivers: [
            // Header section
            SliverToBoxAdapter(
              child: _buildHeader(controller),
            ),

            // Font list
            widget.groupByCategory
                ? _buildCategorizedFontListSliver(filteredFonts, controller)
                : _buildFontListSliver(filteredFonts, controller),
          ],
        );
      },
    );
  }

  // Build the header section with title, search, filters, etc.
  Widget _buildHeader(FlexiFontController controller) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),

          // Search field
          if (widget.showSearch)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: Directionality.of(context) == TextDirection.rtl
                      ? 'گەڕان بۆ فۆنت...'
                      : 'Search fonts...',
                  prefixIcon: const Icon(Icons.search),
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),

          // Category filter
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: FontCategoryFilter(
              selectedCategory: _selectedCategory,
              onCategorySelected: (category) {
                setState(() {
                  _selectedCategory = category;
                });
              },
            ),
          ),

          // Font scale slider
          if (widget.showFontScaleSlider)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FontScaleSlider(
                value: controller.fontScale,
                onChanged: (value) {
                  controller.setFontScale(value);
                },
                label: Directionality.of(context) == TextDirection.rtl
                    ? 'قەبارەی فۆنت'
                    : 'Font Size',
              ),
            ),

          // Reset button
          if (widget.showResetButton)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextButton.icon(
                icon: const Icon(Icons.refresh),
                label: Text(Directionality.of(context) == TextDirection.rtl
                    ? 'گەڕانەوە بۆ بنەڕەتی'
                    : 'Reset to Default'),
                onPressed: () {
                  controller.resetToDefaults();
                },
              ),
            ),

          const Divider(),
        ],
      ),
    );
  }

  /// Build a simple list of fonts as a sliver
  Widget _buildFontListSliver(
      List<FontOption> fonts, FlexiFontController controller) {
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final font = fonts[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: FontPreviewItem(
                fontOption: font,
                isSelected: controller.selectedFont == font,
                fontScale: controller.fontScale,
                previewFontSize: 16.0,
                onTap: () {
                  controller.setFont(font);
                  if (widget.onFontSelected != null) {
                    widget.onFontSelected!(font);
                  }
                },
              ),
            );
          },
          childCount: fonts.length,
        ),
      ),
    );
  }

  /// Build a list of fonts grouped by category as a sliver
  Widget _buildCategorizedFontListSliver(
      List<FontOption> fonts, FlexiFontController controller) {
    // Group fonts by category
    final Map<FontCategory, List<FontOption>> categorizedFonts = {};

    for (final font in fonts) {
      if (!categorizedFonts.containsKey(font.category)) {
        categorizedFonts[font.category] = [];
      }
      categorizedFonts[font.category]!.add(font);
    }

    // Sort categories
    final categories = categorizedFonts.keys.toList()
      ..sort((a, b) => a.index.compareTo(b.index));

    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final category = categories[index];
            final categoryFonts = categorizedFonts[category]!;

            // Create a list of widgets for this category
            final List<Widget> categoryWidgets = [
              // Category header
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  _getCategoryName(category),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),

              // Fonts in this category
              ...categoryFonts.map((font) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: FontPreviewItem(
                      fontOption: font,
                      isSelected: controller.selectedFont == font,
                      fontScale: controller.fontScale,
                      previewFontSize: 16.0,
                      onTap: () {
                        controller.setFont(font);
                        if (widget.onFontSelected != null) {
                          widget.onFontSelected!(font);
                        }
                      },
                    ),
                  )),

              const SizedBox(height: 16.0),
            ];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: categoryWidgets,
            );
          },
          childCount: categories.length,
        ),
      ),
    );
  }

  /// Get filtered fonts based on search query and category
  List<FontOption> _getFilteredFonts(FlexiFontController controller) {
    var filteredFonts = controller.availableFonts;

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filteredFonts = filteredFonts.where((font) {
        return font.name.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    // Filter by category
    if (_selectedCategory != null) {
      filteredFonts = filteredFonts.where((font) {
        return font.category == _selectedCategory;
      }).toList();
    }

    return filteredFonts;
  }

  /// Get the display name for a font category
  String _getCategoryName(FontCategory category) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    switch (category) {
      case FontCategory.sansSerif:
        return isRtl ? 'سانس سێریف' : 'Sans Serif';
      case FontCategory.serif:
        return isRtl ? 'سێریف' : 'Serif';
      case FontCategory.display:
        return isRtl ? 'نمایشی' : 'Display';
      case FontCategory.handwriting:
        return isRtl ? 'دەستنووس' : 'Handwriting';
      case FontCategory.monospace:
        return isRtl ? 'مۆنۆسپەیس' : 'Monospace';
    }
  }
}
