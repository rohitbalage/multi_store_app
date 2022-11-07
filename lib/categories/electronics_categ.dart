import 'package:flutter/material.dart';
import 'package:multi_store_app/minor_screens/SubCategProducts.dart';
import 'package:multi_store_app/utilities/categ_list.dart';

import '../widgets/categ_widgets.dart';

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

class ElectronicsCategory extends StatelessWidget {
  const ElectronicsCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CategHeaderLabel(
                  headerLabel: 'Electronics',
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.60,
                  child: GridView.count(
                      mainAxisSpacing: 70,
                      crossAxisSpacing: 15,
                      crossAxisCount: 3,
                      children: List.generate(
                        electronics.length - 1,
                        (index) {
                          return SubCategModel(
                            mainCategName: 'electronics',
                            subCategName: electronics[index + 1],
                            assetName:
                                'images/electronics/electronics$index.jpg',
                            subcategLabel: electronics[index + 1],
                          );
                        },
                      )),
                ),
              ],
            ),
          ),
        ),
        const Positioned(
            bottom: 0,
            right: 0,
            child: SiderBar(
              mainCategName: 'electronics',
            ))
      ],
    );
  }
}
