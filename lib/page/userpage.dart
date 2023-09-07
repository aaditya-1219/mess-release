
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sub_mgmt/globals.dart';
import 'package:sub_mgmt/page/utils/admin_preferences.dart';
import 'package:sub_mgmt/widget/appbarwidget.dart';
import 'package:sub_mgmt/login/provider/auth_provider.dart';
import 'package:sub_mgmt/widget/navigation_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../login/screens/welcome_screen.dart';
import '../widget/profilewidget.dart';
import 'editprofile.dart';
import 'model/admin.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  // String userName = '';
  // String userEmail = '';
  // String userPhoto = '';
  // late var doc = FirebaseFirestore.instance.collection('admins').doc('${currentUser?.uid}').get().then((value){
  // userName = value['name'];
  // userEmail = value['email'];
  // userPhoto = value['profilePic'];
  // });
  // String url = Uri.encodeFull("https://youtu.be/5NiXlPrLslg?si=w3C4hbYAbzutFKl4");



  // void _launchURL(url) async {
  //   if (await canLaunchUrl(url)) {
  //     await launchUrl(url);
  //   } else {
  //     // Handle the error gracefully, e.g., show a snackbar or dialog
  //     print('Could not launch $url');
  //     // You can display an error message to the user here
  //   }
  // }

  _launchURL() async {
    final Uri url = Uri.parse('https://youtu.be/-OyiRB0WPNc?si=3LHWCV0J-VNcj5ua');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }


  final FirebaseAuth _auth = FirebaseAuth.instance;

  static const menuItems = <String>[
    'English',
    'Hindi',
    'Marathi',
  ];
  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();
  final List<PopupMenuItem<String>> _popUpMenuItems = menuItems
      .map(
        (String value) => PopupMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  String _btn1SelectedVal = 'English';




  @override
  Widget build(BuildContext context) {
    final admin = AdminPreferences.getAdmin();
    final ap = Provider.of<AuthProvider>(context, listen: false);
    // print(userPhoto);
    return Scaffold(

        appBar:AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor:  Color.fromRGBO(25, 55, 109,1),
          elevation: 8,
          toolbarHeight: 70,
          title: Text(
            "Setting".tr,
            style: TextStyle(
                fontFamily: GoogleFonts.rubik().fontFamily
              // fontWeight: FontWeight.bold
            ),
          ),
        ),
        // buildAppBar(context, "Setting".tr,),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Column(
              children: [
                // ProfileWidget(
                //   imagePath: 'assets/images/defaultphoto.png',
                //   onClicked: () async {
                //     print(admin.imagePath);
                //     await Navigator.of(context).push(
                //         MaterialPageRoute(builder: (context) => EditProfile()));
                //     setState(() {});
                //   },
                // ),

                const SizedBox(height: 24),
                // buildName(admin),

                ListTile(
                  // contentPadding: EdgeInsets.all(20.0),
                  contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 0),

                  title: Text(
                    "Change_lan".tr,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  trailing: DropdownButton<String>(
                    // Must be one of items.value.
                    value: _btn1SelectedVal,
                    onChanged: (String? newValue) {
                      _language(newValue!);
                    },
                    items: this._dropDownMenuItems,
                  ),
                ),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: Text("How to use?"),
                                content: SingleChildScrollView(
                              //     child: Text(
                              //       "Tutorial \n"
                              //
                              //       "Step 1: Accessing the Expense Tracker,\n"
                              //        "1. Open the Mess Management app on your device.\n"
                              //        "2. After logging in, you'll be directed to the dashboard.\n"
                              //         "Step 2: Navigating to the Members Page\n"
                              //  "On the home page or dashboard, locate and tap on the\n"
                              //           "Members section.\n\n This section might be labeled as Members or represented by an icon like Users.\n\n"
                              //     "Click/tap on the Members section to access the page where you can manage members.\n\n"
                              //
                              //        " Step 3: Searching for a Member\n"
                              // "On the Members page, locate the search bar at the top of the page.\n"
                              //     "This search bar is designed to accommodate search queries in Hindi, Marathi, and English.\n\n"
                              //           "NOTE: Expense Tracker data is lost after a week and reset to default.\n"
                              //
                              //     ),


                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Tutorial ",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _launchURL();
                                              // _launchURL('https://youtu.be/5NiXlPrLslg');
                                            },
                                            child: Text(
                                              "(Tutorial on YouTube)",
                                              style: TextStyle(
                                                color: Colors.blue,
                                                decoration: TextDecoration.underline,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10), // Add some space between the link and the content below
                                      Text(
                                        "Step 1: Accessing the Expense Tracker,\n"
                                            "1. Open the Mess Management app on your device.\n"
                                            "2. After logging in, you'll be directed to the dashboard.\n"
                                            "Step 2: Navigating to the Members Page\n"
                                            "On the home page or dashboard, locate and tap on the\n"
                                            "Members section.\n\n"
                                            "This section might be labeled as Members or represented by an icon like Users.\n\n"
                                            "Click/tap on the Members section to access the page where you can manage members.\n\n"
                                            "Step 3: Searching for a Member\n"
                                            "On the Members page, locate the search bar at the top of the page.\n"
                                            "This search bar is designed to accommodate search queries in Hindi, Marathi, and English.\n\n"
                                            "NOTE: Expense Tracker data is lost after a week and reset to default.\n",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),









                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                    child: Text("Close"),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Text("Help"),
                        ),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text("How to use the App"),
                            content: Text("You can reach us at shailendramahadule08@gmail.com or aadityapatil1910@gmail.com or rakeshbdharne103@gmail.com"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text("Close"),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text("Contact Us"),
                    ),

                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    ap.userSignOut().then(
                          (value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WelcomeScreen(),
                        ),
                      ),
                    );
                  },
                  child: Text("Sign Out"),
                ),

              ],
            ),
          ],
        ));
  }

  void _language(String newValue) {
    setState(() => _btn1SelectedVal = newValue);
    if (newValue == 'Hindi') {
      var local = Locale('hi', 'IN');
      Get.updateLocale(local);
    } else if (newValue == 'English') {
      var local1 = Locale('en', 'US');
      Get.updateLocale(local1);
    } else {
      var local2 = Locale('mr', 'IN');
      Get.updateLocale(local2);
    }
  }

  // Widget buildName(Admin admin) {
  //   // FirebaseFirestore.instance.collection('admins').doc('${currentUser?.uid}').get().then((value){
  //   //   userName = value['name'];
  //   //   userEmail = value['email'];
  //   //   // print(userName);
  //   // }
  //   // );
  //   return Column(
  //     children: [
  //       Text(
  //           // admin.name,
  //         userName,
  //           style: TextStyle(
  //             fontWeight: FontWeight.bold,
  //             fontSize: 24,
  //           )),
  //       const SizedBox(height: 4),
  //       Text(
  //         // admin.email,
  //         userEmail,
  //         style: TextStyle(
  //           color: Colors.grey,
  //         ),
  //       )
  //     ],
  //   );
  // }
}
