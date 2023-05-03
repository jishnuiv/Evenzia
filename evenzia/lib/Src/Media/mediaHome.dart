import 'package:flutter/material.dart';

import '../../Authentication/login.dart';
import '../../Authentication/selectRoll.dart';
import '../../constant/drawerTile.dart';
import '../../constant/homeTile.dart';
import '../../constant/myColor.dart';
import '../../imagePic.dart';
import '../../imagetest.dart';
import 'mediaView.dart';
class MediaHome extends StatefulWidget {
  const MediaHome({Key? key}) : super(key: key);

  @override
  State<MediaHome> createState() => _MediaHomeState();
}

class _MediaHomeState extends State<MediaHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Media'),
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

            SizedBox(height: 50,),
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

              MyTile(title: 'Create Media', onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ImagePic()));
                 // Navigator.push(context, MaterialPageRoute(builder: (context) => const ImagePic()));
              },
                imageUrl: 'https://img.icons8.com/arcade/2x/alarm.png',
              ),
              MyTile(title: 'View Media', onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  imagefile(imgUrl: 'media/list',)));
                 // Navigator.push(context, MaterialPageRoute(builder: (context) => const ImagePic()));
              },
                imageUrl: 'https://cdn-icons-png.flaticon.com/128/6212/6212173.png',
              ),
              // MyTile(title: 'Events', onPressed: () {
              //   // Navigator.push(context, MaterialPageRoute(builder: (context) => const  UserAnnouncement()));
              //
              // },
              //   imageUrl: 'https://cdn-icons-png.flaticon.com/128/2940/2940648.png',
              // ),
              // MyTile(title: 'Results', onPressed: () {
              //
              //   // Navigator.push(context, MaterialPageRoute(builder: (context) => const  UserAnnaDanam()));
              //
              //
              // },
              //   imageUrl: 'https://cdn-icons-png.flaticon.com/128/9470/9470064.png',
              // ),
              // MyTile(title: 'Certificates',      onPressed: () {
              //
              //   // Navigator.push(context, MaterialPageRoute(builder: (context) => const    UserNotifications()));
              //
              //
              // },
              //   imageUrl: 'https://cdn-icons-png.flaticon.com/128/3000/3000763.png',
              // ),
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
