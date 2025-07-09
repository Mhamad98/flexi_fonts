import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flexi_fonts/flexi_fonts.dart';
import 'settings_page.dart';

// Import the widget files
import 'widgets/kurdish_content.dart';
import 'widgets/english_content.dart';
import 'widgets/font_info_card.dart';
import 'widgets/font_size_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool _showFontSelector = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fontController = Provider.of<FlexiFontController>(context);
    final colorScheme = Theme.of(context).colorScheme;
    final isKurdish = _tabController.index == 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.inversePrimary,
        title: Text(widget.title),
        elevation: 2,
        actions: [
          // Font scale button
          IconButton(
            icon: const Icon(Icons.format_size),
            tooltip: 'Adjust Font Size',
            onPressed: () {
              FontSizeDialog.show(context, fontController, isKurdish);
            },
          ),
          // Settings button
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Font Settings',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),
        ],
        bottom: _showFontSelector
            ? null
            : TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'کوردی'),
                  Tab(text: 'English'),
                ],
                indicatorColor: colorScheme.primary,
                indicatorWeight: 3,
                labelColor: colorScheme.primary,
                unselectedLabelColor: colorScheme.onSurfaceVariant,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
      ),
      body: _showFontSelector
          ? const Directionality(
              textDirection: TextDirection.rtl,
              child: FlexiFontSelectorWidget(
                title: 'فۆنتێک هەڵبژێرە',
                showFontScaleSlider: true,
                groupByCategory: true,
                showSearch: true,
              ),
            )
          : Column(
              children: [
                // Current font info card
                FontInfoCard(
                  fontController: fontController,
                  isKurdish: isKurdish,
                  onChangeTap: () {
                    setState(() {
                      _showFontSelector = true;
                    });
                  },
                ),

                // Content based on selected tab
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      KurdishContent(fontController: fontController),
                      EnglishContent(fontController: fontController),
                    ],
                  ),
                ),
              ],
            ),
      floatingActionButton: _showFontSelector
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  _showFontSelector = false;
                });
              },
              tooltip: 'Back to Content',
              backgroundColor: colorScheme.primaryContainer,
              foregroundColor: colorScheme.onPrimaryContainer,
              child: const Icon(Icons.arrow_back),
            )
          : null,
    );
  }
}
