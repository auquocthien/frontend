import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/ui/auth/auth_manager.dart';
import 'package:frontend/ui/auth/auth_screen.dart';
import 'package:frontend/ui/subordinates/subordinate_screen.dart';
import 'package:provider/provider.dart';

class SubordinateList extends StatefulWidget {
  final String userId;
  const SubordinateList({super.key, required this.userId});
  @override
  State<SubordinateList> createState() => SubordinateListState();
}

class SubordinateListState extends State<SubordinateList> {
  String searchText = '';
  List<User> subordinates = [];

  Future<List<User>> getSubordinate(userId) async {
    if (searchText.length >= 2) {
      subordinates = await searchUserByName(searchText);
    } else {
      subordinates = await context.read<AuthManager>().getSubordinate(userId);
    }

    return subordinates;
  }

  Future searchUserByName(String searchText) async {
    int userId = context.read<AuthManager>().userId;
    List<User> sub = await context.read<AuthManager>().getSubordinate(userId);
    List<User> result = [];
    sub.forEach((element) {
      if (element.fullName.toLowerCase().contains(searchText.toLowerCase())) {
        result.add(element);
      }
    });
    if (result.isNotEmpty) {
      return result;
    }
  }

  @override
  Widget build(BuildContext context) {
    double perRevenue = context.read<AuthManager>().perRevenue;
    double subRevenue = context.read<AuthManager>().subRevenue;

    return SafeArea(
        child: Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          buildSearchField(),
          Container(
              height: 600,
              child: FutureBuilder(
                  future: getSubordinate(int.parse(widget.userId)),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: Text(
                          'Nothing here',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                    return ListView.builder(
                        itemCount: subordinates.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  AuthScreen.routeName,
                                  arguments: subordinates[index].userId);
                            },
                            child: Container(
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
                                                Color.fromARGB(
                                                    255, 54, 238, 244),
                                              ],
                                            ),
                                            border: BorderDirectional(
                                                bottom: BorderSide(
                                                    color: Colors.black))),
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
                                              subordinates[index].fullName,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Text(
                                                    'Revenue: ${subordinates[index].perRevenue}'
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  SizedBox(
                                                    height: 40,
                                                    child: FloatingActionButton
                                                        .extended(
                                                            heroTag: 'btn1',
                                                            onPressed: () {},
                                                            label: const Text(
                                                                'Manager')),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                    child: FloatingActionButton
                                                        .extended(
                                                            heroTag: 'btn2',
                                                            onPressed: () {},
                                                            label: const Text(
                                                                'Reference')),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                    child: FloatingActionButton
                                                        .extended(
                                                            heroTag: 'btn3',
                                                            onPressed: () {
                                                              Navigator.of(context).pushNamed(
                                                                  SubordinateScreen
                                                                      .routeName,
                                                                  arguments: subordinates[
                                                                          index]
                                                                      .userId);
                                                            },
                                                            label: const Text(
                                                                'Subordinate')),
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
                                  Positioned(
                                      right: -10,
                                      top: -10,
                                      child: GestureDetector(
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: const BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(100))),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          );
                        });
                  })),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width / 1.1,
              padding: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.black))),
              child: Text(
                'Total Revenue: ${perRevenue + subRevenue}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    ));
  }

  Widget buildSearchField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 50,
      width: MediaQuery.of(context).size.width / 1.1,
      child: TextFormField(
        onChanged: (value) async {
          if (value.length >= 2) {
            setState(() {
              searchText = value;
            });
            await searchUserByName(searchText);
          }
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
