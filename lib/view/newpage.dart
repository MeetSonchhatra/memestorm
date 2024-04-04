import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:http/http.dart' as http;

enum ButtonState {init , loading ,done}

class Pagexyz extends StatefulWidget {
  
  
  const Pagexyz({super.key, required this.url, required this.text});
  final String url;
  final String text;
  

  @override
  State<Pagexyz> createState() => _PagexyzState();
}

class _PagexyzState extends State<Pagexyz> {
  bool isAnimating =true;
  ButtonState state = ButtonState.init;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDone = state == ButtonState.done;
    final isStreched = isAnimating || state == ButtonState.init;
    

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/Nextpg_bg.png'),
          fit: BoxFit.cover,
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Meme Storrm',
          style: GoogleFonts.lato(
              textStyle : TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 27,
              ),
            ),
          
          ),
        ),
      
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 250,),
              Center(
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: CachedNetworkImage(
                    imageUrl: widget.url,
                    fit: BoxFit.cover,
                    placeholder: (context,url) =>
                    const CircularProgressIndicator(),
                    errorWidget: (context,url,error) =>
                    const Icon(Icons.error),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Text(
                  widget.text,
                  style: GoogleFonts.openSans(
                      textStyle : TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400
                      )
                    ),
                ),
                SizedBox(height: 30,),
                Container(
                  padding: EdgeInsets.fromLTRB(40, 0, 40,0),
                  child: AnimatedContainer(
                  duration: Duration(microseconds: 300),
                  curve: Curves.easeInCirc,
                  width: state == ButtonState.init ? width : 70,
                  onEnd: () => setState(() => isAnimating  = !isAnimating),
                  height: 50,                
                  child : isStreched ? buildbutton() : buildsmallbutton(isDone),
                  ),
                ),
      
            ],
          ),
        )
      
      ),
    );
  }

  Widget buildbutton()  => 
   ElevatedButton( 
    style:  ElevatedButton.styleFrom(
      shape: StadiumBorder(),
      side: BorderSide(width: 2,color: Colors.indigo)
    ),   
              child:  FittedBox(child: Text('Download',
              style: GoogleFonts.openSans(
                      textStyle : TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400
                      )
                    ),
              )),
              onPressed: () async{
                downloadAndSaveImage(widget.url);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Container(
                      padding: EdgeInsets.fromLTRB(40,0,40,0),
                      height: 70,
                      decoration: BoxDecoration(
                        //color: Color.fromRGBO(12, 242, 12, 1),
                        color: Color.fromRGBO(29, 40,150, 1),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            'Meme Downloaded',
                            style: GoogleFonts.openSans(
                            textStyle : TextStyle(
                            fontSize: 18,color: Colors.white,
                              fontWeight: FontWeight.w400
                            )
                         ),    
                          ),
                          SizedBox(height: 8,),
                          Text(
                            'The Image is saved in gallery',
                            style: GoogleFonts.openSans(
                            textStyle : TextStyle(
                            fontSize: 16,color: Colors.white,
                              fontWeight: FontWeight.w400
                            )
                         ),
                          ),
                        ],
                      )),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ));
                setState(() => state = ButtonState.loading);
                await Future.delayed(Duration(seconds: 2));

                setState(() => state = ButtonState.done);
                await Future.delayed(Duration(seconds: 2));

                setState(() => state = ButtonState.init);
                await Future.delayed(Duration(seconds: 2));


              },
            );
  

  Future<void> downloadAndSaveImage(String imageUrl) async {
  final response = await http.get(Uri.parse(imageUrl));
  final bytes = response.bodyBytes;
  final result = await ImageGallerySaver.saveImage(bytes);

  // Show notification
  if (result != null && result['isSuccess']) {
    //showNotification("Image Downloaded", "Tap to open");
  }
}

  Widget buildsmallbutton(bool isDone) {
    final color = isDone ?  Color.fromRGBO(29, 40,150, 1) : Colors.white;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: isDone 
      ? Icon(Icons.done,size: 52,color: Colors.white,)
      : CircularProgressIndicator(color: Color.fromRGBO(29, 40,150, 1),),
    );  
  }

// void showNotification(String title, String body) async {
//   var android = AndroidNotificationDetails(
//       'channel id', 'channel NAME',
//       priority: Priority.high, importance: Importance.max);
//   var platform = NotificationDetails(android: android);
//   await FlutterLocalNotificationsPlugin().show(
//     0, // Notification ID
//     title, // Notification Title
//     body, // Notification Body
//     platform,
//     payload: 'Notification Payload',
//   );
// }


}
