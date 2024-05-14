import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  List<String> images = [
    'https://i.pinimg.com/564x/b5/a5/6d/b5a56d5701db2e316a479495882ef0ce.jpg',
    'https://i.pinimg.com/564x/b8/3f/6c/b83f6c2bb10b0bfe7cf4ab07e3e35b41.jpg',
    'https://i.pinimg.com/564x/2b/49/5b/2b495bc250b1b561946b2eebf0b06da2.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CarouselSlider(
            options: CarouselOptions(
                autoPlayInterval: const Duration(seconds: 2),
                autoPlay: true,
                enlargeCenterPage: true),
            items: images
                .map((image) => Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      padding: EdgeInsets.only(top: 40),
                      child: Image.network(
                        image,
                        fit: BoxFit.fill,
                      ),
                    ))
                .toList()),
      ),
    );
  }
}
