import 'package:flutter/material.dart';

class CityPage extends StatelessWidget {
  CityPage({Key key}) : super(key: key);
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenSize = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Шаар аркылу табуу'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/weather.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              height: screenSize * 0.35,
            ),
            TextField(
              controller: _textEditingController,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 22),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                hintText: 'Шаардын атын жаз',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: screenSize * 0.05,
            ),
            OutlinedButton(
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                Navigator.pop(context, _textEditingController.text);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 163, 191, 188),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Text(
                  "Шаарды тап",
                  style: TextStyle(fontSize: 35, color: Colors.black),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
