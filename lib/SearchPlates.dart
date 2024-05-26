import 'package:CommuinTel/reusable_widgets.dart';
import 'package:CommuinTel/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Searchplates extends StatefulWidget {
  const Searchplates({super.key});

  @override
  State<Searchplates> createState() => _SearchplatesState();
}

class _SearchplatesState extends State<Searchplates> {
  final TextEditingController _platesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          leading: const Icon(Icons.menu),
          title: Text(
            'Garage',
            style: TextStyle(color: Colors.white, fontSize: 20.r),
          ),
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(35.r),
            ),
          ),
        ),
        body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.h),
            child: reusableTextField("Search using car plate", false,
                Icons.search, _platesController),
          ),
          SizedBox(
            height: 30.h,
          ),
          FutureBuilder<UserData?>(
            future: readUser(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.h),
                  child:
                      Image.asset('assets/images/searchcar.png', scale: 1.7.r),
                ));
              } else if (snapshot.hasData) {
                final user = snapshot.data;
                return user == null
                    ? const Center(child: Text('No User'))
                    : buildUser(user);
              } else {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 80.h),
                    child: Image.asset('assets/images/not-found.png',
                        scale: 0.7.r),
                  ),
                );
              }
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.r, horizontal: 25.h),
            child: Container(
                width: 200.w,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black54,
                        offset: const Offset(0, 1),
                        blurRadius: 12.0.r)
                  ],
                  borderRadius: BorderRadius.circular(30.0.r),
                  color: Colors.cyan,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 35.w,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: Text(
                        'SEARCH',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 27.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 35.r,
                    )
                  ],
                )),
          ),
        ])));
  }

  Widget buildUser(UserData user) => ListTile(
        leading: const CircleAvatar(child: Text("b")),
        title: Text(user.name),
        subtitle: Text(user.phone),
      );
  Future<UserData?> readUser() async {
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc(_platesController.text);
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return UserData.fromJson(snapshot.data()!);
    }
    return null;
  }

  // Stream<List<UserData>> readUsers() => FirebaseFirestore.instance
  //     .collection('users')
  //     .snapshots()
  //     .map((snapshot) =>
  //         snapshot.docs.map((doc) => UserData.fromJson(doc.data())).toList());
}
