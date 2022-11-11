import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/auth_widgets.dart';
import '../widgets/snackBar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_Storage;

class SupplierRegister extends StatefulWidget {
  const SupplierRegister({super.key});

  @override
  _SupplierRegisterState createState() => _SupplierRegisterState();
}

class _SupplierRegisterState extends State<SupplierRegister> {
  late String storeName;
  late String email;
  late String password;
  late String storeLogo;
  late String _uid;
  bool processing = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  bool passwordVisible = false;
  final ImagePicker _picker = ImagePicker();

  XFile? _imageFile;
  dynamic _pickedImageError;

  CollectionReference suppliers =
      FirebaseFirestore.instance.collection('suppliers');

  void _pickImageFromCamera() async {
    try {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.camera,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        _imageFile = pickedImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  void _pickImageFromGallery() async {
    try {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        _imageFile = pickedImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  void signUp() async {
    setState(() {
      processing = true;
    });
    if (_formKey.currentState!.validate()) {
      if (_imageFile != null) {
        try {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);

          firebase_Storage.Reference ref = firebase_Storage
              .FirebaseStorage.instance
              .ref('str-images/$email.jpg');

          await ref.putFile(File(_imageFile!.path));
          _uid = FirebaseAuth.instance.currentUser!.uid;

          storeLogo = await ref.getDownloadURL();
          await suppliers.doc(_uid).set({
            'storename': storeName,
            'email': email,
            'storelogo': storeLogo,
            'phone': '',
            'sid': _uid,
            'coverimage': '',
          });

          _formKey.currentState!.reset();
          setState(() {
            _imageFile = null;
          });

          Navigator.pushReplacementNamed(context, '/supplier_login');
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            setState(() {
              processing = false;
            });
            myMesssageHandler.showSnackbar(
                _scaffoldKey, 'that is a weak password');
          } else if (e.code == 'email-already-in-use') {
            setState(() {
              processing = false;
            });
            myMesssageHandler.showSnackbar(
                _scaffoldKey, 'that email is already used by another user');
          }
        }
      } else {
        setState(() {
          processing = false;
        });
        myMesssageHandler.showSnackbar(
            _scaffoldKey, 'Please pick up image first');
      }
    } else {
      setState(() {
        processing = false;
      });
      myMesssageHandler.showSnackbar(_scaffoldKey, 'Please fill all fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const AuthHeaderLabel(
                        headerLabel: 'Sign Up',
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 40),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.yellowAccent,
                              backgroundImage: _imageFile == null
                                  ? null
                                  : FileImage(File(_imageFile!.path)),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.yellowAccent,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15))),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    _pickImageFromCamera();
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.yellowAccent,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15))),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.photo,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    _pickImageFromGallery();
                                  },
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your store name';
                              }
                              return null;
                            },
                            onChanged: (Value) {
                              storeName = Value;
                            },
                            // controller: _nameController,
                            decoration: textFormDecoration.copyWith(
                                labelText: 'Store Name',
                                hintText: 'Enter your store name'),
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              } else if (value.isValidEmail() == false) {
                                return 'invalid email';
                              } else if (value.isValidEmail() == true) {
                                return null;
                              }
                              return null;
                            },
                            onChanged: (Value) {
                              email = Value;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: textFormDecoration.copyWith(
                                labelText: 'Email Address',
                                hintText: 'Enter your email'),
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            onChanged: (Value) {
                              password = Value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your password';
                              }
                              return null;
                            },
                            obscureText: passwordVisible,
                            decoration: textFormDecoration.copyWith(
                                labelText: 'Password',
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        passwordVisible = !passwordVisible;
                                      });
                                    },
                                    icon: Icon(
                                      passwordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.purple,
                                    )),
                                hintText: 'Enter your password'),
                          )),
                      HaveAccount(
                        haveAccount: 'already have an account?',
                        actionLabel: 'log In',
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/supplier_login');
                        },
                      ),
                      processing == true
                          ? const CircularProgressIndicator(
                              color: Colors.purple,
                            )
                          : AuthMainButton(
                              mainButtonLabel: 'Sign Up',
                              onPressed: () async {
                                signUp();
                              },
                            )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
