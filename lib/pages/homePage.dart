import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    context.size!.height;
    return Scaffold(
      body: Container(
        child: Center(child: FloatingActionButton(onPressed: (){

        }),),
      ),
    );
  }
}