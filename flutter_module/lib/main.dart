import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyNewApp());

class MyNewApp extends StatefulWidget {
  const MyNewApp({Key? key}) : super(key: key);

  @override
  _MyNewAppState createState() => _MyNewAppState();
}

class _MyNewAppState extends State<MyNewApp> {
  final MethodChannel _oneChannel = const MethodChannel("one_page");
  final MethodChannel _twoChannel = const MethodChannel("two_page");

  final BasicMessageChannel _msgChannel = const BasicMessageChannel("message_channel", StandardMessageCodec());

  String pageIndex = "";

  @override
  void initState() {
    super.initState();
    _oneChannel.setMethodCallHandler((call) {
      pageIndex = call.method;
      debugPrint("one channel $pageIndex");
      setState(() {});
      return Future((){});
    });

    _twoChannel.setMethodCallHandler((call) {
      pageIndex = call.method;
      debugPrint("two channel $pageIndex");
      setState(() {});
      return Future((){});
    });

    _msgChannel.setMessageHandler((message) {
      debugPrint("收到iOS的消息 $message");
      return Future((){});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _rootWidgetWithPageIndex(pageIndex),
    );;
  }

  Widget _rootWidgetWithPageIndex(String pageIndex) {
    switch (pageIndex) {
      case "one":
        return Scaffold(
          appBar: AppBar(title: Text("$pageIndex"),),
          body: Column(
            children: [
              GestureDetector(
                child: Text("this is $pageIndex page"),
                onTap: (){
                  const MethodChannel("one_page").invokeMapMethod("exit");
                },
              ),
              TextField(
                onChanged: (String text) {
                  _msgChannel.send(text);
                },
              ),
            ],
          ),
        );
        break;
      case "two":
        return Scaffold(
          appBar: AppBar(title: Text(pageIndex),),
          body: Center(
            child: GestureDetector(
              child: Text("this is $pageIndex page"),
              onTap: (){
                const MethodChannel("two_page").invokeMapMethod("exit");
              },
            ),
          ),
        );
        break;
      default:
        return Scaffold(
          appBar: AppBar(title: Text("defalut page"),),
          body: Center(
            child: GestureDetector(
              child: Text("this is $pageIndex page"),
              onTap: (){
                const MethodChannel("defalut_page").invokeMapMethod("exit");
              },
            ),
          ),
        );
        break;
    }
  }
}


// 下边的是老的，
class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.pageIndex}) : super(key: key);
  final String pageIndex;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _rootWidgetWithPageIndex(pageIndex),
    );
  }

  Widget _rootWidgetWithPageIndex(String pageIndex) {
    switch (pageIndex) {
      case "one":
        return Scaffold(
          appBar: AppBar(title: Text("$pageIndex"),),
          body: Center(
            child: GestureDetector(
              child: Text("this is $pageIndex page"),
              onTap: (){
                const MethodChannel("one_page").invokeMapMethod("exit");
              },
            ),
          ),
        );
        break;
      case "two":
        return Scaffold(
          appBar: AppBar(title: Text(pageIndex),),
          body: Center(
            child: GestureDetector(
              child: Text("this is $pageIndex page"),
              onTap: (){
                const MethodChannel("two_page").invokeMapMethod("exit");
              },
            ),
          ),
        );
        break;
      default:
        return Scaffold(
          appBar: AppBar(title: Text("defalut page"),),
          body: Center(
            child: GestureDetector(
              child: Text("this is $pageIndex page"),
              onTap: (){
                const MethodChannel("defalut_page").invokeMapMethod("exit");
              },
            ),
          ),
        );
        break;
    }
  }
}


