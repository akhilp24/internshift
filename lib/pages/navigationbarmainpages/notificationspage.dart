

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Text('Notifications', style: titleTextStyle()),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Center(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                child: ListOfNotifications(),
                width: MediaQuery.of(context).size.width * 1/1.1,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 0,
                  offset: Offset(0, 4),
                  color: Colors.grey[300]),]
                ),
              ),

              // Container(
              //   width: MediaQuery.of(context).size.width * 1/1.1,
              //   height: MediaQuery.of(context).size.height,
                
              //   decoration: BoxDecoration(
              //     color: Colors.red,
                  
              //   ),
              // )
            ]
          ),
        ),
      )
          ],
        ),
    );
  }
}

class ListOfNotifications extends StatefulWidget {
  @override
  _ListOfNotificationsState createState() => _ListOfNotificationsState();
}

class _ListOfNotificationsState extends State<ListOfNotifications> {
  @override
  Widget build(BuildContext context) {
    
         return StreamBuilder(
           stream: Firestore.instance.collection('users').document('akhilpeddikuppa').collection('notifications').snapshots(),
           builder: (context, snapshot) {
             
             if (!snapshot.hasData) {
               return Center(child: CircularProgressIndicator());
             } else {
               return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, i) {
                      DocumentSnapshot asnapshot = snapshot.data.documents[i];
                      return Dismissible(
                        key: Key(""),
                        onDismissed: (direction) async {
                          await Firestore.instance.runTransaction((Transaction myTransaction) async {
    await myTransaction.delete(snapshot.data.documents[i].reference);
});
                          Scaffold
        .of(context)
        .showSnackBar(SnackBar(content: Text("Dismissed")));
                        },
                                              child: ListTile(
                        title: Text(asnapshot.data['title'], style: TextStyle(fontWeight: FontWeight.bold),),
                        leading: Icon(Icons.mail),
                        subtitle: Text(asnapshot.data['subtitle']),
                        // trailing: Icon(Icons.close),
                          ),
                      );
                    },
                  );
             }
           }
         );       
}

}


