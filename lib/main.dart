
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internshift/pages/navigationbarmainpages/notificationspage.dart';
import 'package:internshift/pages/navigationbarmainpages/profilepage.dart';
import 'package:internshift/pages/navigationbarmainpages/savedopenings.dart';
import 'package:internshift/pages/navigationbarmainpages/searchpage.dart';
import 'package:internshift/pages/pdfviewerpage.dart';
import 'package:internshift/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'constants.dart';
import 'functions/functions.dart';
import 'pages/topratedinternshipspage.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InternShift',
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String assetPDFPath = "";
  String urlPDFPath = "";

  @override
  void initState() {
    super.initState();

    getFileFromAsset("assets/Akhil_Resume.pdf").then((f) {
      setState(() {
        assetPDFPath = f.path;
        print(assetPDFPath);
      });
    });

    // getFileFromUrl("http://www.pdf995.com/samples/pdf.pdf").then((f) {
    //   setState(() {
    //     urlPDFPath = f.path;
    //     print(urlPDFPath);
    //   });
    // });
  }

  Future<File> getFileFromAsset(String asset) async {
    try {
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/mypdf.pdf");

      File assetFile = await file.writeAsBytes(bytes);
      return assetFile;
    } catch (e) {
      throw Exception("Error opening asset file");
    }
  }

  // Future<File> getFileFromUrl(String url) async {
  //   try {
  //     var data = await http.get(url);
  //     var bytes = data.bodyBytes;
  //     var dir = await getApplicationDocumentsDirectory();
  //     File file = File("${dir.path}/mypdfonline.pdf");

  //     File urlFile = await file.writeAsBytes(bytes);
  //     return urlFile;
  //   } catch (e) {
  //     throw Exception("Error opening url file");
  //   }
  // }
  int _currentIndex = 0;
  final _children = [
    HomePage(),
    Saved(),
    SearchPage(),
    NotificationsPage(),
    ProfilePage()
  ];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  

  

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
          Stack(alignment: Alignment.center, children: [
            Container(
              height: MediaQuery.of(context).size.height * 1 / 3.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: ColorPalette().themeColor),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                height: 175,
                width: 175,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100)),
                child: Center(
                    child: Text("BP",
                        style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: ColorPalette().themeColor))),
              ),
            )
          ]),
          ListTile(
            title: Text('Ben' + " " + 'Peckham'),
            leading: Icon(Icons.person),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text("Age: " + "15"),
          ),
          ListTile(
            title: Text('ben.peckham@outlook.com'),
            leading: Icon(Icons.email),
          ),
          
          ListTile(
            leading: Icon(Icons.school),
            title: Text('School for the Talented and Gifted'),
          ),
          ListTile(
            leading: Icon(Icons.location_pin),
            title: Text('Dallas, TX'),
          ),
          ListTile(
            onTap: () {
              if (urlPDFPath != null) {
                Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PDFViewerPage(path: assetPDFPath)));
            }},
            leading: Icon(Icons.upload_file),
            title: Text("View Your Resume"),
          ),
        ]),
      ),
      drawerEnableOpenDragGesture: true,
      appBar: AppBar(
        actions: [
          Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () => Scaffold.of(context).openEndDrawer(),
                  child: Icon(
                    // Icons.tune,
                    Icons.account_circle,
                    color: ColorPalette().themeColor,
                    size: 30,
                  ),
                ),
              );
            },
          )
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: _children.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: ColorPalette().bottomNavigationBarColor,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.bookmark,
                color: ColorPalette().bottomNavigationBarColor,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Stack(
                children: [
                  Container(
                    height: 52,
                    width: 52,
                    decoration: BoxDecoration(
                        color: Color(0xff759E8B),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 27,
                  )
                ],
                alignment: Alignment.center,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
                color: ColorPalette().bottomNavigationBarColor,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: ColorPalette().bottomNavigationBarColor,
              ),
              label: "")
        ],
      ),
    );
  }
}

class TopRatedInternships extends StatelessWidget {
  final String nameofJob;
  final String employer;
  final String employerLocation;
  TopRatedInternships({this.nameofJob, this.employer, this.employerLocation});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 20),
          width: MediaQuery.of(context).size.width * 1 / 1.2,
          height: 85,
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.only(right: 40.0, bottom: 10),
              child: Image.network(
                  'https://cdn.icon-icons.com/icons2/2119/PNG/512/google_icon_131222.png',
                  height: 45,
                  width: 45),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text(
                  nameofJob,
                  style: TextStyle(
                      color: Color(0xff06745A),
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Icon(
                    Icons.verified,
                    color: Colors.blue,
                    size: 20,
                  ),
                )
              ]),
              Text(
                employer,
                style: TextStyle(color: Colors.grey),
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Color(0xff759E8B),
                  ),
                  Text(employerLocation,
                      style: TextStyle(color: Color(0xff759E8B)))
                ],
                mainAxisAlignment: MainAxisAlignment.start,
              )
            ]),
          ]),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                blurRadius: 5,
                spreadRadius: 0,
                offset: Offset(0, 4),
                color: Colors.grey[300]),
          ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.only(right: 20.0),
      //       child: Icon(
      //         Icons.tune,
      //         color: ColorPalette().themeColor,
      //         size: 30,
      //       ),
      //     )
      //   ],
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  returnGreeting(),
                  style: TextStyle(fontSize: 20, color: Color(0xff759E8B)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 60),
                child: Text('Ben Peckham', style: titleTextStyle()),
              )
            ]),
            Container(
              width: MediaQuery.of(context).size.width * 1 / 1.1,
              child: Center(
                child: Stack(alignment: Alignment.center, children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 1 / 1.1,
                    height: 250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              spreadRadius: 0,
                              offset: Offset(0, 4),
                              color: Colors.grey[400]),
                        ],
                        gradient: LinearGradient(
                            colors: [Color(0xffFAFAFA), Color(0xffFAFAFA)])),
                  ),
                  Column(children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0, left: 15),
                        child: Text(
                          'Top Rated Offers',
                          style: TextStyle(
                              color: Color(0xff858585),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
                    TopRatedInternships(
                      nameofJob: "Software Engineering",
                      employer: "Google",
                      employerLocation: "Austin, TX",
                    ),
                    TopRatedInternships(
                      nameofJob: "Pre-Med Program",
                      employer: "UT Southwestern Medical Center",
                      employerLocation: "Dallas, TX",
                    )
                  ])
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: ViewAllTopRatedOffersButton(),
            ),
            CategoriesHome()
          ],
        ),
      ),
    );
  }
}

class ViewAllTopRatedOffersButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TopRatedOffersPage()));
      },
      child: Stack(alignment: Alignment.center, children: [
        Container(
          width: MediaQuery.of(context).size.width * 1 / 1.1,
          height: 50,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 5,
                    spreadRadius: 0,
                    offset: Offset(0, 4),
                    color: Colors.grey[400]),
              ],
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                  colors: [Color(0xffFAFAFA), Color(0xffFAFAFA)])),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'View All Top Rated Offers',
            style: TextStyle(color: Color(0xff858585)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(Icons.arrow_forward, color: Color(0xff858585)),
          )
        ])
      ]),
    );
  }
}
