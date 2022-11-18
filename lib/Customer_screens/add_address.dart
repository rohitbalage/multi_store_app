import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/appbar_widgets.dart';
import 'package:multi_store_app/widgets/yellowbuttion.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.yellowAccent.shade200,
          leading: const AppBarBackButton(),
          title: const AppBarTitle(
            title: 'Add Address',
          )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 40, 30, 40),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.50,
                          height: MediaQuery.of(context).size.width * 0.12,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                            onChanged: (Value) {},
                            decoration: textFormDecoration.copyWith(
                                labelText: 'Full Name',
                                hintText: 'Enter your full name'),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.50,
                          height: MediaQuery.of(context).size.width * 0.12,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                            onChanged: (Value) {},
                            decoration: textFormDecoration.copyWith(
                                labelText: 'Full Name',
                                hintText: 'Enter your full name'),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.50,
                          height: MediaQuery.of(context).size.width * 0.12,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                            onChanged: (Value) {},
                            decoration: textFormDecoration.copyWith(
                                labelText: 'Full Name',
                                hintText: 'Enter your full name'),
                          ),
                        )),
                  ],
                ),
                Center(
                  child: YellowButton(
                      label: 'Set as new address',
                      onPressed: () {},
                      width: 0.8),
                )
              ]),
        ),
      ),
    );
  }
}

var textFormDecoration = InputDecoration(
    labelText: 'full name',
    hintText: 'Enter your full name',
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
    enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.purple),
        borderRadius: BorderRadius.circular(25)),
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2),
        borderRadius: BorderRadius.circular(25)));
