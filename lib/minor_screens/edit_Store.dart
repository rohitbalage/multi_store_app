import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_store_app/widgets/appbar_Widgets.dart';
import 'package:multi_store_app/widgets/yellowbuttion.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        elevation: 0,
        backgroundColor: Colors.white,
        title: AppBarTitle(title: 'Edit Store'),
      ),
      body: Column(
        children: [
          Column(
            children: [
              Text(
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
              Text(
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
                    backgroundImage: NetworkImage(widget.data['coverimage']),
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
              initialValue: widget.data['storename'],
              decoration: textFormDecoration.copyWith(
                  labelText: 'store name', hintText: 'Enter store name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: widget.data['phone'],
              decoration: textFormDecoration.copyWith(
                  labelText: 'phone', hintText: 'Enter phone'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
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
                YellowButton(
                  label: 'save changes',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  width: 0.5,
                )
              ],
            ),
          )
        ],
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
