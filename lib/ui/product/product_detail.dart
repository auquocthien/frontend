import 'package:flutter/material.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/services/product.service.dart';
import 'package:frontend/ui/cart/cart_manager.dart';
import 'package:frontend/ui/shared/app_drawer.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = '/product-detail';
  final String productId;
  const ProductDetails({super.key, required this.productId});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Product? product;
  ProductService productService = ProductService();
  String searchText = '';
  int quantity = 1;

  Future<Product?> getProduct(productId) async {
    product = await productService.getProductById(productId);
    return product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Product Details',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 83, 86, 255),
      ),
      drawer: const AppDrawer(),
      body: Container(
        padding: EdgeInsets.all(20),
        child: FutureBuilder(
            future: getProduct(widget.productId),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 1.4,
                    child: ListView(
                      children: [
                        Image.network(
                          product!.image,
                          height: MediaQuery.of(context).size.height / 2,
                          fit: BoxFit.fill,
                        ),

                        // Product title
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10.0),
                          child: Text(
                            product!.productName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                        ),

                        // Product description
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(product!.desc)),

                        // Product price
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Quantity: ${product!.quatity.toString()}',
                                style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '\$${product!.price}',
                                style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Center(
                            child: NumberPicker(
                              selectedTextStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                              itemWidth: 50,
                              axis: Axis.horizontal,
                              value: quantity,
                              minValue: 0,
                              maxValue: product!.quatity,
                              onChanged: (value) =>
                                  setState(() => quantity = value),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Map<String, dynamic> item = {
                              "productId": product!.productId,
                              "price": product!.price,
                              "quantity": quantity,
                              "productName": product!.productName
                            };

                            context.read<CartManager>().addProduct(item);
                            setState(() {});
                          },
                          child: Container(
                            height: 20,
                            child: Text('Add to cart',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
