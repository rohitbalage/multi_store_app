import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:multi_store_app/main_screens/cart.dart';
import 'package:multi_store_app/main_screens/visit_store.dart';
import 'package:multi_store_app/minor_screens/full_screen_view.dart';
import 'package:multi_store_app/providers/cart_provider.dart';
import 'package:multi_store_app/providers/wish_provider.dart';
import 'package:multi_store_app/widgets/appbar_Widgets.dart';
import 'package:multi_store_app/widgets/snackbar.dart';
import 'package:multi_store_app/widgets/yellowbuttion.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import '../model/product_model.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:badges/badges.dart';
import 'package:expandable/expandable.dart';

class ProductDetailsScreen extends StatefulWidget {
  final dynamic prolist;
  const ProductDetailsScreen({super.key, required this.prolist});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late final Stream<QuerySnapshot> _productstream = FirebaseFirestore.instance
      .collection('products')
      .where('maincateg', isEqualTo: widget.prolist['maincateg'])
      .where('subcateg', isEqualTo: widget.prolist['subcateg'])
      .snapshots();

  late final Stream<QuerySnapshot> reviewsStream = FirebaseFirestore.instance
      .collection('products')
      .doc(widget.prolist['proid'])
      .collection('reviews')
      .snapshots();

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  late List<dynamic> imagesList = widget.prolist['proimages'];
  @override
  Widget build(BuildContext context) {
    var onSale = widget.prolist['discount'];
    var existingItemCart = context.read<Cart>().getItems.firstWhereOrNull(
        (product) => product.documentId == widget.prolist['proid']);
    return Material(
      child: SafeArea(
        child: ScaffoldMessenger(
          key: _scaffoldKey,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FullScreenView(
                                    imagesList: imagesList,
                                  )));
                    },
                    child: Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.45,
                          child: Swiper(
                              pagination: const SwiperPagination(
                                  builder: SwiperPagination.fraction),
                              itemBuilder: (context, index) {
                                return Image(
                                  image: NetworkImage(imagesList[index]),
                                );
                              },
                              itemCount: imagesList.length),
                        ),
                        Positioned(
                            left: 15,
                            top: 20,
                            child: CircleAvatar(
                              backgroundColor: Colors.yellow,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            )),
                        Positioned(
                            right: 15,
                            top: 20,
                            child: CircleAvatar(
                              backgroundColor: Colors.yellow,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.share,
                                  color: Colors.black,
                                ),
                                onPressed: () {},
                              ),
                            ))
                      ],
                    ),
                  ),
                  Text(
                    widget.prolist['proname'],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text('USD ',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                            Text(
                              widget.prolist['price'].toStringAsFixed(2),
                              style: widget.prolist['discount'] != 0
                                  ? const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      decoration: TextDecoration.lineThrough,
                                      fontWeight: FontWeight.w600)
                                  : const TextStyle(
                                      color: Colors.red,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            onSale != 0
                                ? Text(
                                    ((1 - (widget.prolist['discount'] / 100)) *
                                            widget.prolist['price'])
                                        .toStringAsFixed(2),
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  )
                                : const Text('')
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              var existingItemWishlist = context
                                  .read<Wish>()
                                  .getWishItems
                                  .firstWhereOrNull((product) =>
                                      product.documentId ==
                                      widget.prolist['proid']);

                              existingItemWishlist != null
                                  ? context
                                      .read<Wish>()
                                      .removeThis(widget.prolist['proid'])
                                  : context.read<Wish>().addWishItem(
                                        widget.prolist['proname'],
                                        onSale != 0
                                            ? ((1 -
                                                    (widget.prolist[
                                                            'discount'] /
                                                        100)) *
                                                widget.prolist['price'])
                                            : widget.prolist['price'],
                                        1,
                                        widget.prolist['instock'],
                                        widget.prolist['proimages'],
                                        widget.prolist['proid'],
                                        widget.prolist['sid'],
                                      );
                            },
                            icon: context
                                        .watch<Wish>()
                                        .getWishItems
                                        .firstWhereOrNull((product) =>
                                            product.documentId ==
                                            widget.prolist['proid']) !=
                                    null
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 30,
                                  )
                                : const Icon(
                                    Icons.favorite_outline_outlined,
                                    color: Colors.red,
                                    size: 30,
                                  ))
                      ]),
                  widget.prolist['instock'] == 0
                      ? const Text(
                          'Sorry, this item is out of stock',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        )
                      : Text(
                          (widget.prolist['instock'].toString()) +
                              (' pieces available in a stock'),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.blueGrey,
                          ),
                        ),
                  const ProductDetailHeader(
                    label: '  Item Description  ',
                  ),
                  Text(
                    widget.prolist['prodesc'],
                    textScaleFactor: 1.1,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey.shade600),
                  ),
                  reviews(reviewsStream),
                  const ProductDetailHeader(
                    label: ' Recommended items ',
                  ),
                  SizedBox(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _productstream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
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
                      },
                    ),
                  )
                ],
              ),
            ),
            bottomSheet: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VisitStore(
                                        suppId: widget.prolist['sid'])));
                          },
                          icon: const Icon(Icons.store)),
                      const SizedBox(
                        width: 20,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CartScreen(
                                    back: AppBarBackButton(),
                                  ),
                                ));
                          },
                          icon: Badge(
                              showBadge: context.read<Cart>().getItems.isEmpty
                                  ? false
                                  : true,
                              padding: const EdgeInsets.all(2),
                              badgeColor: Colors.yellowAccent,
                              badgeContent: Text(
                                context
                                    .watch<Cart>()
                                    .getItems
                                    .length
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              child: const Icon(Icons.shopping_cart))),
                    ],
                  ),
                  YellowButton(
                      label: existingItemCart != null
                          ? 'ADDED TO CART'
                          : 'ADD TO CART',
                      onPressed: () {
                        if (widget.prolist['instock'] == 0) {
                          myMesssageHandler.showSnackbar(
                              _scaffoldKey, 'this item is out of stock');
                        } else if (existingItemCart != null) {
                          myMesssageHandler.showSnackbar(
                              _scaffoldKey, 'this item already in the  cart');
                        } else {
                          context.read<Cart>().addItem(
                                widget.prolist['proname'],
                                onSale != 0
                                    ? ((1 -
                                            (widget.prolist['discount'] /
                                                100)) *
                                        widget.prolist['price'])
                                    : widget.prolist['price'],
                                1,
                                widget.prolist['instock'],
                                widget.prolist['proimages'],
                                widget.prolist['proid'],
                                widget.prolist['sid'],
                              );
                        }
                      },
                      width: 0.5)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductDetailHeader extends StatelessWidget {
  final String label;
  const ProductDetailHeader({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: 40,
          width: 50,
          child: Divider(
            color: Colors.yellow.shade900,
            thickness: 1,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
              color: Colors.red, fontSize: 24, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 40,
          width: 50,
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
      ]),
    );
  }
}

Widget reviews(var reviewsStream) {
  return ExpandablePanel(
      header: const Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'Reviews',
          style: TextStyle(
              color: Colors.blue, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      collapsed: const Text('collapsed'),
      expanded: reviewsAll(reviewsStream));
}

Widget reviewsAll(var reviewsStream) {
  return StreamBuilder<QuerySnapshot>(
    stream: reviewsStream,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot2) {
      if (snapshot2.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      if (snapshot2.data!.docs.isEmpty) {
        return const Center(
            child: Text(
          'This product  \n\n has no reviews yet',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 26,
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
              fontFamily: 'Acme',
              letterSpacing: 1.5),
        ));
      }

      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: snapshot2.data!.docs.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage(snapshot2.data!.docs[index]['profileimage']),
              ),
            );
          });
    },
  );
}
