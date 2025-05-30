import 'package:flutter/material.dart';
import 'package:z_charts/charts/zc3_lines_chart.dart';
import 'package:z_charts/pages/charts/zc2_line_bar_page.dart';
import 'package:z_charts/pages/home/home_page.dart';
import 'package:z_charts/pages/product/product_page.dart';

class AppMenu extends StatelessWidget {
  const AppMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),

          ListTile(
            title: Row(
              spacing: 10,
              children: [Icon(Icons.home), Text('Home')],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          ),
          ListTile(
            title: Row(
              spacing: 10,
              children: [Icon(Icons.stacked_line_chart), Text('Line & Bar')],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Zc2LineBarPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Row(
              spacing: 10,
              children: [Icon(Icons.stacked_line_chart), Text('3 lines')],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Zc3LinesChart(),
                ),
              );
            },
          ),
          ListTile(
            title: Row(
              spacing: 10,
              children: [Icon(Icons.directions_walk), Text('Product')],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductPage(),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Version: 1.0.0',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
