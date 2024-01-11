// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element, sort_child_properties_last, library_private_types_in_public_api, prefer_interpolation_to_compose_strings, unused_import, use_super_parameters, prefer_typing_uninitialized_variables, unused_local_variable, deprecated_member_use, sized_box_for_whitespace, duplicate_import

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fb/chat/chat_page.dart';
import 'package:fb/features/user_auth/presentation/pages/category.dart';
import 'package:fb/features/user_auth/presentation/pages/login_page.dart';
import 'package:fb/features/user_auth/presentation/pages/notify.dart';
import 'package:fb/features/user_auth/presentation/pages/presentation2/profile.dart';
import 'package:fb/features/user_auth/presentation/pages/profile.dart';
import 'package:fb/features/user_auth/presentation/pages/scanner.dart';
import 'package:fb/features/user_auth/presentation/pages/settings.dart';
import 'package:fb/features/user_auth/presentation/pages/transport_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final bottomNavIndexProvider = StateProvider((ref) => 0);

class HomePage extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white24,
        appBar: _appBar(context),
        drawer: _drawer(
            context,
            FirebaseAuth.instance.currentUser?.email ??
                'arjunfree256@gmail.com'),
        body: Consumer(builder: (context, ref, child) {
          final currentIndex = ref.watch(bottomNavIndexProvider);
          return IndexedStack(
            index: currentIndex,
            children: [PageScanner(), ChatPage(), SettingsPage()],
          );
        }),
        bottomNavigationBar: Consumer(
          builder: (context, ref, child) {
            final currentIndex = ref.watch(bottomNavIndexProvider);
            return Theme(
                data: ThemeData(
                  canvasColor: Color.fromARGB(255, 25, 201, 204),
                  primaryColor: Colors.black12,
                ),
                child: BottomNavigationBar(
                    currentIndex: currentIndex,
                    selectedItemColor: Colors.black,
                    unselectedItemColor: Colors.black45,
                    items: [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.qr_code_scanner_outlined),
                          label: 'Scan'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.chat_bubble_outline),
                          label: 'ChatBot'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.settings_outlined),
                          label: 'setting'),
                    ],
                    onTap: (value) {
                      ref
                          .read(bottomNavIndexProvider.notifier)
                          .update((state) => value);
                    }));
          },
        ));
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
        backgroundColor: Color.fromARGB(255, 25, 201, 204),
        title: Padding(
          padding: EdgeInsets.only(left: 70),
          child: SafeArea(
            child: Text(
              'Health Lens',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ));
  }

  Drawer _drawer(BuildContext context, String profile) {
    return Drawer(
        backgroundColor: Colors.white,
        child: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('userProfile')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              var userData = snapshot.data!.data() as Map<String, dynamic>;

              return Container(
                height: double.infinity,
                child: Column(
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 25, 201, 204),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: CachedNetworkImageProvider(
                              userData['imageLink'] ??
                                  'images/dp.png', // Use placeholder if null
                            ), // Use placeholder if null
                          ),
                          SizedBox(width: 16),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userData['name'] ?? '',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                profile,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: GestureDetector(
                        child: Icon(
                          Icons.account_circle_rounded,
                          size: 38,
                        ),
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => ProfilePage(),
                        )),
                      ),
                      title: GestureDetector(
                        child: Text(
                          "Profile",
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => ProfilePage(),
                        )),
                      ),
                    ),
                    ListTile(
                      leading: GestureDetector(
                        child: Icon(
                          Icons.question_mark_rounded,
                          size: 38,
                        ),
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => ProfilePage(),
                        )),
                      ),
                      title: GestureDetector(
                        child: Text(
                          "Get Help",
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => GetHelp(),
                        )),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.info_outline,
                        size: 38,
                      ),
                      title: Text("About As"),
                      textColor: Colors.black,
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => AboutScreen(),
                      )),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.call,
                        size: 38,
                      ),
                      title: Text("Contact Us"),
                      textColor: Colors.black,
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => ContactUsPage(),
                      )),
                    ),
                    ListTile(
                      leading: Icon(Icons.copy, size: 38),
                      title: Text(
                        "Terms and Condition",
                      ),
                      textColor: Colors.black,
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (BuildContext context) => LoginPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 25, 201, 204),
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Container(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Center(
                            child: Text("Log Out"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }));
  }

  Column _categoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 40),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Department',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              height: 115,
              child: ListView.separated(
                itemCount: CategoryModel.getCategories().length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 20, right: 20),
                separatorBuilder: (context, index) => SizedBox(
                  width: 25,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.5),
                      color: CategoryModel.getCategories()[index]
                          .boxColor
                          .withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                                CategoryModel.getCategories()[index].iconPath),
                          ),
                        ),
                        Text(
                          CategoryModel.getCategories()[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 19,
                          ),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  Container _searchField() {
    return Container(
      margin: EdgeInsets.only(top: 40, left: 20, right: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xff1D1617).withOpacity(0.11),
            blurRadius: 40,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(15),
          hintText: 'Search the place here',
          hintStyle: TextStyle(color: Color(0xffDDDADA), fontSize: 15),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(Icons.search, color: Colors.black),
          ),
          suffixIcon: SizedBox(
            width: 100,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  VerticalDivider(
                    color: Colors.black,
                    indent: 10,
                    endIndent: 10,
                    thickness: 1.2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Icon(Icons.filter_list, color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
