import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/appbar_Widgets.dart';

class StaticsScreen extends StatelessWidget {
  const StaticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: 'Supplier Orders'),
        leading: const AppBarBackButton(),
      ),
    );
  }
}
