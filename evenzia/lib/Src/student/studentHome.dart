import 'package:evenzia/Src/student/practiceRequest.dart';
import 'package:evenzia/Src/student/practicelist.dart';
import 'package:evenzia/Src/student/viewResult.dart';
import 'package:evenzia/Src/student/viewfeedback.dart';
import 'package:evenzia/constant/drawerTile.dart';
import 'package:evenzia/constant/myColor.dart';
import 'package:evenzia/profile/profile.dart';
import 'package:flutter/material.dart';
import '../../Authentication/selectRoll.dart';
import '../../constant/homeTile.dart';
import '../Media/mediaView.dart';
import '../advisor/viewNotification.dart';
import 'certificate.dart';
import 'eventList.dart';
import 'feedback.dart';
class StudentHome extends StatefulWidget {
  const StudentHome({Key? key}) : super(key: key);

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Home'),
          centerTitle: true,
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
            Tiles(text: 'Profile', icon:Icons.person, onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) =>  Profile (Url: 'student/get-profile')));
            }),
            Tiles(text: 'Feedback', icon:Icons.help_outline, onPressed: (){
              Navigator.pop(context);
               Navigator.push(context, MaterialPageRoute(builder: (context) => feedback( )));
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

            MyTile(title: 'Notifications', onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) =>  ViewNotification (uri: 'student/notifications',)));


            },
               imageUrl: 'https://img.icons8.com/arcade/2x/alarm.png',
            ),
            MyTile(title: 'Events', onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  EVentList (uri:'student/events',)));

            },
               imageUrl: 'https://cdn-icons-png.flaticon.com/128/2940/2940648.png',
            ),

            MyTile(title: 'Request For Practice',      onPressed: () {

              Navigator.push(context, MaterialPageRoute(builder: (context) =>const PracticeList()));

            },
              imageUrl: 'https://e7.pngegg.com/pngimages/285/615/png-clipart-contemporary-dance-art-music-folk-dance-others-miscellaneous-text.png',
            ),
            MyTile(title: 'Results', onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const  viewResult()));


            },
               imageUrl: 'https://cdn-icons-png.flaticon.com/128/9470/9470064.png',
            ),
            MyTile(title: 'Certificates',      onPressed: () {

              Navigator.push(context, MaterialPageRoute(builder: (context) => const    StudentCertificate()));


            },
               imageUrl: 'https://cdn-icons-png.flaticon.com/128/3000/3000763.png',
            ),
            MyTile(title: 'View Media',      onPressed: () {

              Navigator.push(context, MaterialPageRoute(builder: (context) =>     imagefile(imgUrl: 'student/media/list',)));


            },
               imageUrl: 'https://cdn-icons-png.flaticon.com/128/6212/6212173.png',
            ),



            MyTile(title: 'View Feedback',      onPressed: () {

              Navigator.push(context, MaterialPageRoute(builder: (context) => viewFeedback (uri: 'student/feedbacks',)));

            },
               imageUrl: 'https://tse2.mm.bing.net/th?id=OIP.cptvfDW20mmpA5sqqSuioQHaGq&pid=Api&P=0',
            ),

          ],
        )),);
  }
}
