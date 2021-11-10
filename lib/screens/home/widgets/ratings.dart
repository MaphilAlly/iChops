import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:ichops/constants/constraints.dart';

class RatingMethod extends StatelessWidget {
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users Rating"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('usersRating').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return ListView(
              children: snapshot.data.docs.map((doc) {
                return Card(
                  child: ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(doc.data()['image'])),
                          shape: BoxShape.circle),
                    ),
                    title: Row(
                      children: [
                        Text("${doc.data()['product']}"),
                        Spacer(),
                        Text(
                          "${doc.data()['rating']} ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.star,
                          color: mySecondaryColor,
                        )
                      ],
                    ),
                    subtitle: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text("${doc.data()['name']} says: ")),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${doc.data()['comment']}",
                              style: TextStyle(fontStyle: FontStyle.italic),
                            )),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
        },
      ),
    );
  }
}
