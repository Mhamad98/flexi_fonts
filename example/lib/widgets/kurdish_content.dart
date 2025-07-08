import 'package:flutter/material.dart';
import 'package:flexi_fonts/flexi_fonts.dart';
import 'local_fonts_showcase.dart';

/// Widget that displays the Kurdish content tab
class KurdishContent extends StatelessWidget {
  final FlexiFontController fontController;

  const KurdishContent({
    super.key, 
    required this.fontController,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
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
                    'فۆنتی کوردی',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'نموونەی فۆنتەکان بۆ زمانی کوردی',
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
                          'دەربارەی پاکێجەکە',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      'ئەم پاکێجە بۆ گۆڕینی فۆنتی ئەپەکەت بەکاردێت لە کاتی کارکردندا. دەتوانیت فۆنتی دڵخوازت هەڵبژێریت و قەبارەکەی بگۆڕیت. هەروەها پشتگیری زمانی کوردی و عەرەبی دەکات.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            
            // Kurdish poem with decorative elements
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
                border: Border.all(
                  color: colorScheme.outline.withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.format_quote, color: colorScheme.primary),
                      const SizedBox(width: 8.0),
                      Text(
                        'هۆنراوەی کوردی',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24.0),
                  Text(
                    'ئەی ڕەقیب هەر ماوە قەومی کورد زمان\n'
                    'نایشکێنێ دانەری تۆپی زەمان\n'
                    'کەس نەڵێ کورد مردووە، کورد زیندووە\n'
                    'زیندووە قەت نانەوێ ئاڵاکەمان',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.8,
                      letterSpacing: 0.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '- سروودی نەتەوەیی کوردستان',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),
            
            // Kurdish proverbs with list tiles
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
                        Icon(Icons.auto_stories, 
                          color: colorScheme.onPrimaryContainer,
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          'پەندی پێشینان',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    
                    // Using ListTile for each proverb
                    _buildProverbTile(
                      'دار بە میوەوە دەناسرێتەوە، پیاو بە کردەوە',
                      colorScheme,
                    ),
                    _buildProverbTile(
                      'دەستی بەتاڵ، زمانی لاڵ',
                      colorScheme,
                    ),
                    _buildProverbTile(
                      'دۆست لە ڕۆژی تەنگانەدا دەناسرێتەوە',
                      colorScheme,
                    ),
                    _buildProverbTile(
                      'بەردی گەورە نیشانەی نەزانییە',
                      colorScheme,
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
                          'نموونەی ستایلی تایبەت:',
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
                        'ئەم دەقە ستایلێکی تایبەتی هەیە کە فۆنتی هەڵبژێردراوی تێدا بەکارهاتووە.',
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
            
            const SizedBox(height: 24.0),
            
            // Local fonts showcase
            LocalFontsShowcase(
              fontController: fontController,
              isKurdish: true,
            ),
            
            const SizedBox(height: 24.0),
            
            // Kurdish dialects with tabs
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
                        Icon(Icons.translate, color: colorScheme.primary),
                        const SizedBox(width: 8.0),
                        Text(
                          'زاراوەکانی کوردی',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  
                  // Dialect examples
                  _buildDialectTile(
                    'سۆرانی',
                    'ئەمە نموونەیەکە بۆ زاراوەی سۆرانی کە لە ناوەڕاست و ڕۆژهەڵاتی کوردستان قسەی پێدەکرێت.',
                    colorScheme,
                    Icons.circle,
                    Colors.red,
                  ),
                  const Divider(height: 1),
                  _buildDialectTile(
                    'کرمانجی',
                    'ئەڤە نموونەیەکە بۆ زاراڤێ کورمانجی کە لە باکووری کوردستان قسەی پێدەکرێت.',
                    colorScheme,
                    Icons.circle,
                    Colors.blue,
                  ),
                  const Divider(height: 1),
                  _buildDialectTile(
                    'هەورامی',
                    'ئینە نموونەیێکەن سە زاراوەی هەورامی کە لە ناوچەی هەورامان قسەی پێدەکرێت.',
                    colorScheme,
                    Icons.circle,
                    Colors.green,
                  ),
                ],
              ),
            ),
            
            // Footer
            const SizedBox(height: 32.0),
            Center(
              child: Text(
                'فلێکسی فۆنت - پاکێجی گۆڕینی فۆنت بۆ فلەتەر',
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
      ),
    );
  }
  
  // Helper method to build proverb list tiles
  Widget _buildProverbTile(String proverb, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.format_quote,
            size: 16,
            color: colorScheme.onPrimaryContainer.withOpacity(0.7),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              proverb,
              style: TextStyle(
                color: colorScheme.onPrimaryContainer,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // Helper method to build dialect tiles
  Widget _buildDialectTile(
    String title, 
    String description, 
    ColorScheme colorScheme,
    IconData icon,
    Color iconColor,
  ) {
    return ExpansionTile(
      title: Row(
        children: [
          Icon(icon, color: iconColor, size: 12),
          const SizedBox(width: 8.0),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ],
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