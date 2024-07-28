import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/HomeScreen/home_screen.dart';
import 'package:olx_clone/Widgets/global_varibale.dart';

import '../Widgets/listview_widget.dart';

class ProfileScreen extends StatefulWidget {
  String sellerId;
  ProfileScreen({super.key, required this.sellerId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Methords that are used in profile screen

  _buildBackButton() {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      },
    );
  }

  _buildUserImage() {
    return Container(
      width: 50,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: NetworkImage(adUserImageUrl), fit: BoxFit.fill),
      ),
    );
  }

  getResult() {
    FirebaseFirestore.instance
        .collection('items')
        .where('id', isEqualTo: widget.sellerId)
        .where('status', isEqualTo: 'Approved')
        .get()
        .then((results) {
      setState(() {
        items = results;
        adUserName = items!.docs[0].get('userName');
        adUserImageUrl = items!.docs[0].get('imgPro');
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getResult();
  }

  QuerySnapshot? items;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
          backgroundColor: Colors.green,
          leading: _buildBackButton(),
          title: Row(
            children: [
              _buildUserImage(),
              const SizedBox(
                width: 10,
              ),
              Text(adUserName),
            ],
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('items')
              .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .orderBy('time', descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data!.docs.isNotEmpty) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListViewWidget(
                      docId: snapshot.data!.docs[index].id,
                      itemColor: snapshot.data!.docs[index]['itemColor'],
                      img1: snapshot.data!.docs[index]['urlImage1'],
                      img2: snapshot.data!.docs[index]['urlImage2'],
                      img3: snapshot.data!.docs[index]['urlImage3'],
                      img4: snapshot.data!.docs[index]['urlImage4'],
                      img5: snapshot.data!.docs[index]['urlImage5'],
                      userImg: snapshot.data!.docs[index]['imgPro'],
                      name: snapshot.data!.docs[index]['userName'],
                      date: snapshot.data!.docs[index]['time'].toDate(),
                      userId: snapshot.data!.docs[index]['id'],
                      itemModel: snapshot.data!.docs[index]['itemModel'],
                      postId: snapshot.data!.docs[index]['postId'],
                      itemPrice: snapshot.data!.docs[index]['itemPrice'],
                      description: snapshot.data!.docs[index]['description'],
                      lat: snapshot.data!.docs[index]['lat'],
                      lng: snapshot.data!.docs[index]['lat'],
                      address: snapshot.data!.docs[index]['address'],
                      userNumber: snapshot.data!.docs[index]['userNumber'],
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text('There is no task'),
                );
              }
            }
            return const Center(
              child: Text(
                'Something went wrong',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            );
          },
        ),
      ),
    );
  }
}
