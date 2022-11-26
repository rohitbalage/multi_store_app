import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/dashboard_components/edit_business.dart';
import 'package:multi_store_app/dashboard_components/manage_products.dart';

import 'package:multi_store_app/dashboard_components/supp_balance.dart';
import 'package:multi_store_app/dashboard_components/supp_orders.dart';
import 'package:multi_store_app/dashboard_components/supp_statics.dart';
import 'package:multi_store_app/minor_screens/visit_store.dart';
import 'package:multi_store_app/widgets/appbar_Widgets.dart';

import '../widgets/alert_dialog.dart';

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

List<Widget> pages = [
  VisitStore(suppId: FirebaseAuth.instance.currentUser!.uid),
  const SupplierOrder(),
  const EditBusiness(),
  const ManageProducts(),
  const BalanceScreen(),
  const StaticsScreen(),
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
                MyAlertDialog.showMyDialog(
                  context: context,
                  content: 'Are you sure you want to log out?',
                  title: 'log out',
                  tabNo: () {
                    Navigator.pop(context);
                  },
                  tabYes: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/welcome_screen');
                  },
                );
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
                    MaterialPageRoute(builder: (context) => pages[index]));
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
