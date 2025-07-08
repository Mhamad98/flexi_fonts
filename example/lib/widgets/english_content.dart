import 'package:flutter/material.dart';
import 'package:flexi_fonts/flexi_fonts.dart';
import 'local_fonts_showcase.dart';

/// Widget that displays the English content tab
class EnglishContent extends StatelessWidget {
  final FlexiFontController fontController;

  const EnglishContent({
    super.key, 
    required this.fontController,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with gradient background
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorScheme.primary,
                  colorScheme.primaryContainer,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Font Examples',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Typography Showcase for FlexiFonts',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: colorScheme.onPrimary.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),
          
          // Info card
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: colorScheme.primary),
                      const SizedBox(width: 8.0),
                      Text(
                        'About FlexiFonts',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    'This package allows you to change your app\'s font at runtime. You can select your preferred font and adjust its size. It also supports right-to-left languages like Arabic and Kurdish.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          
          // Font sample card
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.text_format, color: colorScheme.primary),
                      const SizedBox(width: 8.0),
                      Text(
                        'Font Sample',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24.0),
                  Text(
                    'The quick brown fox jumps over the lazy dog.',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'This is a paragraph with the current font. This text demonstrates how the selected font looks in a paragraph format with normal body text size. You can see the details of each character and how they flow together.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      _buildFontSizeChip('Small', 12.0,context),
                      _buildFontSizeChip('Medium', 16.0,context),
                      _buildFontSizeChip('Large', 20.0,context),
                      _buildFontSizeChip('Extra Large', 24.0,context),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          
          // RTL support card
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            color: colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.translate, 
                        color: colorScheme.onPrimaryContainer,
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          'RTL Language Support',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: colorScheme.onPrimaryContainer.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Arabic Example:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text(
                            'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة. هذا مجرد نموذج لشكل النص.',
                            style: TextStyle(
                              color: colorScheme.onPrimaryContainer,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          
          // Custom styled text with card
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.text_fields, color: Colors.purple),
                      SizedBox(width: 8.0),
                      Text(
                        'Custom Styling Example:',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: Colors.purple.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      'This text uses custom styling with the selected font applied.',
                      style: fontController.getTextStyle(
                        baseStyle: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.purple,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Local fonts showcase
          const SizedBox(height: 24.0),
          LocalFontsShowcase(
            fontController: fontController,
            isKurdish: false,
          ),
          
          // Font features card
          const SizedBox(height: 24.0),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle_outline, color: colorScheme.primary),
                      const SizedBox(width: 8.0),
                      Text(
                        'FlexiFonts Features',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                
                // Feature list
                _buildFeatureTile(
                  'Google Fonts Integration',
                  'Access to hundreds of fonts from Google Fonts library',
                  colorScheme,
                  Icons.cloud_download,
                ),
                const Divider(height: 1),
                _buildFeatureTile(
                  'Local Fonts Support',
                  'Use custom fonts from your project assets',
                  colorScheme,
                  Icons.font_download_outlined,
                ),
                const Divider(height: 1),
                _buildFeatureTile(
                  'Runtime Font Switching',
                  'Change fonts without restarting your app',
                  colorScheme,
                  Icons.swap_horiz,
                ),
                const Divider(height: 1),
                _buildFeatureTile(
                  'Font Scaling',
                  'Adjust text size for better accessibility',
                  colorScheme,
                  Icons.format_size,
                ),
                const Divider(height: 1),
                _buildFeatureTile(
                  'Persistent Settings',
                  'Font choices are saved between app sessions',
                  colorScheme,
                  Icons.save,
                ),
              ],
            ),
          ),
          
          // Footer
          const SizedBox(height: 32.0),
          Center(
            child: Text(
              'FlexiFonts - Font Switching Package for Flutter',
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 12.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
  
  // Helper method to build font size chips
  Widget _buildFontSizeChip(String label, double fontSize,context) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(fontSize: fontSize),
      ),
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
    );
  }
  
  // Helper method to build feature tiles
  Widget _buildFeatureTile(
    String title, 
    String description, 
    ColorScheme colorScheme,
    IconData icon,
  ) {
    return ExpansionTile(
      leading: Icon(icon, color: colorScheme.primary),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
          child: Text(
            description,
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 14.0,
            ),
          ),
        ),
      ],
    );
  }
}