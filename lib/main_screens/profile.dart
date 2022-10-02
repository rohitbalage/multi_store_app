import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        height: 230,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.yellow, Colors.brown])),
      ),
      CustomScrollView(slivers: [
        SliverAppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          pinned: true,
          expandedHeight: 200,
          flexibleSpace: LayoutBuilder(builder: (context, Constraints) {
            return FlexibleSpaceBar(
              title: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: Constraints.biggest.height <= 120 ? 1 : 0,
                child: const Text('Account',
                    style: TextStyle(color: Colors.black)),
              ),
              background: Container(
                decoration: const BoxDecoration(
                    gradient:
                        LinearGradient(colors: [Colors.yellow, Colors.brown])),
                child: Padding(
                  padding: const EdgeInsets.only(top: 25, left: 30),
                  child: Row(
                    children: [
                      const CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('images/inapp/guest.jpg')),
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Text(
                          'guest'.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
        SliverToBoxAdapter(
          child: Column(children: [
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(50)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomLeft: Radius.circular(30)),
                      ),
                      child: TextButton(
                        child: const Center(
                          child: Text(
                            'Cart',
                            style:
                                TextStyle(color: Colors.yellow, fontSize: 20),
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      color: Colors.yellow,
                      child: TextButton(
                        child: const Center(
                          child: Text(
                            'Orders',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 20),
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                      ),
                      child: TextButton(
                        child: const Center(
                          child: Text(
                            'Whishlist',
                            style:
                                TextStyle(color: Colors.yellow, fontSize: 20),
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ]),
            ),
            Container(
              color: Colors.grey.shade300,
              child: Column(children: [
                const SizedBox(
                  height: 150,
                  child: Image(image: AssetImage('images/inapp/logo.jpg')),
                ),

                //calling profileheaderlabel
                const ProfileHeaderLabel(
                  headerLabel: 'Account info',
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 260,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(children: const [
                      RepeatedListTile(
                          icon: Icons.email,
                          subTitle: 'example@email.com',
                          title: 'Email Address'),
                      YellowDivider(),
                      RepeatedListTile(
                          icon: Icons.phone,
                          subTitle: '1111111111',
                          title: 'Phone Number'),
                      YellowDivider(),
                      RepeatedListTile(
                          icon: Icons.location_pin,
                          subTitle: '1801 E 12th screen',
                          title: 'Adress'),
                    ]),
                  ),
                ),
                const ProfileHeaderLabel(headerLabel: ' Account Settings  '),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 260,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(children: [
                      RepeatedListTile(
                        title: 'Edit Profile',
                        subTitle: '',
                        icon: Icons.edit,
                        onPressed: () {},
                      ),
                      YellowDivider(),
                      RepeatedListTile(
                        title: 'Change Password',
                        icon: Icons.lock,
                        onPressed: () {},
                      ),
                      YellowDivider(),
                      RepeatedListTile(
                        title: 'Log Out',
                        icon: Icons.logout,
                        onPressed: () {},
                      ),
                    ]),
                  ),
                ),
              ]),
            ),
          ]),
        )
      ])
    ]));
  }
}

class YellowDivider extends StatelessWidget {
  const YellowDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Divider(
        color: Colors.yellow,
        thickness: 1,
      ),
    );
  }
}

class RepeatedListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final Function()? onPressed;
  const RepeatedListTile({
    super.key,
    required this.icon,
    this.onPressed,
    this.subTitle = '',
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ListTile(
        title: Text(title),
        subtitle: Text(subTitle),
        leading: Icon(icon),
      ),
    );
  }
}

class ProfileHeaderLabel extends StatelessWidget {
  final String headerLabel;
  const ProfileHeaderLabel({super.key, required this.headerLabel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(
          height: 40,
          width: 50,
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
        Text(
          headerLabel,
          style: const TextStyle(
              color: Colors.grey, fontSize: 24, fontWeight: FontWeight.w600),
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
