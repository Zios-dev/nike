import 'package:flutter/material.dart';
import 'package:nike_ui_chalenge/entity/product.dart';

class ProductWidget extends StatelessWidget {
  final _products = [
    Product(
        brand: 'Nike',
        name: 'Air',
        image: 'assets/images/img_2.png',
        color: 0xFFed4b73,
        price: '\$80'),
    Product(
        brand: 'Nike',
        name: 'Air Force',
        image: 'assets/images/img_1.png',
        color: 0xFFd5b0a3,
        price: '\$150'),
    Product(
        brand: 'Nike',
        name: 'Jordan',
        image: 'assets/images/img_3.png',
        color: 0xFF13bbb1,
        price: '\$120'),
    Product(
        brand: 'Nike',
        name: 'Epic-react',
        image: 'assets/images/img.png',
        price: '\$120',
        color: 0xFF4869b7),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _products
            .map(
              (e) => ProductItemWidget(product: e),
            )
            .toList(),
      ),
    );
  }
}

class ProductItemWidget extends StatelessWidget {
  final Product product;

  const ProductItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            spreadRadius: 1,
            color: Colors.black12.withOpacity(.05),
          )
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Row(
              children: [
                RotatedBox(
                  quarterTurns: 3,
                  child: Container(
                    color: Colors.pink,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Text(
                      'New',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ),
                )
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  product.image,
                  width: 120,
                  height: 80,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Text(
                product.name,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                product.price,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }
}
