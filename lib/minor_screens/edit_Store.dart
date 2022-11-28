import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_store_app/widgets/appbar_Widgets.dart';
import 'package:multi_store_app/widgets/snackBar.dart';
import 'package:multi_store_app/widgets/yellowbuttion.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_Storage;

class EditStore extends StatefulWidget {
  const EditStore({super.key, required this.data});
  final dynamic data;

  @override
  State<EditStore> createState() => _EditStoreState();
}

class _EditStoreState extends State<EditStore> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFileLogo;
  XFile? _imageFileCover;
  dynamic _pickedImageError;
  late String storename;
  late String phone;
  late String storeLogo;
  late String coverImage;
  bool processing = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  pickStoreLogo() async {
    try {
      final pickedStoreLogo = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        _imageFileLogo = pickedStoreLogo;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  pickCoverImage() async {
    try {
      final pickedCoverImage = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        _imageFileCover = pickedCoverImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  Future uploadStorelogo() async {
    if (_imageFileLogo != null) {
      try {
        firebase_Storage.Reference ref = firebase_Storage
            .FirebaseStorage.instance
            .ref('str-images/${widget.data['email']}.jpg');

        await ref.putFile(File(_imageFileLogo!.path));

        storeLogo = await ref.getDownloadURL();
      } catch (e) {
        print(e);
      }
    } else {
      storeLogo = widget.data['storelogo'];
    }
  }

  Future uploadCoverImage() async {
    if (_imageFileCover != null) {
      try {
        firebase_Storage.Reference ref2 = firebase_Storage
            .FirebaseStorage.instance
            .ref('str-images/${widget.data['email']}.jpg');

        await ref2.putFile(File(_imageFileCover!.path));

        coverImage = await ref2.getDownloadURL();
      } catch (e) {
        print(e);
      }
    } else {
      coverImage = widget.data['coverimage'];
    }
  }

  saveChanges() async {
    if (formKey.currentState!.validate()) {
      //continue
      formKey.currentState!.save();

      setState(() {
        processing = true;
      });
      await uploadStorelogo().whenComplete(() async =>
          await uploadCoverImage().whenComplete(() => editStoreData()));
    } else {
      myMesssageHandler.showSnackbar(
          scaffoldKey, 'please fill all fields first');
    }
  }

  editStoreData() async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('suppliers')
          .doc(FirebaseAuth.instance.currentUser!.uid);

      transaction.update(documentReference, {
        'storename': storename,
        'phone': phone,
        'storelogo': storeLogo,
        'coverimage': coverImage
      });
    }).whenComplete(() => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          leading: const AppBarBackButton(),
          elevation: 0,
          backgroundColor: Colors.white,
          title: AppBarTitle(title: 'Edit Store'),
        ),
        body: Form(
          key: formKey,
          child: Column(
            children: [
              Column(
                children: [
                  const Text(
                    'Store Logo',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(widget.data['storelogo']),
                        radius: 60,
                      ),
                      Column(
                        children: [
                          YellowButton(
                              label: 'Change',
                              onPressed: () {
                                pickStoreLogo();
                              },
                              width: 0.25),
                          const SizedBox(
                            height: 10,
                          ),
                          _imageFileLogo == null
                              ? const SizedBox()
                              : YellowButton(
                                  label: 'Reset',
                                  onPressed: () {
                                    setState(() {
                                      _imageFileLogo = null;
                                    });
                                  },
                                  width: 0.25),
                        ],
                      ),
                      _imageFileLogo == null
                          ? const SizedBox()
                          : CircleAvatar(
                              backgroundImage:
                                  FileImage(File(_imageFileLogo!.path)),
                              radius: 60,
                            ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Divider(
                      color: Colors.yellow,
                      thickness: 2.5,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Cover Image',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(widget.data['coverimage']),
                        radius: 60,
                      ),
                      Column(
                        children: [
                          YellowButton(
                              label: 'Change',
                              onPressed: () {
                                pickCoverImage();
                              },
                              width: 0.25),
                          const SizedBox(
                            height: 10,
                          ),
                          _imageFileCover == null
                              ? const SizedBox()
                              : YellowButton(
                                  label: 'Reset',
                                  onPressed: () {
                                    setState(() {
                                      _imageFileCover = null;
                                    });
                                  },
                                  width: 0.25),
                        ],
                      ),
                      _imageFileCover == null
                          ? const SizedBox()
                          : CircleAvatar(
                              backgroundImage:
                                  FileImage(File(_imageFileCover!.path)),
                              radius: 60,
                            ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Divider(
                      color: Colors.yellow,
                      thickness: 2.5,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter store name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    storename = value!;
                  },
                  initialValue: widget.data['storename'],
                  decoration: textFormDecoration.copyWith(
                      labelText: 'store name', hintText: 'Enter store name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter phone number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    phone = value!;
                  },
                  initialValue: widget.data['phone'],
                  decoration: textFormDecoration.copyWith(
                      labelText: 'phone', hintText: 'Enter phone'),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    YellowButton(
                      label: 'cancle',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      width: 0.25,
                    ),
                    processing == true
                        ? YellowButton(
                            label: 'please wait...',
                            onPressed: () {
                              null;
                            },
                            width: 0.5,
                          )
                        : YellowButton(
                            label: 'save changes',
                            onPressed: () {
                              saveChanges();
                            },
                            width: 0.5,
                          )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

var textFormDecoration = InputDecoration(
  labelText: 'price',
  hintText: 'price .. \$',
  labelStyle: const TextStyle(color: Colors.purple),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.yellow, width: 1),
      borderRadius: BorderRadius.circular(10)),
  focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
      borderRadius: BorderRadius.circular(10)),
);
