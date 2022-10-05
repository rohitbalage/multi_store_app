import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/appbar_Widgets.dart';

class CustomerOrders extends StatelessWidget {
  const CustomerOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: 'Customer Orders'),
        leading: const AppBarBackButton(),
      ),
    );
  }
}
