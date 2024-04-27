import 'package:flutter/material.dart';
import 'package:women_safety_app/child/bottom_screens/add_contacts.dart';
import 'package:women_safety_app/child/bottom_screens/chat_page.dart';
import 'package:women_safety_app/child/bottom_screens/child_home_page.dart';
import 'package:women_safety_app/child/bottom_screens/profile_page.dart';

import 'package:women_safety_app/screens/home.dart';
import 'package:women_safety_app/utils/constants.dart';

class BottomPage extends StatefulWidget {
  BottomPage({Key? key}) : super(key: key);

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int currentIndex = 0;
  List<Widget> pages = [
    HomeScreen(),
    AddContactsPage(),
    CheckUserStatusBeforeChat(),
    CheckUserStatusBeforeChatOnProfile(),
    HomeScreen1(),
  ];
  onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: onTapped,
        selectedItemColor: primaryColor,
        items: [
          BottomNavigationBarItem(
              label: 'home',
              icon: Icon(
                Icons.home,
              )),
          BottomNavigationBarItem(
              label: 'contacts',
              icon: Icon(
                Icons.contacts,
              )),
          BottomNavigationBarItem(
              label: 'chats',
              icon: Icon(
                Icons.chat,
              )),
          BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(
                Icons.person,
              )),
          BottomNavigationBarItem(
              label: 'Notes',
              icon: Icon(
                Icons.note_sharp,
              )),
        ],
      ),
    );
  }
}
