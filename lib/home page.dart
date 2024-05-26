import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Login.dart';

class HomePage extends StatefulWidget {
  final String email;
  final String name;

  const HomePage({super.key, required this.email, required this.name});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Add your navigation logic here
    switch (index) {
      case 0:

        break;
      case 1:

        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
      // Navigate to profile page or perform action for profile
        _scaffoldKey.currentState?.openDrawer();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xffe2eff7),
        leading: IconButton(
            alignment:Alignment.centerRight,
          icon: const Icon(Icons.arrow_back, color: Color(0xff0E5784)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: const [
          Icon(Icons.notifications, color: Color(0xff0E5784)),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xffe2eff7),
              ),
              child: Text(
                'Settings',
                style: TextStyle(
                  color: Color(0xff0E5784),
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Color(0xff0E5784)),
              title: const Text('Exit'),
              onTap: () {
                SystemNavigator.pop();

              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Color(0xff0E5784)),
              title: const Text('Sign Out'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const Login()));
              },
            ),
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: const Color(0xffe2eff7),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 0.0.h),
            child: Column(
              children: [
                FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.email)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    if (!snapshot.hasData || snapshot.hasError) {
                      return const Text('Error retrieving data');
                    }

                    var userData = snapshot.data!.data() as Map<String, dynamic>;

                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.0.w, bottom: 10.h),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  userData['image'] ?? 'https://img.freepik.com/premium-photo/cartoon-avatar-man-with-glasses-beard-generative-ai_1034989-21032.jpg?w=740',
                                ), // Use user's profile image from Firebase
                              ),
                              const SizedBox(width: 10),
                              Text(widget.name, style: const TextStyle(color: Color(0xff0E5784))), // Use the passed name
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.h),
                          child: TextField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search, color: Colors.black),
                              hintText: 'Search',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0.r),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        if (userData['post'] != null && userData['post'].isNotEmpty) ...[
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userData['name'] ?? 'No name',
                                  style: const TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff0E5784)),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  userData['post'] ?? 'No post',
                                  style: const TextStyle(fontSize: 16, color: Color(0xff0E5784)),
                                ),
                                SizedBox(height: 10.h),
                                GestureDetector(
                                  onTap: () {
                                    showComments(context, widget.email);
                                  },
                                  child: const Text(
                                    'View Comments',
                                    style: TextStyle(
                                      color: Color(0xff0E5784),
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Color(0xffe2eff7),



            icon: Icon(Icons.home, color: Color(0xff0E5784)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Color(0xff0E5784)),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department, color: Color(0xff0E5784)),
            label: 'Trending',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Color(0xff0E5784)),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Color(0xff0E5784)),
            label: 'Settings',

          ),
        ],
        selectedItemColor: const Color(0xff0E5784),
      ),
    );
  }

  void showComments(BuildContext context, String email) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Comments', style: TextStyle(color: Color(0xff0E5784))),
          content: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance.collection('users').doc(email).get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              if (!snapshot.hasData || snapshot.hasError) {
                return const Text('Error retrieving comments');
              }

              var userData = snapshot.data!.data() as Map<String, dynamic>;
              return Text(userData['comment'] ?? 'No comments', style: const TextStyle(color: Color(0xff0E5784)));
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close', style: TextStyle(color: Color(0xff0E5784))),
            ),
          ],
        );
      },
    );
  }
}
