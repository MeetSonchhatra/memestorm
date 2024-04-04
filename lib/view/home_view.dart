import 'package:cached_network/cached_network.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memestorm/services/apis.dart';
import 'package:memestorm/view/newpage.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg_image.png'),
          fit: BoxFit.cover,
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Center(
            child: Text('Meme Storrm',
            style: GoogleFonts.lato(
              textStyle : TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 27,
              ),
            ),
            
            
            ),
          ),
        ),
        body: FutureBuilder(future: API.getMemes(),
         builder:(context,snapshot){
          if (snapshot.hasData)
          {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 10,mainAxisSpacing: 10),
                
            itemCount: snapshot.data!.data!.memes!.length,
            itemBuilder: (context,index) {
              final meme = snapshot.data!.data!.memes![index];
              return InkWell(
                onTap:(){
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)=>Pagexyz(url: meme.url!,text: meme.name!),));
                },
                child: Card(
                  color: Color.fromRGBO(232,242,253,1),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      SizedBox(
                        height: 120,
                        width: 120,
                        child: CachedNetworkImage(
                                        imageUrl: meme.url!,
                                        fit: BoxFit.cover,
                                        placeholder: (context,url) =>
                                        SizedBox.square(dimension: 20 , child:  const CircularProgressIndicator()),
                                        errorWidget: (context,url,error) =>
                                        const Icon(Icons.error),
                                      ),
                      ),
                      SizedBox(height: 14,),
                  Text(
                    meme.name!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: GoogleFonts.openSans(
                      textStyle : TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400
                      )
                    ),
                    )
                    ],
                  ),
                ),
              );
            });
          }
          else {
            return Center(
              child: SizedBox.square(dimension: 20 , child: CircularProgressIndicator.adaptive()),
            );
          }
            
         }
         
         ),
      ),
    );
  }
}