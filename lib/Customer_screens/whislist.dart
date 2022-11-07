import 'package:flutter/material.dart';
import 'package:multi_store_app/model/wish_model.dart';
import 'package:multi_store_app/providers/product_class.dart';

import 'package:multi_store_app/providers/wish_provider.dart';
import 'package:multi_store_app/widgets/appbar_Widgets.dart';

import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import '../providers/cart_provider.dart';
import '../widgets/alert_dialog.dart';

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
            actions: [
              context.watch<Wish>().getWishItems.isEmpty
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () {
                        MyAlertDialog.showMyDialog(
                            context: context,
                            title: 'Clear Wishlist',
                            content: 'Are you sure to clear Wishlist? ',
                            tabNo: () {
                              Navigator.pop(context);
                            },
                            tabYes: () {
                              context.read<Wish>().clearWhishlist();
                              Navigator.pop(context);
                            });
                      },
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.black,
                      ))
            ],
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
            return WhishlistModel(product: product);
          });
    });
  }
}
