import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:internshift/constants.dart';
import 'package:internshift/widgets.dart';

class Saved extends StatefulWidget {
  @override
  _SavedState createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  List saved = [
    1, 2, 3
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
      Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Text('Saved', style: titleTextStyle()),
      ),
      
                    Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 15, right: 15),
          child: Center(
            child: Container(
              child: ListofSavedOpenings(),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * 1/1.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 0,
                  offset: Offset(0, 4),
                  color: Colors.grey[300]),]
                ),
              ),
          ),
        ),
      
       
      
          ],
        ),
    );
  }
}

class ListofSavedOpenings extends StatefulWidget {
  @override
  _ListofSavedOpeningsState createState() => _ListofSavedOpeningsState();
}

class _ListofSavedOpeningsState extends State<ListofSavedOpenings> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('users').document('akhilpeddikuppa').collection('savedopenings').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(  
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, i) {
                    DocumentSnapshot bsnapshot = snapshot.data.documents[i];
                    bool iconIsPressed = true;
  Icon returnIcon() {
    if (iconIsPressed == true) {
      return Icon(Icons.bookmark, color: Colors.amber, size: 32,);
    } else {
      return Icon(Icons.bookmark_border_outlined, color: Colors.amber, size: 32);
    }
  }
                      return Padding(
                        
      padding: const EdgeInsets.only(top: 20),
      child: GestureDetector(
        onTap: () {
          appAddModalBottomSheet(context, bsnapshot.data['nameOfJob'], bsnapshot.data['employer'], bsnapshot.data['location'], bsnapshot.data['logo']);
        },
              child: Container(
          width: MediaQuery.of(context).size.width * 1/1.2,
          height: 125,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
                BoxShadow(
                    blurRadius: 5,
                    spreadRadius: 0,
                    offset: Offset(0, 4),
                    color: Colors.grey[200]),]
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 35),
                child: Image.network(bsnapshot.data['logo'], height: 42, width: 42),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 34.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  
                  children: [
                    Text(bsnapshot.data['nameOfJob'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                Container(
                  width: 200,
                  //200,
                  child: Text(bsnapshot.data['employer'], softWrap: true,)),
                Text(bsnapshot.data['location'])
                  ]
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                  child: Padding(
                  padding: const EdgeInsets.only(right: 0.0),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          iconIsPressed = !iconIsPressed;  
                        });
                        await Firestore.instance.runTransaction((Transaction myTransaction) async {
    await myTransaction.delete(snapshot.data.documents[i].reference);
});
                          Scaffold
        .of(context)
        .showSnackBar(SnackBar(content: Text("Removed from saved")));
                      },
                      child: returnIcon()
                      ),
                  )
                    ),
                ),
              
            ]
          ),
        ),
      ),
    );
                    },
                );
        }
      },
    );
  }
}