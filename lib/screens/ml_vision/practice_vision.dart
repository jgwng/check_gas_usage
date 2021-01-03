import 'dart:async';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File pickedImage;
  String result = "분석 전";
  bool isImageLoaded = false;
  List<String> words = [];
  List<String> barcode = [];


  Future pickImage() async {
    var picker = ImagePicker();
    PickedFile image = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      pickedImage = File(image.path);
      isImageLoaded = true;
    });
  }

  Future readText() async {
    words = [];
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);

    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
            words.add(word.text);
          print(word.text);
        }
      }
    }
    setState(() {

    });
  }

  Future decode() async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    BarcodeDetector barcodeDetector = FirebaseVision.instance.barcodeDetector();
    List barCodes = await barcodeDetector.detectInImage(ourImage);

    for (Barcode readableCode in barCodes) {
      barcode.add(readableCode.displayValue);
      print(readableCode.displayValue);
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(height: 100.0),
            isImageLoaded
                ? Center(
              child: Container(
                  height: 200.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(pickedImage), fit: BoxFit.cover))),
            )
                : Container(),
            SizedBox(height: 10.0),
            RaisedButton(
              child: Text('Pick an image'),
              onPressed: pickImage,
            ),
            SizedBox(height: 10.0),
            RaisedButton(
              child: Text('Read Text'),
              onPressed: readText,
            ),
            RaisedButton(
              child: Text('Read Bar Code'),
              onPressed: decode,
            ),
            Text(words.toString()),
            Text(barcode.toString())
          ],
        ));
  }
}