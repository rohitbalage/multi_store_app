import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../model/product_model.dart';
import '../widgets/appbar_Widgets.dart';

class SubCategProducts extends StatefulWidget {
  final String subCategName;
  final String mainCategName;
  const SubCategProducts(
      {Key? key, required this.subCategName, required this.mainCategName})
      : super(key: key);

  @override
  State<SubCategProducts> createState() => _SubCategProductsState();
}

class _SubCategProductsState extends State<SubCategProducts> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productstream = FirebaseFirestore.instance
        .collection('products')
        .where('maincateg', isEqualTo: widget.mainCategName)
        .where('subcateg', isEqualTo: widget.subCategName)
        .snapshots();

    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: const AppBarBackButton(),
          title: AppBarTitle(title: widget.subCategName),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _productstream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                  child: Text(
                'This category \n\n has no items yet',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Acme',
                    letterSpacing: 1.5),
              ));
            }

            return SingleChildScrollView(
              child: StaggeredGridView.countBuilder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  crossAxisCount: 2,
                  itemBuilder: (context, index) {
                    return ProductModel(
                      products: snapshot.data!.docs[index],
                    );
                  },
                  staggeredTileBuilder: (context) =>
                      const StaggeredTile.fit(1)),
            );
            // ListView(
            //   children: snapshot.data!.docs.map((DocumentSnapshot document) {
            //     Map<String, dynamic> data =
            //         document.data()! as Map<String, dynamic>;
            //     return ListTile(
            //       leading: Image(image: NetworkImage(data['proimages'][0])),
            //       title: Text(data['proname']),
            //       subtitle: Text(data['price'].toString()),
            //     );
            //   }).toList(),
            // );
          },
        ));
  }
}
