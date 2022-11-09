import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/appbar_Widgets.dart';

class StaticsScreen extends StatelessWidget {
  const StaticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const AppBarTitle(title: 'Statics'),
          leading: const AppBarBackButton(),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              StaticsModel(
                label: 'sold out',
                value: '45',
              ),
              StaticsModel(label: 'item count', value: '45'),
              StaticsModel(label: 'total balance', value: '45'),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }
}

class StaticsModel extends StatelessWidget {
  final String label;
  final dynamic value;
  const StaticsModel({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Column(
        children: [
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width * 0.55,
            decoration: const BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: Center(
                child: Text(
              label.toUpperCase(),
              style: const TextStyle(color: Colors.white, fontSize: 24),
            )),
          ),
          Container(
            height: 90,
            width: MediaQuery.of(context).size.width * 0.70,
            decoration: BoxDecoration(
                color: Colors.blueGrey.shade100,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            child: Center(
                child: Text(
              value,
              style: const TextStyle(
                  color: Colors.pink,
                  fontSize: 40,
                  letterSpacing: 2,
                  fontFamily: 'Acme',
                  fontWeight: FontWeight.bold),
            )),
          )
        ],
      )
    ]);
  }
}
