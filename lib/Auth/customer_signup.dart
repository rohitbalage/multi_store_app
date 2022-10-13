import 'package:flutter/material.dart';

import '../widgets/auth_widgets.dart';

// final TextEditingController _nameController = TextEditingController();
// final TextEditingController _emailController = TextEditingController();
// final TextEditingController _passwordController = TextEditingController();

class CustomerRegister extends StatefulWidget {
  const CustomerRegister({super.key});

  @override
  _CustomerRegisterState createState() => _CustomerRegisterState();
}

class _CustomerRegisterState extends State<CustomerRegister> {
  late String name;
  late String email;
  late String password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        const Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.purpleAccent,
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15))),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  print('Pick image from camera');
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15))),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.photo,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  print('Pick image from gallery');
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
                              return 'Please enter your full name';
                            }
                            return null;
                          },
                          onChanged: (Value) {
                            name = Value;
                            print(name);
                          },
                          // controller: _nameController,
                          decoration: textFormDecoration.copyWith(
                              labelText: 'Full Name',
                              hintText: 'Enter your full name'),
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
                            print(email);
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
                            print(password);
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
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.purple,
                                  )),
                              hintText: 'Enter your password'),
                        )),
                    HaveAccount(
                      haveAccount: 'already have an account?',
                      actionLabel: 'log In',
                      onPressed: () {},
                    ),
                    AuthMainButton(
                      mainButtonLabel: 'Sign Up',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print('valid');
                          print(name);
                          print(email);
                          print(password);
                        } else {
                          print('not valid');
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
