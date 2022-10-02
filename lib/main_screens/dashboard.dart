import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/appbar_Widgets.dart';

List<String> label = [
  'My Store'
      'Orders'
      'Edit Profile'
      'Manage products'
      'balance'
      'statics'
];

List<IconData> icons = [
  Icons.store,
  Icons.shop_2_outlined,
  Icons.edit,
  Icons.settings,
  Icons.attach_money,
  Icons.show_chart,
];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(
          title: 'Dashboard',
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.logout, color: Colors.black)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: GridView.count(
          mainAxisSpacing: 50,
          crossAxisSpacing: 50,
          crossAxisCount: 2,
          children: List.generate(6, (index) {
            return Card(
              elevation: 20,
              shadowColor: Colors.purple.shade200,
              color: Colors.blueGrey.withOpacity(0.7),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      icons[index],
                      size: 50,
                      color: Colors.yellowAccent,
                    ),
                    Text(
                      label[index].toUpperCase(),
                      style: const TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 24,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Acme'),
                    )
                  ]),
            );
          }),
        ),
      ),
    );
  }
}
