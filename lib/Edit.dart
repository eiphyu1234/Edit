import 'dart:io';
import 'package:edit_example/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'main.dart';

class Edit extends StatefulWidget {
  static String tag = 'add-page';
  @override
  _AccountPageState createState() => new _AccountPageState();
}


class _AccountPageState extends State<Edit> with ImagePickerListener{
  final _formKey = GlobalKey<FormState>();
  final _cName = TextEditingController();
  final _cNickName = TextEditingController();
  final _cAddress = TextEditingController();
  final _cPhoneNumber = TextEditingController();
  final _cEmail = TextEditingController();

  File _image;
  ImagePickerListener _listener;

  @override
  Widget build(BuildContext context) {
    TextFormField inputName = TextFormField(
      controller: _cName,
      autofocus: true,
      keyboardType: TextInputType.text,
      inputFormatters: [
        LengthLimitingTextInputFormatter(45),
      ],
      decoration: InputDecoration(
        labelText: 'Name',
        icon: Icon(Icons.person, color:appColor,),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Obrigatório';
        }
        return null;
      },
    );

    TextFormField inputPassword = TextFormField(
      controller: _cNickName,
      keyboardType: TextInputType.text,
      inputFormatters: [
        LengthLimitingTextInputFormatter(25),
      ],
      decoration: InputDecoration(
        labelText: 'Password',
        icon: Icon(Icons.lock, color:appColor,),
      ),
    );

    TextFormField inputPhoneNumber = TextFormField(
      controller: _cPhoneNumber,
      inputFormatters: [
        LengthLimitingTextInputFormatter(45),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Phone No.',
        icon: Icon(Icons.phone,color:appColor,),
      ),
    );

    TextFormField inputAddress = TextFormField(
      controller: _cAddress,
      inputFormatters: [
        LengthLimitingTextInputFormatter(45),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Address',
        icon: Icon(Icons.home,color: appColor,),
      ),
    );

    TextFormField inputEmail = TextFormField(
      controller: _cEmail,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'E-mail',
        icon: Icon(
            Icons.email,
            color:appColor,
        ),

      ),
    );

    Future cropImage(File image) async {
      File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        ratioX: 1.0,
        ratioY: 1.0,
        maxWidth: 512,
        maxHeight: 512,
      );
      _listener.userImage(croppedFile);
    }


    openCamera() async {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      cropImage(image);
    }
    openGallery() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      cropImage(image);
    }


    Future<void> _optionsDialogBox(BuildContext context) {
      return showDialog(context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: new SingleChildScrollView(
                child: new ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: new Text('Take a picture'),
                      onTap: ()=> openCamera() ,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                    GestureDetector(
                      child: new Text('Select from gallery'),
                      onTap: ()=> openGallery(),
                    ),
                  ],
                ),
              ),
            );
          });
    }

    final picture = GestureDetector(
      onTap: () => _optionsDialogBox(context),
      child:  Center(
        child: _image == null
            ? Stack(
          children: <Widget>[

            Center(
              child:  CircleAvatar(
                radius: 80.0,
                backgroundColor: const Color(0xFF778899),
                child: Image.asset("assets/photo_camera.png"),
              ),
            ),
          ],
        )
            : Container(
                  height: 160.0,
                  width: 160.0,
                  decoration: new BoxDecoration(
                    color: const Color(0xff7c94b6),
                    image: new DecorationImage(
                      image: new ExactAssetImage(_image.path),
                      fit: BoxFit.cover,
            ),
            border:
                    Border.all(color: appColor, width: 5.0),
            borderRadius:
                    BorderRadius.all(const Radius.circular(80.0)),
          ),
        ),
      ),
    );

    ListView content = ListView(
      padding: EdgeInsets.all(20),
      children: <Widget>[
        SizedBox(height: 20),
        picture,
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: new EdgeInsets.only(top: 20.0),
              ),
              inputName,
              Padding(
                padding: new EdgeInsets.only(top: 20.0),
              ),
              inputPassword,
              Padding(
                padding: new EdgeInsets.only(top: 20.0),
              ),
              inputPhoneNumber,
              Padding(
                padding: new EdgeInsets.only(top: 20.0),
              ),
              inputEmail,
              Padding(
                padding: new EdgeInsets.only(top: 20.0),
              ),
              inputAddress,
              //inputWebSite,
            ],
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text("Edit"),
        actions: <Widget>[
          Container(
            width: 80,
            child: IconButton(
                icon: Text( 'SAVE', style: TextStyle(fontWeight: FontWeight.bold), ),
                onPressed: () {
                 /* Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Account())
                  );*/
                },
            ),
          )
        ],
      ),
      body: content,
    );
  }

  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
    });
  }
}
abstract class ImagePickerListener {
  userImage(File _image);
}

