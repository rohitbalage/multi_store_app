import 'package:flutter/material.dart';
import 'package:multi_store_app/utilities/categ_list.dart';

// List<String> imagetry = [
//   'images/try/image0.jpg',
//   'images/try/image1.jpg',
//   'images/try/image2.jpg',
//   'images/try/image3.jpg',
//   'images/try/image4.jpg',
// ];

// List<String> labeltry = [
//   'shirt',
//   'jeans',
//   'shoes',
//   'jackets',
// ];

class MenCategory extends StatelessWidget {
  const MenCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Text(
            'Men',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 1.5),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.60,
          child: GridView.count(
              mainAxisSpacing: 70,
              crossAxisSpacing: 15,
              crossAxisCount: 3,
              children: List.generate(
                men.length,
                (index) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: Image(
                            image: AssetImage('images/men/men$index.jpg')),
                      ),
                      Text(men[index])
                    ],
                  );
                },
              )),
        ),
      ],
    );
  }
}
