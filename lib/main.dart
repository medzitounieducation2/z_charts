import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:z_charts/_examples/sample_app/pages/product/product_page.dart';
import 'package:z_charts/_examples/sample_app/services/sample_chart_params_builder.dart';
import 'package:z_charts/_examples/sample_app/services/sample_chart_params_service.dart';
import 'package:z_charts/exportable/services/z_params_builder.dart';
import 'package:z_charts/exportable/services/z_params_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<ZParamsService>.value(value: SampleChartParamsService()),
        Provider<ZParamsBuilder>.value(value: SampleChartParamsBuilder()),
      ],
      child: MyApp(),
    ),
   );
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


