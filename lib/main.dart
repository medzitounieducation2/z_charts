import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:z_charts/pages/product/product_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Z-charts',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system, // Auto switch based on device
      theme: FlexThemeData.light(
        scheme: FlexScheme.greenM3, // Serious blue tone
        useMaterial3: true,
        fontFamily: GoogleFonts.poppins().fontFamily, // Clean professional font
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.greenM3,
        useMaterial3: true,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      initialRoute: '/products',
      routes: {
        '/products': (context) => ProductPage(),
      },
    );
  }
}


