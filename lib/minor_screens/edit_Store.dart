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
          )
        ],
      ),
    );
  }
}
