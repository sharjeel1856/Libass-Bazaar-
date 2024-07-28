import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:olx_clone/HomeScreen/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageSliderScreen extends StatefulWidget {
  final String title, urlImage1, urlImage2, urlImage3, urlImage4, urlImage5;
  final String itemColor, userNumber, description, address, itemPrice;
  final double lat, lng;

  ImageSliderScreen({
    required this.title,
    required this.urlImage1,
    required this.urlImage2,
    required this.urlImage3,
    required this.urlImage4,
    required this.urlImage5,
    required this.itemColor,
    required this.userNumber,
    required this.description,
    required this.address,
    required this.itemPrice,
    required this.lng,
    required this.lat,
  });

  @override
  State<ImageSliderScreen> createState() => _ImageSliderScreenState();
}

class _ImageSliderScreenState extends State<ImageSliderScreen>
    with SingleTickerProviderStateMixin {
  static List<String> links =
      []; // this variable is created because of the getting the
  //images and show on the images slider screen of the user add
  TabController? tabController;

  getLinks() {
    links.add(widget.urlImage1);
    links.add(widget.urlImage2);
    links.add(widget.urlImage3);
    links.add(widget.urlImage4);
    links.add(widget.urlImage5);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLinks();
    tabController = TabController(
        length: 5, vsync: this); // call the images links in this init state
  }

  String? url; // for checking the user location

  @override
  Widget build(BuildContext context) {
    Size size =
        MediaQuery.of(context).size; // to manage the screen size of the app

    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Image Slider Screen ',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.0, right: 12.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.location_pin,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  Expanded(
                    child: Text(
                      widget.address,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: size.height * 0.5,
              width: size.width,
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Carousel(
                  indicatorBarColor: Colors.black.withOpacity(0.2),
                  autoScrollDuration: Duration(seconds: 2),
                  animationPageDuration: Duration(microseconds: 500),
                  activateIndicatorColor: Colors.black,
                  animationPageCurve: Curves.easeIn,
                  indicatorBarHeight: 30,
                  indicatorHeight: 10,
                  indicatorWidth: 10,
                  unActivatedIndicatorColor: Colors.grey,
                  stopAtEnd: false,
                  autoScroll: true,
                  items: [
                    Image.network(
                      widget.urlImage1,
                    ),
                    Image.network(
                      widget.urlImage2,
                    ),
                    Image.network(
                      widget.urlImage3,
                    ),
                    Image.network(
                      widget.urlImage4,
                    ),
                    Image.network(
                      widget.urlImage5,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: Center(
                child: Text('\$ ${widget.itemPrice}',
                    style: const TextStyle(
                      fontSize: 24,
                      letterSpacing: 2.0,
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.brush_outlined),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(widget.itemColor),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.phone_android),
                      Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Text(widget.userNumber),
                          ))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Text(
                widget.description,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints.tightFor(
                  width: 260,
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    double latitude = widget.lat;
                    double longitude = widget.lng;
                    url =
                        'https://www.google.com/maps/search/?api=1&query=$latitude, $longitude';
                    if (await canLaunchUrl(Uri.parse(url!))) {
                      // Google maps api
                      await launchUrl(Uri.parse(url!));
                    } else {
                      throw 'Could not open the map';
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.black54,
                    ),
                  ),
                  child: const Text(
                    'Check Seller Location',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
