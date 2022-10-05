import 'package:flutter/material.dart';
import 'package:multi_store_app/dashboard_components/my_store.dart';
import 'package:multi_store_app/widgets/appbar_Widgets.dart';

List<IconData> icons = [
  Icons.store,
  Icons.shop_2_outlined,
  Icons.edit,
  Icons.settings_applications,
  Icons.attach_money,
  Icons.show_chart,
];

List<String> labels = [
  'my store',
  'order',
  'edit profile',
  'manage product',
  'balance',
  'statics',
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
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/Welcome_screen');
              },
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
            return InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyStore()));
              },
              child: Card(
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
                      labels[index].toUpperCase(),
                      style: const TextStyle(
                          fontSize: 24,
                          letterSpacing: 2,
                          color: Colors.yellowAccent,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Acme'),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
