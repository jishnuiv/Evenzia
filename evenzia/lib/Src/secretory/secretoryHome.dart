import 'package:flutter/material.dart';
import '../../Authentication/selectRoll.dart';
import '../../constant/drawerTile.dart';
import '../../constant/homeTile.dart';
import '../../constant/myColor.dart';
import '../advisor/addNotification.dart';
import '../advisor/eventListForResultupload.dart';
import '../advisor/viewEvents.dart';
import '../advisor/viewNotification.dart';
import 'createCertificate.dart';
class SecretoryHome extends StatefulWidget {
  const SecretoryHome({Key? key}) : super(key: key);

  @override
  State<SecretoryHome> createState() => _SecretoryHomeState();
}

class _SecretoryHomeState extends State<SecretoryHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Secretory'),
          flexibleSpace: Container(
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors:tileColors),
            ),)
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(height: 30,),
            // Tiles(text: 'Profile', icon:Icons.person, onPressed: (){
            //   Navigator.push(context, MaterialPageRoute(builder: (context) =>  Profile (Url: 'student/get-profile')));
            //
            // }),
            Tiles(text: 'View Notification', icon:Icons.notifications_active_outlined, onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  ViewNotification(uri:'secretary/notifications',)));
            }),
            Tiles(text: 'View Events', icon:Icons.notifications_active_outlined, onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  viewEvents(eventUrl: 'secretary/events',)));
            }),
            Tiles(text: 'LogOut', icon:Icons.help_outline, onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SelectRoll( )));

            }),

          ],
        ),
      ),
      body: Center(
          child: GridView.extent(
            primary: false,
            padding: const EdgeInsets.all(16),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            maxCrossAxisExtent: 200.0,
            children: <Widget>[

              MyTile(title: 'Add Notifications', onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddAdvisorNotification (Uri: 'secretary/notifications',)));


              },
                imageUrl: 'https://img.icons8.com/arcade/2x/alarm.png',
              ),
              // MyTile(title: 'Events', onPressed: () {
              //    Navigator.push(context, MaterialPageRoute(builder: (context) =>   viewEvents(eventUrl: 'secretary/events',)));
              //
              // },
              //   imageUrl: 'https://cdn-icons-png.flaticon.com/128/2940/2940648.png',
              // ),
              MyTile(title: 'Results', onPressed: () {

                 Navigator.push(context, MaterialPageRoute(builder: (context) =>   EventListViews(EventList: 'secretary/events', roll: '2',)));


              },
                imageUrl: 'https://cdn-icons-png.flaticon.com/128/9470/9470064.png',
              ),
              MyTile(title: 'Certificates',      onPressed: () {

                 Navigator.push(context, MaterialPageRoute(builder: (context) =>
                     filePic(
                       viewEventUrl: 'secretary/events',
                       viewListUrl: 'secretary/participated-students',
                       submitFileUrl:'secretary/add-certificate',)));


              },
                imageUrl: 'https://cdn-icons-png.flaticon.com/128/3000/3000763.png',
              ),
              MyTile(title: 'Add Events', onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) =>   viewEvents(eventUrl: 'advisor/events',)));

              },
                imageUrl: 'https://tse3.mm.bing.net/th?id=OIP.wh-rFaBP2zkK71UhXxLvkQHaHa&pid=Api&P=0',
              ),
              // MyTile(title: 'My Bookings',      onPressed: () {
              //
              //   // Navigator.push(context, MaterialPageRoute(builder: (context) => const    UserPaymentView()));
              //
              //
              // },)
            ],
          )),);
  }
}
