import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/appbar_Widgets.dart';

class ManageProducts extends StatelessWidget {
  const ManageProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: 'Supplier Orders'),
        leading: const AppBarBackButton(),
      ),
    );
  }
}
