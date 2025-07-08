import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flexi_fonts/flexi_fonts.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final fontController = Provider.of<FlexiFontController>(context);
    
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ڕێکخستنەکانی فۆنت'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kurdish font recommendations
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'فۆنتە پێشنیارکراوەکان بۆ کوردی',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      
                      _buildFontRecommendation(
                        context, 
                        'Noto Sans Arabic', 
                        'باشترین فۆنت بۆ نووسینی کوردی بە شێوەیەکی ڕوون',
                        fontController,
                      ),
                      
                      const Divider(),
                      
                      _buildFontRecommendation(
                        context, 
                        'Noto Naskh Arabic', 
                        'فۆنتێکی جوان بۆ دەقی درێژ و خوێندنەوە',
                        fontController,
                      ),
                      
                      const Divider(),
                      
                      _buildFontRecommendation(
                        context, 
                        'Amiri', 
                        'فۆنتێکی کلاسیکی بۆ نووسینی جوان',
                        fontController,
                      ),
                      
                      const Divider(),
                      
                      _buildFontRecommendation(
                        context, 
                        'Cairo', 
                        'فۆنتێکی مۆدێرن و ڕوون بۆ ناونیشان',
                        fontController,
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16.0),
              
              // Font selector
              const Expanded(
                child: FlexiFontSelectorWidget(
                  title: 'فۆنتێک هەڵبژێرە',
                  showFontScaleSlider: true,
                  groupByCategory: true,
                  showSearch: true,
                  showResetButton: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildFontRecommendation(
    BuildContext context, 
    String fontName, 
    String description,
    FlexiFontController controller,
  ) {
    final isSelected = controller.selectedFont?.fontFamily == fontName;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fontName,
                  style: GoogleFonts.getFont(
                    fontName,
                    textStyle: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  description,
                  style: GoogleFonts.getFont(
                    fontName,
                    textStyle: const TextStyle(fontSize: 14.0),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: isSelected ? null : () {
              controller.setFont(FontOption(
                fontFamily: fontName,
                isGoogleFont: true,
              ));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('فۆنتی $fontName هەڵبژێردرا'),
                ),
              );
            },
            child: Text(isSelected ? 'هەڵبژێردراوە' : 'هەڵبژاردن'),
          ),
        ],
      ),
    );
  }
}

class FontSettingsCard extends StatelessWidget {
  const FontSettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final fontController = Provider.of<FlexiFontController>(context);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ڕێکخستنەکانی فۆنتی ئێستا',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            
            // Font family
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('ناوی فۆنت:'),
                Text(
                  fontController.selectedFont?.fontFamily ?? 'هیچ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            
            // Font type
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('جۆری فۆنت:'),
                Text(
                  fontController.selectedFont?.isGoogleFont ?? false
                      ? 'فۆنتی گووگڵ'
                      : 'فۆنتی سیستەم',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            
            // Font scale
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('قەبارەی فۆنت:'),
                Text(
                  '${(fontController.fontScale * 100).round()}%',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            
            // Change font button
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.font_download),
                label: const Text('گۆڕینی فۆنت'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}