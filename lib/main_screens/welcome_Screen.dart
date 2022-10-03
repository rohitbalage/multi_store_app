import 'package:flutter/material.dart';
import '../widgets/yellowbuttion.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/inapp/bgimage.jpg'),
                fit: BoxFit.cover)),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'WELCOME',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                const SizedBox(
                  height: 120,
                  width: 200,
                  child: Image(image: AssetImage('images/inapp/logo.jpg')),
                ),
                const Text(
                  'SHOP',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              color: Colors.white38,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  bottomLeft: Radius.circular(50))),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              'Suppliers only',
                              style: TextStyle(
                                  color: Colors.yellowAccent,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: const BoxDecoration(
                                  color: Colors.white38,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      bottomLeft: Radius.circular(50))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Image(
                                    image: AssetImage('images/inapp/logo.jpg'),
                                  ),
                                  YellowButton(
                                    width: 0.25,
                                    label: 'Log In',
                                    onPressed: () {},
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: YellowButton(
                                      width: 0.25,
                                      label: 'Sign up',
                                      onPressed: () {},
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: const BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(50))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: YellowButton(
                          width: 0.25,
                          label: 'Log In',
                          onPressed: () {},
                        ),
                      ),
                      YellowButton(
                        width: 0.25,
                        label: 'Sign up',
                        onPressed: () {},
                      ),
                      const Image(
                        image: AssetImage('images/inapp/logo.jpg'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white38,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GoogleFacebookLogIn(
                            label: 'Google',
                            onPressed: () {},
                            child: const Image(
                                image: AssetImage('images/inapp/google.jpg')),
                          ),
                          GoogleFacebookLogIn(
                            label: 'Facebook',
                            onPressed: () {},
                            child: const Image(
                                image: AssetImage('images/inapp/facebook.jpg')),
                          ),
                          GoogleFacebookLogIn(
                              label: 'Google',
                              onPressed: () {},
                              child: Icon(
                                Icons.person,
                                size: 55,
                                color: Colors.lightBlueAccent,
                              ))
                        ]),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}

class GoogleFacebookLogIn extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final Widget child;
  const GoogleFacebookLogIn(
      {super.key,
      required this.label,
      required this.onPressed,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onPressed,
        child: Column(
          children: [
            SizedBox(height: 50, width: 50, child: child),
            Text(
              'Google',
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
