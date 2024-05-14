import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/ui/subordinates/subordinate_screen.dart';
import 'package:web_socket_channel/io.dart';
import 'package:frontend/services/order_service.dart';
import 'package:frontend/ui/auth/auth_manager.dart';
import 'package:provider/provider.dart';

class AuthInfo extends StatefulWidget {
  final String userId;
  const AuthInfo({super.key, required this.userId});

  @override
  State<AuthInfo> createState() => AuthInfoState();
}

class AuthInfoState extends State<AuthInfo> {
  List<Map<String, dynamic>> orderList = [];

  OrderService orderService = OrderService();

  Future getOrderByUserId(userId) async {
    orderList = await orderService.getOrderByUserId(userId);
    if (orderList.isNotEmpty) {
      return orderList;
    }
  }

  @override
  Widget build(BuildContext context) {
    String fullName = context.read<AuthManager>().fullName;
    String revenue = context.read<AuthManager>().perRevenue.toString();

    final channel = IOWebSocketChannel.connect('ws://your_server_address:8080');
    return SafeArea(
        child: Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            height: 250,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.elliptical(10, 10),
                    bottomRight: Radius.elliptical(10, 10))),
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 100,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.blue,
                              Color.fromARGB(255, 54, 238, 244),
                            ],
                          ),
                          border: BorderDirectional(
                              bottom: BorderSide(color: Colors.black))),
                    ),
                    Container(
                      height: 148,
                      padding: const EdgeInsets.only(
                        top: 30,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Text(
                            fullName,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Revenue: $revenue'.toString(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  height: 40,
                                  child: FloatingActionButton.extended(
                                      heroTag: 'btn1',
                                      onPressed: () {},
                                      label: Text('Manager')),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: FloatingActionButton.extended(
                                      heroTag: 'btn2',
                                      onPressed: () {},
                                      label: Text('Reference')),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: FloatingActionButton.extended(
                                      heroTag: 'bt3',
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                            SubordinateScreen.routeName,
                                            arguments: widget.userId);
                                      },
                                      label: Text('Subordinate')),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const Positioned(
                  height: 80,
                  width: 80,
                  left: 126,
                  top: 50,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://i.pinimg.com/564x/20/1e/14/201e14454ff5ff96bf76913580e9d48c.jpg'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: buildListOrder())
        ],
      ),
    ));
  }

  Widget buildListOrder() {
    return FutureBuilder(
        future: getOrderByUserId(widget.userId),
        builder: (context, snaoshot) {
          if (!snaoshot.hasData) {
            return const Center(
              child: Text(
                'Nothing here',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            );
          }
          return ListView.builder(
              itemCount: orderList.length,
              itemBuilder: ((context, index) {
                return Container(
                  height: 50,
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          child: Text(
                        orderList[index]['OrderDate'],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      )),
                      Text(
                        orderList[index]['TotalAmount'],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                );
              }));
        });
  }
}
