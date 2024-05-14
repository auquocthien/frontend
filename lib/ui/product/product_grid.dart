import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/ui/product/product_detail.dart';
import 'package:frontend/ui/product/product_manager.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatefulWidget {
  const ProductGrid({super.key});

  @override
  State<ProductGrid> createState() => ProductGridState();
}

class ProductGridState extends State<ProductGrid> {
  List<Product> products = [];
  String searchText = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future getProducts() async {}

  Future getProductByName(productName) async {
    await context.read<ProductManager>().getProducts();
    products =
        (await context.read<ProductManager>().getProductByName(productName));
    if (products.isNotEmpty) {
      return products;
    }
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            buildSearchField(),
            Expanded(
              child: FutureBuilder(
                  future: getProductByName(searchText),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return GridView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                          ),
                          child: GestureDetector(
                            onTap: () => {
                              Navigator.of(context).pushNamed(
                                  ProductDetails.routeName,
                                  arguments: products[index].productId)
                            },
                            child: GridTile(
                              footer: Container(
                                padding: EdgeInsets.only(top: 3, left: 5),
                                height: 60,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 190, 218, 245)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      products[index].productName,
                                      style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Remainig: ${products[index].quatity.toString()}',
                                          style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              child: Image.network(
                                products[index].image,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSearchField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 50,
      width: MediaQuery.of(context).size.width / 1.22,
      child: TextFormField(
        onChanged: (value) async {
          setState(() {
            searchText = value;
          });
        },
        decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 55, 140, 231)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          filled: true,
          fillColor: Colors.white,
          labelStyle: TextStyle(color: Colors.blue),
        ),
      ),
    );
  }
}
