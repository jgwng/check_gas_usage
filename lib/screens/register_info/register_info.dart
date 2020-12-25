import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kopo/kopo.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  String addressJSON = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kopo Demo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            child: Text('find Korea Postal address'),
            onPressed: () async {
              KopoModel model = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Kopo(),
                ),
              );
              print(model.toJson());
              setState(() {
                addressJSON =
                '${model.address} ${model.buildingName}${model.apartment == 'Y' ? '아파트' : ''} ${model.zonecode} ';
              });
            },
          ),
          Text('$addressJSON'),
        ],
      ),
    );
  }
}