import 'package:checkgasusage/services/camera_preview_scanner.dart';
import 'package:checkgasusage/services/material_barcode_scanner.dart';
import 'package:checkgasusage/services/picture_scanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExampleList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ExampleListState();
}

class ExampleListState extends State<ExampleList> {
  static final List<String> _exampleWidgetNames = <String>[
    '$PictureScanner',
    '$CameraPreviewScanner',
    '$MaterialBarcodeScanner',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example List'),
      ),
      body: ListView.builder(
        itemCount: _exampleWidgetNames.length,
        itemBuilder: (BuildContext context, int index) {
          final String widgetName = _exampleWidgetNames[index];

          return Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            child: ListTile(
              title: Text(widgetName),
              onTap: () =>  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MaterialBarcodeScanner()),
              ),
            ),
          );
        },
      ),
    );
  }
}
