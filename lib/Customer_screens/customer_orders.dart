import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/appbar_Widgets.dart';

class CustomerOrders extends StatelessWidget {
  const CustomerOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const AppBarTitle(title: 'Orders'),
          leading: const AppBarBackButton(),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('orders')
                .where('cid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
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
                  'You have not  \n\n Active Orders yet...',
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
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var order = snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.yellow,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        child: ExpansionTile(
                          title: Container(
                            constraints: const BoxConstraints(
                                maxHeight: 80, maxWidth: double.infinity),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Container(
                                    constraints: const BoxConstraints(
                                        maxHeight: 80, maxWidth: 80),
                                    child: Image.network(order['orderimage']),
                                  ),
                                ),
                                Flexible(
                                    child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      order['ordername'],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(('\$') +
                                                (order['orderprice']
                                                    .toStringAsFixed(2))),
                                            Text(('x ') +
                                                (order['orderqty'].toString()))
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ))
                              ],
                            ),
                          ),
                          subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('see more...'),
                                Text(order['deliverystatus'])
                              ]),
                          children: [
                            Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.yellow.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ('Name: ') + (order['customername']),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        ('Phone No: ') + (order['phone']),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        ('Email Address: ') + (order['email']),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        ('Address: ') + (order['address']),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        ('Payment status: ') +
                                            (order['paymentstatus']),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        ('Delivery status: ') +
                                            (order['deliverystatus']),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ]),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }));
  }
}
