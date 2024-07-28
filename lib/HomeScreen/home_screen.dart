import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:olx_clone/ProfileScreen/profile_screen.dart';
import 'package:olx_clone/SearchProduct/search_product.dart';
import 'package:olx_clone/UploadAddScreen/upload_add_screen.dart';
import 'package:olx_clone/WelcomeScreen/welcome_screen.dart';
import 'package:olx_clone/Widgets/global_varibale.dart';
import 'package:olx_clone/Widgets/listview_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  getMyData() {
    print("${uid}");
    FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .get()
        .then((results) {
      setState(() {
        userImageUrl = results.data()!['userImage']; // user profile image
        getUserName = results.data()!['userName'];
      });
    });
  }
  // this getMyData is used for the to store information is firebase/ Database and then
  // this function is used in the 'upload_add_screen' dart file.

  //this function is used to get the user address according to the
  // the current location on high accuracy
  getUserAddress() async {
    Position newPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy:
            LocationAccuracy.high); // get the user location on high accuracy

    position = newPosition;
    placemarks =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);
    Placemark placemark = placemarks![0];
    String newCompleteAddress =
        '${placemark.subThoroughfare} ${placemark.thoroughfare},'
        '${placemark.subThoroughfare} ${placemark.locality},'
        '${placemark.subAdministrativeArea} ,'
        '${placemark.administrativeArea} ${placemark.postalCode},'
        '${placemark.country},';
    //this function combines geolocation and reverse geocoding to determine the
    // user's current address based on their GPS coordinates.

    completeAddress = newCompleteAddress;

    print(completeAddress); //To check on the run time about the data

    return completeAddress;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserAddress();
    uid = FirebaseAuth.instance.currentUser!.uid;
    getMyData();

    userEmail = FirebaseAuth.instance.currentUser!.email!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.teal,
      ),
      child: Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                              sellerId: uid,
                            )));
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SearchProduct()));
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()));
                });
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ),
            )
          ],
          backgroundColor: Colors.purple,
          title: const Text(
            'Home Screen',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                decorationThickness: 4.0),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Colors.green,
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('items')
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
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add Post',
          child: const Icon(
            Icons.cloud_upload,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => UploadAddScreen()));
          },
        ),
      ),
    );
  }
}

// leading: GestureDetector(
// onTap: () {
// FirebaseAuth.instance.signOut();
// Navigator.pushReplacement(context,
// MaterialPageRoute(builder: (context) => LoginScreen()));
// },
// child: const Icon(
// Icons.logout,
// ),
// ),
