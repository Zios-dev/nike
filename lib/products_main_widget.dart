import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:nike_ui_chalenge/category_widget.dart';
import 'package:nike_ui_chalenge/entity/product.dart';
import 'package:nike_ui_chalenge/product_details_page.dart';

class ProductMainView extends StatelessWidget {
  const ProductMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .4,
      child: Stack(
        children: [
          const Positioned(
            left: 0,
            top: 0,
            right: 0,
            bottom: 0,
            child: ProductMainList(),
          ),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              color: Theme.of(context).canvasColor,
              padding: const EdgeInsets.only(left: 16),
              child: const RotatedBox(
                quarterTurns: 3,
                child: CategoryWidget(
                  categories: ['New', 'Featured', 'Universal'],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductMainList extends StatefulWidget {
  const ProductMainList({super.key});

  @override
  State<ProductMainList> createState() => _ProductMainListState();
}

class _ProductMainListState extends State<ProductMainList> {
  late PageController _pageController;
  final _products = [
    Product(
        brand: 'Nike',
        name: 'Air Jordan 6 Retro',
        image: 'assets/images/img.png',
        price: '\$120',
        color: 0xFFed4b73,
        images: [
          'assets/images/img_0_2.png',
          'assets/images/img_0_3.png',
        ]),
    Product(
        brand: 'Nike',
        name: 'Tatum 1',
        image: 'assets/images/img_3.png',
        color: 0xFF13bbb1,
        price: '\$120',
        images: [
          'assets/images/img_3_2.png',
          'assets/images/img_3_3.png',
          'assets/images/img_3_4.png',
        ]),
    Product(
        brand: 'Nike',
        name: 'Air Force',
        image: 'assets/images/img_1.png',
        color: 0xFFd5b0a3,
        price: '\$150',
        images: [
          'assets/images/img_1_3.png',
          'assets/images/img_1_4.png',
        ]),
    Product(
        brand: 'Nike',
        name: 'Air',
        image: 'assets/images/img_2.png',
        color: 0xFF4869b7,
        price: '\$80',
        images: [
          'assets/images/img_2_2.png',
          'assets/images/img_2_3.png',
        ]),
  ];

  @override
  void initState() {
    _pageController = PageController(
      viewportFraction: .7,
      keepPage: true,

    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      clipBehavior: Clip.none,
      controller: _pageController,
      pageSnapping: true,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ProductMainItemView(
          product: _products[index],
          pageController: _pageController,
          currentPage: index,
        ),
      ),
      itemCount: _products.length,
    );
  }
}

const navDurationTime = 600;

class ProductMainItemView extends StatelessWidget {
  final Product product;
  final PageController pageController;
  final int currentPage;

  ProductMainItemView(
      {super.key,
      required this.product,
      required this.pageController,
      required this.currentPage});

  final _navDuration = const Duration(milliseconds: navDurationTime);

  final ValueNotifier<bool> notifyDetailsLoaded = ValueNotifier(true);

  void _showDetails(BuildContext context, Product product) {
    Navigator.push(
      context,
      PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => FadeTransition(
                opacity: animation1,
                child: ProductDetailsPage(product: product),
              ),
          transitionDuration: _navDuration,
          reverseTransitionDuration: _navDuration),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDetails(context, product),
      child: AnimatedBuilder(
        animation: pageController,
        builder: (context, child) {
          double value = 1;
          if (pageController.position.haveDimensions) {
            value = pageController.page! - currentPage;
            value = (1 - (value.abs() * 0.6)).clamp(0.0, 1.0);
            value = Curves.easeOut.transform(value);

            print('${pageController.page}');
          } else if(pageController.initialPage!=currentPage) {
            value = 0.6;
          }
          return Padding(
            padding: EdgeInsets.all(32 - 32 * value),
            child: Stack(
              children: [
                Positioned(
                  right: 8,
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Material(
                    color: Colors.transparent,
                    child: Hero(
                      tag: "${product.image}_bg",
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color(product.color),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 24,
                  bottom: 0,
                  right: 8,
                  left: 0,
                  child: Hero(
                    tag: product.image,
                    child: Transform.rotate(
                      angle: math.pi / 180 * (270 + (60 * value)),
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Image.asset(
                          product.image,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.brand,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        product.name.toUpperCase(),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        product.price,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
                Positioned(
                    right: 24,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.white70,
                      ),
                    ))
              ],
            ),
          );
        },
      ),
    );
  }
}
