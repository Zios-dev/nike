import 'package:flutter/material.dart';
import 'package:nike_ui_chalenge/entity/product.dart';
import 'package:nike_ui_chalenge/entity/size.dart';
import 'package:nike_ui_chalenge/products_main_widget.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: _ProductDetailsPageBody(product: product, height: height),
    );
  }
}

class _ProductDetailsPageBody extends StatelessWidget {
  _ProductDetailsPageBody({
    super.key,
    required this.product,
    required this.height,
  });

  final Product product;
  final double height;

  final ValueNotifier<bool> notifierPageLoad = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifierPageLoad.value = true;
    });
    return WillPopScope(
      onWillPop: () {
        notifierPageLoad.value = false;
        return Future.value(true);
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: -180,
            right: -110,
            child: Material(
              color: Colors.transparent,
              child: Hero(
                tag: "${product.image}_bg",
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(product.color),
                  ),
                  height: height * .6,
                  width: height * .6,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: -20,
            bottom: 0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: height * .08,
                  ),
                  Hero(
                    tag: product.image,
                    child: Transform.rotate(
                      angle: 75,
                      child: Image.asset(
                        product.image,
                        width: height * .35,
                        height: height * .35,
                      ),
                    ),
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: notifierPageLoad,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 60,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Container(
                              margin: EdgeInsets.only(
                                  left: index == 0 ? 16 : 4,
                                  top: 0,
                                  right: index == 23 ? 16 : 4,
                                  bottom: 0),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.asset(
                                  product.images![index],
                                ),
                              ),
                            ),
                            itemCount: product.images?.length,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      product.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ),
                                  Text(
                                    product.price,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Mixing one part urban to one part tough, the Air Max Pulse brings an underground touch to the iconic Air Max line. Its textile-wrapped midsole and vacuum-sealed accents boost its street cred, while colours inspired by the grime music scene keep it rough around the edges. Point-loaded Air cushioning—revamped from the incredibly plush Air Max 270—delivers the comfort you\'ve come to trust whether you\'re running errands or hitting the club',
                                maxLines: 5,
                                style: Theme.of(context).textTheme.titleMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Text(
                                'Size',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              SizesWidget(),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 32,
                                  horizontal: 16,
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: FilledButton(
                                    onPressed: () {},
                                    child: const Text('Add to cart'),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    builder: (context, value, child) => AnimatedOpacity(
                      duration: const Duration(milliseconds: navDurationTime),
                      opacity: notifierPageLoad.value ? 1 : 0,
                      child: AnimatedContainer(
                        padding: EdgeInsets.only(
                            top: notifierPageLoad.value ? 0 : 100),
                        curve: Curves.fastLinearToSlowEaseIn,
                        duration: const Duration(milliseconds: navDurationTime),
                        child: child!,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: kToolbarHeight - 16,
            child: IconButton(
              color: kDefaultIconLightColor,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
        ],
      ),
    );
  }
}

class SizesWidget extends StatefulWidget {
  @override
  State<SizesWidget> createState() => _SizesWidgetState();
}

class _SizesWidgetState extends State<SizesWidget> {
  List<Size> _sizes = [
    Size(size: 'UK 6'),
    Size(size: 'UK 6.5'),
    Size(size: 'UK 7'),
    Size(size: 'UK 7.5'),
    Size(size: 'UK 8'),
    Size(size: 'UK 8.5'),
    Size(size: 'UK 9'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) =>
            index != 0 || index != _sizes.length - 1
                ? const SizedBox(
                    width: 8,
                  )
                : Container(),
        itemBuilder: (context, index) {
          final size = _sizes[index];
          return OutlinedButton(
            onPressed: () => _selectSize(_sizes[index]),
            style: OutlinedButton.styleFrom(
              textStyle: Theme.of(context).textTheme.titleMedium,
              foregroundColor: size.isSelected ? Colors.white : Colors.black,
              backgroundColor: size.isSelected ? Colors.black : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Text(size.size),
          );
        },
        itemCount: _sizes.length,
      ),
    );
  }

  void _selectSize(Size size) {
    setState(() {
      _sizes = _sizes
          .map((e) => e.copyWith(isSelected: e.size == size.size))
          .toList();
    });
  }
}
