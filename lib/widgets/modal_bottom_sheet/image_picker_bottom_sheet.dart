import 'dart:io';
import 'package:checkgasusage/constants/size.dart';
import 'package:checkgasusage/services/permission.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/all.dart';

class ImagePickerBottomSheet extends ConsumerWidget {

  final String title;

  ImagePickerBottomSheet({this.title});

  final TextStyle _headerTextStyle = TextStyle(fontFamily: "NotoSans", fontSize: 16.0, fontWeight: FontWeight.w400 );

  final TextStyle _bodyTextStyle = TextStyle(fontFamily: "NotoSans", fontSize: 16.0, fontWeight: FontWeight.w500 );

   File _image;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
      return Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.87)))
        ),
        height:widgetHeight(190),
        child: Column(
          children: [
            buildHeader(context),
            buildBody(context,title),
          ],
        ),
      );
  }
  Widget buildBody(BuildContext context,String title) {
    return Expanded(
      child: Container(
        color: Color.fromRGBO(239, 240, 242, 1.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.image, size: 24,),
              onTap: ()async{
                try {
                  bool result = await checkGalleryPermission();
                  if(result)
                  _image = await _uploadImageToStorage(ImageSource.gallery, context);
                  Navigator.pop(context, _image);
                }catch(e){
                  Navigator.pop(context, _image);
                }
              },
              title: Text("갤러리에서 가져오기",style: _bodyTextStyle),
            ),
            ListTile(
              leading: Icon(Icons.camera_alt, size: 24,),
              onTap: ()async {
                try{
                  bool result = await checkCameraPermission();
                  if(result){
                    _image = await _uploadImageToStorage(ImageSource.camera,context);
                    Navigator.pop(context, _image);
                  }

                }catch(e){
                  print(e);
                }finally{
                  Navigator.pop(context, _image);
                }
              },
              title: Text("사진 촬영하기",style: _bodyTextStyle),
            ),
          ],
        ),
      ),
    );
  }

  Future<File> _uploadImageToStorage(ImageSource source, BuildContext context) async {
    var picker = ImagePicker();
    PickedFile image = await picker.getImage(source: source);
    if(image != null)
      return File(image.path);
    else
      return null;
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.16)))
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      height: 48,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title, style: _headerTextStyle,
            ),
          ),
          InkWell(child: Icon(Icons.close), onTap: (){
            Navigator.of(context).pop();
          },),
        ],
      ),
    );
  }
}
