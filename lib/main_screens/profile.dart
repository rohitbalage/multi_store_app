import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverAppBar(
        centerTitle: true,
        floating: false,
        elevation: 0,
        backgroundColor: Colors.white,
        pinned: false,
        expandedHeight: 200,
        flexibleSpace: LayoutBuilder(builder: (context, Constraints) {
          return FlexibleSpaceBar(
            title: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: Constraints.biggest.height <= 120 ? 1 : 0,
              child:
                  const Text('Account', style: TextStyle(color: Colors.black)),
            ),
            background: Container(
                decoration: const BoxDecoration(
                    gradient:
                        LinearGradient(colors: [Colors.yellow, Colors.brown]))),
          );
        }),
      ),
      SliverToBoxAdapter(
        child: Column(children: [
          Container(
            height: 80,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30)),
                    ),
                    child: TextButton(
                      child: const Center(
                        child: Text(
                          'Cart',
                          style: TextStyle(color: Colors.yellow, fontSize: 20),
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    color: Colors.yellow,
                    child: TextButton(
                      child: const Center(
                        child: Text(
                          'Orders',
                          style: TextStyle(color: Colors.black54, fontSize: 20),
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                    ),
                    child: TextButton(
                      child: const Center(
                        child: Text(
                          'Whishlist',
                          style: TextStyle(color: Colors.yellow, fontSize: 20),
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ]),
          )
        ]),
      )
    ]));
  }
}
