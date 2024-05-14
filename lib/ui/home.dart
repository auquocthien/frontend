import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/services/product.service.dart';
import 'package:frontend/ui/product/product_card.dart';
import 'package:frontend/ui/product/product_detail.dart';
import 'package:frontend/ui/product/product_manager.dart';
import 'package:frontend/ui/product/search.dart';
import 'package:frontend/ui/shared/app_drawer.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> productBestSells = [];

  Future getProductBestSell() async {
    productBestSells =
        await context.read<ProductManager>().getProductBestSell();
    if (productBestSells.isNotEmpty) {
      return productBestSells;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Management',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 83, 86, 255),
      ),
      drawer: const AppDrawer(),
      body: Container(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                buidBody(),
                buildHeader(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return const Search();
  }

  Widget buidBody() {
    return Column(
      children: [
        const SizedBox(
          height: 60,
        ),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 200,
            width: MediaQuery.of(context).size.width / 1.1,
            child: const ProductCard()),
        const SizedBox(
          height: 30,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'Best selling product',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        buildProductBestSell(),
      ],
    );
  }

  Widget buildProductBestSell() {
    return FutureBuilder(
        future: getProductBestSell(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text(
                'No data',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
          return Container(
              width: MediaQuery.of(context).size.width / 1.1,
              padding: const EdgeInsets.symmetric(horizontal: 3),
              height: 240,
              child: ListView.builder(
                itemCount: productBestSells.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(ProductDetails.routeName,
                          arguments: productBestSells[index]['productID']);
                    },
                    child: Container(
                      height: 55,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      margin: index == 0
                          ? const EdgeInsets.only(top: 5, bottom: 10)
                          : const EdgeInsets.only(bottom: 10),
                      decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(255, 75, 166, 182),
                                offset: Offset(1, 2),
                                blurRadius: 1)
                          ],
                          color: Color.fromARGB(255, 223, 245, 255),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              productBestSells[index]['productName'],
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          Text(
                            productBestSells[index]['totalQuantity'].toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ));
        });
  }
}
