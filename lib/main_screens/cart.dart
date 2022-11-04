import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_store_app/providers/cart_provider.dart';
import 'package:multi_store_app/widgets/alert_dialog.dart';
import 'package:multi_store_app/widgets/appbar_Widgets.dart';
import '../widgets/yellowbuttion.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  final Widget? back;
  const CartScreen({super.key, this.back});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
            leading: widget.back,
            title: const AppBarTitle(title: 'Cart'),
            actions: [
              context.watch<Cart>().getItems.isEmpty
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () {
                        MyAlertDialog.showMyDialog(
                            context: context,
                            title: 'Clear Cart',
                            content: 'Are you sure to clear cart? ',
                            tabNo: () {
                              Navigator.pop(context);
                            },
                            tabYes: () {
                              context.read<Cart>().clearCart();
                              Navigator.pop(context);
                            });
                      },
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.black,
                      ))
            ],
          ),
          body: context.watch<Cart>().getItems.isNotEmpty
              ? const CartItems()
              : const EmptyCart(),
          bottomSheet:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('Total: \$ ', style: TextStyle(fontSize: 20)),
                  Text(context.watch<Cart>().totalPrice.toStringAsFixed(2),
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red)),
                ],
              ),
            ),
            YellowButton(
              width: 0.45,
              label: 'CHECKOUT',
              onPressed: () {},
            )
          ]),
        ),
      ),
    );
  }
}

class EmptyCart extends StatelessWidget {
  const EmptyCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Your cart is empty !',
          style: TextStyle(fontSize: 30),
        ),
        const SizedBox(height: 50),
        Material(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(25),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width * 0.6,
            onPressed: () {
              Navigator.canPop(context)
                  ? Navigator.pop(context)
                  : Navigator.pushReplacementNamed(context, '/customer_home');
            },
            child: const Text(
              'continue shopping',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        )
      ],
    ));
  }
}

class CartItems extends StatelessWidget {
  const CartItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(builder: (context, cart, child) {
      return ListView.builder(
          itemCount: cart.count,
          itemBuilder: (context, index) {
            final product = cart.getItems[index];
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
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                    children: [
                                      product.qty == 1
                                          ? IconButton(
                                              onPressed: () {
                                                cart.removeItem(product);
                                              },
                                              icon: const Icon(
                                                Icons.delete_forever,
                                                size: 18,
                                              ))
                                          : IconButton(
                                              onPressed: () {
                                                cart.reduceByOne(product);
                                              },
                                              icon: const Icon(
                                                FontAwesomeIcons.minus,
                                                size: 18,
                                              )),
                                      Text(
                                        product.qty.toString(),
                                        style: product.qty == product.qntty
                                            ? const TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'Acme',
                                                color: Colors.red)
                                            : const TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'Acme'),
                                      ),
                                      IconButton(
                                          onPressed:
                                              product.qty == product.qntty
                                                  ? null
                                                  : () {
                                                      cart.increament(product);
                                                    },
                                          icon: const Icon(
                                            FontAwesomeIcons.plus,
                                            size: 18,
                                          ))
                                    ],
                                  ),
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
