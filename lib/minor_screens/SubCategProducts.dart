import 'package:flutter/material.dart';

import '../widgets/appbar_Widgets.dart';

class SubCategProducts extends StatelessWidget {
  final String subCategName;
  final String mainCategName;
  const SubCategProducts(
      {Key? key, required this.subCategName, required this.mainCategName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: const AppBarBackButton(),
        title: AppBarTitle(title: subCategName),
      ),
      body: Center(
        child: Text(mainCategName),
      ),
    );
  }
}
