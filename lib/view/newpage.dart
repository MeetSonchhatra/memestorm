import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:memestorm/services/apis.dart';

class Page extends StatefulWidget {
  
  const Page({super.key, required this.url, required this.text});
  final String url;
  final String text;

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(future: API.getMemes(),
       builder:(context,snapshot){
        if (snapshot.hasData)
        {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 10,mainAxisSpacing: 10),
              
          itemCount: snapshot.data!.data!.memes!.length,
          itemBuilder: (context,index) {
            final meme = snapshot.data!.data!.memes![index];
            return Card(
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
                )
                ],
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

    );
  }
}