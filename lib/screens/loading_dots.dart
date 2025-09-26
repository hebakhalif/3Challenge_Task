import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingDots extends StatefulWidget {
  const LoadingDots({super.key});

  @override
  State<LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<LoadingDots> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Sequetial Loading Dots"),
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
      ),
        backgroundColor: Colors.white,
        body: Center(
          child: SpinKitThreeBounce(
            color: Colors.blue,                
            size: 60.0,                         
            duration: Duration(milliseconds: 1200), 
          ),
        ),
     );
  }
}