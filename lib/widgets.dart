import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';


class NewListings extends StatefulWidget {
  @override
  _NewListingsState createState() => _NewListingsState();
}

class _NewListingsState extends State<NewListings> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Stack(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 1 / 1.1,
              // height: 550,
              decoration: BoxDecoration(
                color: Color(0xffFAFAFA),
                borderRadius: BorderRadius.circular(15),
                // boxShadow: [
                //   BoxShadow(
                //       blurRadius: 3,
                //       spreadRadius: 0,
                //       offset: Offset(0, 4),
                //       color: Colors.grey[200]),
                // ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20),
                child: Text(
                  'New Offers',
                  style: TextStyle(
                      color: Color(0xff858585), fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              StreamBuilder(
                  stream: Firestore.instance.collection('offers').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      int itemCount = snapshot.data.documents.length;
                      return Padding(
                        padding: const EdgeInsets.all(22.0),
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: itemCount,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot bsnapshot =
                                snapshot.data.documents[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Container(
                                  child: Center(
                                      child:
                                          Text(bsnapshot.data["nameofoffer"])),
                                  width: 100),
                              elevation: 1,
                            );
                          },
                        ),
                      );
                    }
                  })
            ]),
          )
        ],
      ),
    );
  }
}

void appAddModalBottomSheet(context, String nameofJob, String employer,
    String employerLocation, String logo) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * 1 / 1.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
          ),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 10),
              child: Align(
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      size: 25,
                    )),
                alignment: Alignment.topRight,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Stack(alignment: Alignment.center, children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0xffedf5f3)),
                ),
                Image.network(
                  logo,
                  height: 80,
                  width: 80,
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                nameofJob,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                employer,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(
                  Icons.location_pin,
                  size: 18,
                ),
                SizedBox(width: 5),
                Text(
                  employerLocation,
                  style: TextStyle(fontWeight: FontWeight.w300),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width * 1 / 1.7,
                  decoration: BoxDecoration(
                      // color: Colors.black
                      ),
                  child: Column(children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Information",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "The text of the description",
                        ))
                  ])),
            ),
            ApplyandSavedButtons(
              nameOfJob: nameofJob,
              employer: employer,
              employerLocation: employerLocation,
              logo: logo,
            )
          ]),
        );
      });
}

class ApplyandSavedButtons extends StatefulWidget {
  final String nameOfJob;
  final String employer;
  final String employerLocation;
  final String logo;
  ApplyandSavedButtons(
      {this.nameOfJob, this.employer, this.employerLocation, this.logo});
  @override
  _ApplyandSavedButtonsState createState() => _ApplyandSavedButtonsState();
}

class _ApplyandSavedButtonsState extends State<ApplyandSavedButtons> {
  @override
  Widget build(BuildContext context) {
    bool isSaved = false;
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                  height: 50,
                  width: 230,
                  decoration: BoxDecoration(
                      color: Color(0xff5FBA94),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Apply Here",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          StreamBuilder(
            stream: Firestore.instance
                .collection('users')
                .document('akhilpeddikuppa')
                .collection('savedopenings')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else {
                return GestureDetector(
                  onTap: () async {
                    setState(() {
                      isSaved = !isSaved;
                    });
                    if (isSaved = false) {
                      await Firestore.instance
                          .runTransaction((Transaction myTransaction) async {
                        await myTransaction
                            .delete(snapshot.data.documents[0].reference);
                      });
                    } else {
                      await snapshot.data.documents().add({
                        'nameOfJob': widget.nameOfJob,
                        'employer': widget.employer,
                        'logo': widget.logo,
                        'location': widget.employerLocation
                      });
                    }
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.amber, width: 2),
                            borderRadius: BorderRadius.circular(95)),
                        child: StreamBuilder(
                            stream: Firestore.instance
                                .collection('users')
                                .document('akhilpeddikuppa')
                                .collection('savedopenings')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else {
                                String testingIfTrueName =
                                    snapshot.data.documents[0]['nameOfJob'];
                                String testingIfTrueEmployer =
                                    snapshot.data.documents[0]['employer'];
                                if ((testingIfTrueName == widget.nameOfJob) &&
                                    (testingIfTrueEmployer ==
                                        widget.employer)) {
                                  return Icon(Icons.bookmark,
                                      color: Colors.amber, size: 30);
                                } else {
                                  return Icon(Icons.bookmark_outline,
                                      color: Colors.amber, size: 30);
                                }
                              }
                            })),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
