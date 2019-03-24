import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'Flutter Demo',
      home: _MyHomePageState(),
      theme: new ThemeData(
        scaffoldBackgroundColor: Color(0xFF252c49)
      ),
    );
  }
}

class _MyHomePageState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
    ));
    return new Scaffold(
      resizeToAvoidBottomInset: true,
      body: new Stack(
        children: <Widget>[
           AppBarBelowGraphic(title:"Message"),
           AppBar(
            title: Padding(
              padding: EdgeInsets.only(top: 30),
              child:Center(
                    child: Text('Message', style: TextStyle(fontFamily: 'RobotoCondensed', fontSize: 18)),
                  ),
              ),  
            backgroundColor: Colors.transparent,
          ),
          CustomSearchBox(),
          CustomListView(),
        ],
      ),
    );
  }
}


class AppBarBelowGraphic extends StatelessWidget {

  final String title;
  AppBarBelowGraphic({this.title});
  @override
  Widget build(BuildContext context) {
        return Positioned(
            top: -45.0,
            left: 0.0,
            right: 0.0,
            child:Transform.rotate(
            angle: pi/12,
              child:Container(
                alignment: Alignment.bottomCenter,
                child: ClipRect(
                  clipBehavior: Clip.antiAlias,
                  child: Transform.rotate(
                  angle: -pi/14,
                  child: Opacity(
                  opacity: 0.05,
                  child: Text(title, style:TextStyle(fontSize: 55, fontWeight: FontWeight.bold)),
                  ),
                ),
                ),  
                height: 205,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: new LinearGradient(
                    colors: [Color(0xFFdb73f5), Color(0xFFa86ffd)],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.8, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp
                  )
                ),
              ),
            )  ,
        ); 
  }

}

class CustomListView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _CustomListView();
  }
}

class _CustomListView extends State<CustomListView> {

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/1.2,
      top:220,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: CustomListRow(index),
            onTap: () => {onTapped(index)},
          ); 
        },
        ),
        ),
    );
  }

  void onTapped (index) {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen()));
  }

}


class ChatScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack (
      children: <Widget>[
        AppBarBelowGraphic(title:"Chat"),
        AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.only(top:30),
            child:Center(
                    child: Text('Chat', style: TextStyle(fontFamily: 'RobotoCondensed', fontSize: 18)),
                  ),
              ),
          actions: <Widget>[
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(top:30, right:5),
                child: Icon(FontAwesomeIcons.alignRight, size: 19,),
              ) 
            )
          ],  
          backgroundColor: Colors.transparent,
          ),
          ChatView(),
      ],
    ));
  }
}

class ChatView extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ChatListView(),
          ChatTextInput()
        ],
      );
  }
}


class ChatTextInput extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
            height: 57,
            width: MediaQuery.of(context).size.width/1.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Color(0xFF252c49),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 3))]
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 25, top:5),
              child: TextField(
                cursorColor: Color(0xFFFFFFFF),
                decoration:InputDecoration(
                  hintText: 'Type a message',
                  hintStyle: TextStyle(color: Color(0xFF6873a0)),
                  suffixIcon: Icon(Icons.send, color:Color(0xFFea79ff)),
                  border: InputBorder.none
                ),
              ),
            )
            ,
        );
  }

}


class ChatListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
      return _ChatListView();
  }
}

class _ChatListView extends State<ChatListView> {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/1.5,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
        itemBuilder: (BuildContext context, int index){
          return MessageTemplate();
        },
        ) ,
    ),
    )
    ;
  }

}

class MessageTemplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Hello');
  }

}


class CustomListRow extends StatelessWidget {

  final int index = 0;
  CustomListRow(index) {
    index = index;
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: 50,
          height: 50,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: new NetworkImage('https://via.placeholder.com/150/92c952')
            )
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left:15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Username goes here.', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400)),
              Text('Latest chat message goes here.',style: TextStyle(color: Color(0xFF424f72)),)
            ],
          )
        ),
        Padding(
          padding: EdgeInsets.only(left: 33),
          child:Container(
            height: 25,
            width: 25,
            child: Center(
              child: Text('2', style: TextStyle(color: Colors.white, fontSize: 12),),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFFfacbab), Color(0xFFf1869d)],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.5, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp
              )
            ),
          ),
        )


      ],
    );
  }
  


}

class CustomSearchBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Positioned(
      top:130,
      left:37,
      child:Container(
        height: 57,
        width: MediaQuery.of(context).size.width/1.2,
        child: Padding(
          padding: EdgeInsets.only(left:30,top:5),
          child: TextField(
          cursorColor: Color(0xFFFFFFFF),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.search, color: Color(0xFF65719b),),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: Color(0xFF6873a0), fontWeight: FontWeight.bold)
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: Color(0xFF252c49),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 3))]
        ),
      ) ,
    );
  }

}


class _TestHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: <Widget>[
          AppBar(
          title: Text('Hello'),
        ),
        Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
         Container(
        color: Colors.red,
        height: 57,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none
          ),
        ),
      ),
        ],
      )
        ],
      )
      ,
    );
  }
  
}