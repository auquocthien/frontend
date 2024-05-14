import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/ui/auth/auth_manager.dart';
import 'package:frontend/ui/auth/auth_screen.dart';
import 'package:frontend/ui/product/product_detail.dart';
import 'package:frontend/ui/product/product_manager.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isSearchProduct = true;
  bool isShowSearchResult = false;
  String searchText = '';
  List<Product> searchResult = [];
  List<User> searchUserResult = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future searchProducByName(productName) async {
    await context.read<ProductManager>().getProducts();
    searchResult =
        await context.read<ProductManager>().getProductByName(productName);

    if (searchResult.isNotEmpty) {
      return searchResult;
    }
  }

  Future searchUserByName(String searchText) async {
    int userId = context.read<AuthManager>().userId;
    List<User> sub = await context.read<AuthManager>().getSubordinate(userId);
    print(sub);
    sub.forEach((element) {
      if (element.fullName.toLowerCase().contains(searchText.toLowerCase())) {
        searchUserResult.add(element);
      }
    });
    if (searchUserResult.isNotEmpty) {
      return searchUserResult;
    }
  }

  @override
  Widget build(BuildContext context) {
    return isSearchProduct ? buildProductSearch() : buildSubordinatesSearch();
  }

  Widget buildTextField() {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.29,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 10, top: 20),
            child: TextFormField(
              onTapOutside: (event) => {
                setState(() {
                  isShowSearchResult = !isShowSearchResult;
                })
              },
              onChanged: (value) async {
                setState(() {
                  searchText = value;
                  searchText.length >= 2
                      ? isShowSearchResult = true
                      : isShowSearchResult = false;
                });
              },
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 55, 140, 231)),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 0.5),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                filled: true,
                fillColor: Colors.white,
                labelStyle: TextStyle(color: Colors.blue),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isSearchProduct = !isSearchProduct;
            });
          },
          child: Container(
              width: 63,
              height: 63,
              margin: const EdgeInsets.only(top: 10, left: 5, right: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Center(
                child: SizedBox(
                  height: 50,
                  child: isSearchProduct
                      ? const Icon(Icons.shopping_bag)
                      : const Icon(Icons.person),
                ),
              )),
        )
      ],
    );
  }

  Widget buildProductSearch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTextField(),
        isShowSearchResult
            ? Container(
                margin: const EdgeInsets.only(left: 20),
                width: MediaQuery.of(context).size.width / 1.39,
                height: MediaQuery.of(context).size.height / 3,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(color: Colors.black, width: 0.5),
                ),
                child: FutureBuilder(
                  future: searchProducByName(searchText),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        child: ListView.builder(
                          itemCount: searchResult.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    ProductDetails.routeName,
                                    arguments: searchResult[index].productId);
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                height: 60,
                                margin: const EdgeInsets.only(bottom: 5),
                                padding:
                                    const EdgeInsets.only(left: 10, top: 10),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    border: Border.all(
                                        color: Colors.black, width: 0.5)),
                                child: Text(
                                  searchResult[index].toString(),
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              )
            : Container()
      ],
    );
  }

  Widget buildSubordinatesSearch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTextField(),
        isShowSearchResult
            ? Container(
                margin: const EdgeInsets.only(left: 20),
                width: MediaQuery.of(context).size.width / 1.39,
                height: MediaQuery.of(context).size.height / 3,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(color: Colors.black, width: 0.5),
                ),
                child: FutureBuilder(
                  future: searchUserByName(searchText),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        child: ListView.builder(
                          itemCount: searchUserResult.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    AuthScreen.routeName,
                                    arguments: searchUserResult[index].userId);
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                height: 60,
                                margin: const EdgeInsets.only(bottom: 5),
                                padding:
                                    const EdgeInsets.only(left: 10, top: 10),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    border: Border.all(
                                        color: Colors.black, width: 0.5)),
                                child: Text(
                                  searchUserResult[index].fullName,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              )
            : Container()
      ],
    );
    ;
  }
}
