import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flexi_fonts/flexi_fonts.dart';

// This example shows how to use FlexiFonts with minimal code

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Initialize the controller
  final fontController = FlexiFontController();
  await fontController.initialize();

  // 2. Provide the controller to the app
  runApp(
    ChangeNotifierProvider.value(
      value: fontController,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 3. Apply the font to your theme
    final fontController = Provider.of<FlexiFontController>(context);

    return MaterialApp(
      title: 'Minimal FlexiFonts Example',
      theme: fontController.applyToTheme(ThemeData.light()),
      home: const MinimalExample(),
    );
  }
}

class MinimalExample extends StatelessWidget {
  const MinimalExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minimal FlexiFonts Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Tap the button below to change font',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 4. Show the font selector
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: const FlexiFontSelectorWidget(),
                  ),
                );
              },
              child: const Text('Select Font'),
            ),
          ],
        ),
      ),
    );
  }
}
