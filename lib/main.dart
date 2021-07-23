import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

/*
Simple App to demonstrate following assertion when Html() widget displays <ul>
content under certain circumstances

RenderBox was not laid out: RenderPhysicalShape#b432c relayoutBoundary=up2
'package:flutter/src/rendering/box.dart':
Failed assertion: line 1930 pos 12: 'hasSize'
*/

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _testDialog(String html) {
    setState(() {
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: EdgeInsets.all(20),
            child: _generateTestWidget(html),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('flutter_html_list_crash')),
      body: Container(
        width: double.infinity,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              onPressed: () {
                _testDialog("<div>TEXT</div>");
              },
              child: Text("Test html <div> - OK")),
          ElevatedButton(
              onPressed: () {
                _testDialog("<ul><li>TEXT</li></ul>");
              },
              child: Text("Test html <ul> - ISSUE")),
        ]),
      ),
    );
  }

  _generateTestWidget(String html) {
    return IntrinsicWidth(
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: Column(children: [Html(data: html)]),
      ),
    );
  }
}
