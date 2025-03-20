import 'package:flutter/material.dart';
import 'package:nike_ui_chalenge/products_main_widget.dart';
import 'package:nike_ui_chalenge/product_widget.dart';

import 'category_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nike',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        fontFamily: 'Belanosima',
        textTheme: const TextTheme(
          headlineLarge:
              TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
          titleMedium: TextStyle(
              color: Colors.black45,
              fontWeight: FontWeight.normal,
              fontSize: 14),
          titleSmall: TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 12),
          labelLarge: TextStyle(
              color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 18),
          labelSmall:
              TextStyle(color: Colors.white70, fontWeight: FontWeight.normal),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            textStyle: Theme.of(context).textTheme.titleMedium
          ),
        ),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: ""),
        ],
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.black12.withOpacity(.03),
      ),
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * .12,
                color: Colors.black12.withOpacity(.03),
              ),),
          ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Discover',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      tooltip: 'Search',
                      icon: const Icon(Icons.search),
                    ),
                    IconButton(
                      onPressed: () {},
                      tooltip: 'Notification',
                      icon: const Icon(Icons.notifications),
                    ),
                  ],
                ),
              ),
              const CategoryWidget(
                categories: ['Nike', 'Adidas', 'Jordan', 'Puma'],
              ),
              const SizedBox(
                height: 16,
              ),
              const ProductMainView(),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'More',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward))
                  ],
                ),
              ),
              ProductWidget(),
              const SizedBox(height: 16,)
            ],
          ),
        ],
      ),
    );
  }
}
