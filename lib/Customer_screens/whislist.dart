import 'package:flutter/material.dart';

import 'package:multi_store_app/providers/wish_provider.dart';
import 'package:multi_store_app/widgets/appbar_Widgets.dart';

import 'package:provider/provider.dart';

class WhishlistScreen extends StatefulWidget {
  @override
  State<WhishlistScreen> createState() => _WhishlistScreenState();
}

class _WhishlistScreenState extends State<WhishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            leading: const AppBarBackButton(),
            title: const AppBarTitle(title: 'Wishlist'),
            // actions: [
            //   context.watch<Wishlist>().getItems.isEmpty
            //       ? const SizedBox()
            //       : IconButton(
            //           onPressed: () {
            //             MyAlertDialog.showMyDialog(
            //                 context: context,
            //                 title: 'Clear Wishlist',
            //                 content: 'Are you sure to clear Wishlist? ',
            //                 tabNo: () {
            //                   Navigator.pop(context);
            //                 },
            //                 tabYes: () {
            //                   context.read<Wishlist>().clearWishlist();
            //                   Navigator.pop(context);
            //                 });
            //           },
            //           icon: const Icon(
            //             Icons.delete_forever,
            //             color: Colors.black,
            //           ))
            // ],
          ),
          body: context.watch<Wish>().getWishItems.isNotEmpty
              ? const WishItems()
              : const EmptyWishlist(),
        ),
      ),
    );
  }
}

class EmptyWishlist extends StatelessWidget {
  const EmptyWishlist({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          'Your Wishlist is empty !',
          style: TextStyle(fontSize: 30),
        ),
      ],
    ));
  }
}

class WishItems extends StatelessWidget {
  const WishItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Wish>(builder: (context, Wishlist, child) {
      return ListView.builder(
          itemCount: Wishlist.count,
          itemBuilder: (context, index) {
            final product = Wishlist.getWishItems[index];
            print(product);
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                child: SizedBox(
                  height: 100,
                  child: Row(children: [
                    SizedBox(
                      height: 100,
                      width: 120,
                      child: Image.network(product.imagesUrl.first),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade700),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product.price.toStringAsFixed(2),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          context
                                              .read<Wish>()
                                              .removeItem(product);
                                        },
                                        icon: const Icon(Icons.delete_forever))
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.shopping_cart))
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            );
          });
    });
  }
}
