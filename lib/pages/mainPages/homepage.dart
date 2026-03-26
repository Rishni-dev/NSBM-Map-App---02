import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:nsbm_map/pages/Components/gridcon.dart';
import 'package:nsbm_map/pages/SecondaryPages/campusmap.dart';
import 'package:nsbm_map/pages/SecondaryPages/lectureschedule.dart';
import 'package:nsbm_map/pages/SecondaryPages/newsannouncements.dart';
import 'package:nsbm_map/pages/SecondaryPages/aboutcampus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var dt = DateTime.now();

    String date1 = DateFormat('E d MMM').format(dt);
    String date2 = DateFormat('j').format(dt);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 184, 245, 205),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .where('id',
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var docs = snapshot.data!.docs;

                        return dt.hour <= 12
                            ? Text(
                                "Good Morning  ${docs[0]['name']}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              )
                            : Text(
                                "Good Evening  ${docs[0]['name']}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              );
                      } else {
                        return const Center();
                      }
                    }),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  height: 400,
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: [
                      GridCon(
                        text: "Lecture Schedule",
                        image: "calendar.png",
                        onCl: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LectureSchedule(),
                              ));
                        },
                      ),
                      GridCon(
                        text: "Campus Map",
                        image: "map.png",
                        onCl: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CampusMap(),
                              ));
                        },
                      ),
                      GridCon(
                        text: "News & Announcements",
                        image: "news.png",
                        onCl: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const NewsAnnouncementsPage(),
                              ));
                        },
                      ),
                      GridCon(
                        text: "About Campus",
                        image: "info.png",
                        onCl: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AboutCampusPage(),
                              ));
                        },
                      ),
                    ],
                  ),
                )
              ]),
        ),
      )),
    );
  }
}
