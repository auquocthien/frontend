import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/ui/cart/cart_item.dart';
import 'package:frontend/ui/auth/auth_manager.dart';
import 'package:frontend/ui/cart/cart_manager.dart';
import 'package:provider/provider.dart';

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  State<CartList> createState() => CartListState();
}

class CartListState extends State<CartList> {
  List<CartItem> carts = [];

  Future getCartItems() async {
    carts = await context.read<CartManager>().carts;

    if (carts.isNotEmpty) {
      return carts;
    }
  }

  Widget build(BuildContext context) {
    double amount = context.read<CartManager>().totalAmount();
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
          height: MediaQuery.of(context).size.height / 1.4,
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: FutureBuilder(
            future: getCartItems(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: Text('Nothing in the cart'),
                );
              } else {
                return ListView.builder(
                    itemCount: carts.length,
                    itemBuilder: (context, index) {
                      return buildCartTitle(carts[index]);
                    });
              }
            },
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            height: MediaQuery.of(context).size.height / 1.4,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: const Color.fromARGB(255, 223, 245, 255)),
            child: Stack(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Amount: \$$amount',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      int sellerId = context.read<AuthManager>().userId;
                      context.read<CartManager>().addOrder(sellerId);
                      context.read<CartManager>().deleteCart();
                      setState(() {});
                    },
                    child: const Text('Order now',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ]),
          ),
        )
      ],
    );
  }

  Widget buildCartTitle(CartItem item) {
    return Dismissible(
        key: ValueKey(item.productId),
        background: Container(
          color: Theme.of(context).colorScheme.error,
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
        ),
        direction: DismissDirection.endToStart,
        // confirmDismiss: (direction) {

        // },
        onDismissed: (direction) {},
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 223, 245, 255),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: FittedBox(
                      child: Text('\$${item.price}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold))),
                ),
              ),
              title: Text(item.productName,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis)),
              subtitle: Text('Total: \$${(item.price * item.quantity)}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500)),
              trailing: Text('${item.quantity} x',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
            ),
          ),
        ));
  }
}
