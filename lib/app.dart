import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';

class ImageModel{
  int id;
  String url;
  String title;

  ImageModel(this.id,this.url,this.title);

  ImageModel.fromJson(Map<String, dynamic> parsedJson){
    id = parsedJson['id'];
    url = parsedJson['url'];
    title = parsedJson['title'];
  }

  String getUrl(){
    return url;
  }
}

class PictureApp extends StatefulWidget{
  createState(){
    return PictureAppState();
  }
}

class PictureAppState extends State<PictureApp>{
  List<ImageModel> imageList = [];
  int counter = 0;

  void fetchImage() async {
    counter++;
    var response = await get('https://jsonplaceholder.typicode.com/photos/$counter');
    var imageModel = ImageModel.fromJson(json.decode(response.body));
    imageList.add(imageModel);
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(
          title: Text("Let us see Images.. $counter times!"),
          backgroundColor: Colors.redAccent,
          ),
        
        body: ListView.builder(
          itemCount: imageList.length, 
          itemBuilder: (context,index){
              return Padding(padding: EdgeInsets.all(40),child: Image.network(imageList[index].getUrl())
              );
          },
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          child: Icon(Icons.add),
          onPressed: (){
            setState(() {
            fetchImage();
            });
          },
         ),
       )
    );
  }
}