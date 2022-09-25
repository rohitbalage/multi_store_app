import 'package:flutter/material.dart';
import '../widgets/appbar_Widgets.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const AppBarTitle(title: 'Stores'),
      ),
    );
  }
}
