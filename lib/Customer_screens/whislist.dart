import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/appbar_Widgets.dart';

class Whishlist extends StatelessWidget {
  const Whishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: 'Whislist Screens'),
        leading: const AppBarBackButton(),
      ),
    );
  }
}
