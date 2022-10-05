import 'package:flutter/material.dart';

class CustomerRegister extends StatelessWidget {
  const CustomerRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Row(
          children: [
            Text(
              'Sign up',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/Welcome_Screen');
                },
                icon: Icon(
                  Icons.home_work,
                  size: 40,
                ))
          ],
        )
      ]),
    );
  }
}
