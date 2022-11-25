import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/Customer_screens/add_address.dart';
import 'package:multi_store_app/widgets/appbar_widgets.dart';
import 'package:multi_store_app/widgets/yellowbuttion.dart';

class AddressBook extends StatefulWidget {
  const AddressBook({super.key});

  @override
  State<AddressBook> createState() => _AddressBookState();
}

class _AddressBookState extends State<AddressBook> {
  final Stream<QuerySnapshot> addressStream = FirebaseFirestore.instance
      .collection('customers')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('address')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const AppBarBackButton(),
        title: const AppBarTitle(title: 'Address Book'),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: addressStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Material(
                      child: Center(child: CircularProgressIndicator()));
                }

                if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                      child: Text(
                    'you don\'t have set an \n\n has no address yet',
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
                      var customer = snapshot.data!.docs[index];
                      return GestureDetector(
                        onTap: () async {
                          for (var item in snapshot.data!.docs) {
                            await FirebaseFirestore.instance
                                .runTransaction((transaction) async {
                              DocumentReference documentReference =
                                  FirebaseFirestore.instance
                                      .collection('customer')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .collection('address')
                                      .doc(item.id);
                              transaction.update(
                                  documentReference, {'default': false});
                            });
                          }
                          await FirebaseFirestore.instance
                              .runTransaction((transaction) async {
                            DocumentReference documentReference =
                                FirebaseFirestore.instance
                                    .collection('customer')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection('address')
                                    .doc(customer['addressid']);
                            transaction
                                .update(documentReference, {'default': true});
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: Colors.yellow,
                            child: ListTile(
                              trailing: customer['default'] == true
                                  ? const Icon(Icons.home)
                                  : const SizedBox(),
                              title: SizedBox(
                                height: 50,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          '${customer['firstname']} - ${customer['lastname']}'),
                                      Text('${customer['phone']}'),
                                    ]),
                              ),
                              subtitle: SizedBox(
                                height: 70,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'City/State: ${customer['city']} ${customer['state']}'),
                                      Text('country: ${customer['country']}'),
                                    ]),
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
          YellowButton(
              label: 'Add New Address',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddAddress()));
              },
              width: 0.8)
        ],
      )),
    );
  }
}
