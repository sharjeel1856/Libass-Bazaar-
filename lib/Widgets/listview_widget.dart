import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:olx_clone/ImageSliderScreen/image_slider_screen.dart';
import 'package:olx_clone/Widgets/global_varibale.dart';

class ListViewWidget extends StatefulWidget {
  String docId,
      itemColor,
      img1,
      img2,
      img3,
      img4,
      img5,
      userImg,
      name,
      userId,
      itemModel,
      postId;
  String itemPrice, description, address, userNumber;
  DateTime date;
  double lat, lng;

  ListViewWidget({
    required this.docId,
    required this.itemColor,
    required this.img1,
    required this.img2,
    required this.img3,
    required this.img4,
    required this.img5,
    required this.userImg,
    required this.name,
    required this.date,
    required this.userId,
    required this.itemModel,
    required this.postId,
    required this.itemPrice,
    required this.description,
    required this.lat,
    required this.lng,
    required this.address,
    required this.userNumber,
  });

  @override
  State<ListViewWidget> createState() => _ListViewState();
}

class _ListViewState extends State<ListViewWidget> {
  Future<Future> showDialogForUpdateData(selectedDoc, oldUserName, oldItemName,
      oldPhoneNumber, oldItemPrice, oldItemColor, oldItemDescription) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: AlertDialog(
              title: const Text(
                'Update Data',
                style: TextStyle(
                  fontSize: 24,
                  letterSpacing: 2.0,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    initialValue: oldUserName,
                    decoration: const InputDecoration(
                      hintText: 'Enter Your Name',
                    ),
                    onChanged: (value) {
                      setState(() {
                        oldUserName = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    initialValue: oldPhoneNumber,
                    decoration: const InputDecoration(
                      hintText: 'Enter Your Phone Number',
                    ),
                    onChanged: (value) {
                      setState(() {
                        oldUserName = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    initialValue: oldItemPrice,
                    decoration: const InputDecoration(
                      hintText: 'Enter Your Item Price',
                    ),
                    onChanged: (value) {
                      setState(() {
                        oldItemPrice = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    initialValue: oldItemName,
                    decoration: const InputDecoration(
                      hintText: 'Enter Your Item Name',
                    ),
                    onChanged: (value) {
                      setState(() {
                        oldItemName = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    initialValue: oldItemColor,
                    decoration: const InputDecoration(
                      hintText: 'Enter Your Item Color',
                    ),
                    onChanged: (value) {
                      setState(() {
                        oldItemColor = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    initialValue: oldItemDescription,
                    decoration: const InputDecoration(
                      hintText: 'Write Item Description',
                    ),
                    onChanged: (value) {
                      setState(() {
                        oldItemDescription = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    UpdateProfileNameOnExistingPost(oldUserName);
                    _updateUserName(oldUserName, oldPhoneNumber);

                    FirebaseFirestore.instance
                        .collection('items')
                        .doc(selectedDoc)
                        .update({
                      'userName': oldUserName,
                      'userNumber': oldPhoneNumber,
                      'itemPrice': oldItemPrice,
                      'itemModel': oldItemName,
                      'itemColor': oldItemColor,
                      'description': oldItemDescription,
                    }).catchError((onError) {
                      print(onError);
                    });

                    Fluttertoast.showToast(
                      msg: 'The task has been uploaded ',
                      toastLength: Toast.LENGTH_LONG,
                      backgroundColor: Colors.teal,
                      fontSize: 18.0,
                    );
                  },
                  child: const Text('Update Now'),
                ),
              ],
            ),
          );
        });
  }

  //Updating the profile name of a user based on the user post

  UpdateProfileNameOnExistingPost(oldUserName) async {
    await FirebaseFirestore.instance
        .collection('items')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) {
      for (int index = 0; index < snapshot.docs.length; index++) {
        String userProfileNameInPost = snapshot.docs[index]['userName'];
        if (userProfileNameInPost != oldUserName) {
          FirebaseFirestore.instance
              .collection('items')
              .doc(snapshot.docs[index].id)
              .update({
            'userName': oldUserName,
          });
        }
      }
    });
  }

  Future _updateUserName(oldUserName, oldPhoneNumber) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'userName': oldUserName,
      'userNumber': oldPhoneNumber,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        elevation: 16.0,
        shadowColor: Colors.white10,
        child: Container(
          color: Colors.green,
          padding: EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onDoubleTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImageSliderScreen(
                                title: widget.itemModel,
                                itemColor: widget.itemColor,
                                userNumber: widget.userNumber,
                                description: widget.description,
                                lat: widget.lng,
                                lng: widget.lng,
                                address: widget.address,
                                itemPrice: widget.itemPrice,
                                urlImage1: widget.img1,
                                urlImage2: widget.img2,
                                urlImage3: widget.img3,
                                urlImage4: widget.img4,
                                urlImage5: widget.img5,
                              )));
                },
                child: Image.network(
                  widget.img1,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        widget.userImg,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            widget.itemModel,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            DateFormat('dd MMM, yyyy - hh:mm a')
                                .format(widget.date)
                                .toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //if user id is not equal to the specifics user id this code will work
                    widget.userId != uid
                        ? const Padding(
                            padding: EdgeInsets.only(right: 50.0),
                            child: Column(),
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  showDialogForUpdateData(
                                    widget.docId,
                                    widget.name,
                                    widget.userNumber,
                                    widget.itemPrice,
                                    widget.itemModel,
                                    widget.itemColor,
                                    widget.description,
                                  );
                                },
                                icon: const Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: Icon(
                                    Icons.edit_note,
                                    color: Colors.white,
                                    size: 27,
                                  ),
                                ),
                              ),
                              //Deleting specific post from the user
                              IconButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('item')
                                      .doc(widget.postId)
                                      .delete();

                                  Fluttertoast.showToast(
                                    msg: 'Post Has Been Deleted',
                                    toastLength: Toast.LENGTH_LONG,
                                    backgroundColor: Colors.grey,
                                    fontSize: 18.0,
                                  );
                                },
                                icon: const Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: Icon(
                                    Icons.delete_forever,
                                    size: 22,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
