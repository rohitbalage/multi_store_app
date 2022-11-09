import 'package:flutter/material.dart';
import 'package:multi_store_app/dashboard_components/preparing_orders.dart';
import 'package:multi_store_app/dashboard_components/shipping_orders.dart';
import 'package:multi_store_app/widgets/appbar_Widgets.dart';

import 'delivered_orders.dart';

class SupplierOrder extends StatelessWidget {
  const SupplierOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: const AppBarBackButton(),
          backgroundColor: Colors.white,
          title: const AppBarTitle(title: 'Orders'),
          bottom: const TabBar(
            indicatorColor: Colors.yellow,
            indicatorWeight: 8,
            tabs: [
              RepeatedTab(label: 'Preparing'),
              RepeatedTab(label: 'Shipping'),
              RepeatedTab(label: 'Delivered'),
            ],
          ),
        ),
        body:
            const TabBarView(children: [Preparing(), Shipping(), Delivered()]),
      ),
    );
  }
}

class RepeatedTab extends StatelessWidget {
  final String label;
  const RepeatedTab({Key? key, required this.label}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Center(
          child: Text(
        label,
        style: const TextStyle(color: Colors.grey),
      )),
    );
  }
}
