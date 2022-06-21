import 'package:flutter/material.dart';

class TestFuture extends StatefulWidget {
  const TestFuture({Key key}) : super(key: key);

  @override
  _TestFutureState createState() => _TestFutureState();
}

class _TestFutureState extends State<TestFuture> {
  String name = 'hih';
  @override
  void initState() {
    super.initState();

    void getName() {
      Future.delayed(Duration(seconds: 3), () {
        name = 'text keldi';
      });
      setState(() {
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text(name ?? 'boshbolso ushunu ber'),
        ),
      ),
    );
  }
}
