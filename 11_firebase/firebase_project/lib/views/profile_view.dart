import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/utils/auth_service.dart';
import 'package:firebase_project/utils/store_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  AuthService _authService = AuthService();
  StoreService _storeService = StoreService();
  FirebaseUser _user;

  File _image;
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future getUser() async {
    var user = await _authService.getCurrentUser();
    setState(() {
      _user = user;
    });
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  _onBtnClick() {
    Navigator.of(context).pushNamed('/todo');
  }

  _onSaveImage() async {
    var imgUrl = await _storeService.uploadImage(_image, _user.uid);
    UserUpdateInfo info = UserUpdateInfo();
    info.photoUrl = imgUrl;
    _user.updateProfile(info);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            appBar: AppBar(title: Text('ProfileView')),
            body: Column(
              children: [
                if (_user != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'E-mail: ',
                        style: TextStyle(color: Colors.blue, fontSize: 18),
                      ),
                      Text(_user.email,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w800)),
                    ],
                  ),
                getUserImage(),
                if (_image != null)
                  RaisedButton(
                    onPressed: _onSaveImage,
                    child: Text('Save image'),
                  ),
                RaisedButton(
                  onPressed: _onBtnClick,
                  child: Text('To todo'),
                ),
                Expanded(flex: 1, child: Container())
              ],
            )));
  }

  Expanded getUserImage() {
    var needUserIcon = _user != null && _user.photoUrl != null;
    var needIcon0 = _user != null && _image == null;
    var needNewPic = _user != null && _image != null;

    Widget result;
    if (_user != null && _user.photoUrl != null) {
      result = Image.network(_user.photoUrl);
    } else if (_user != null && _image != null) {
      result = Image.file(_image);
    } else if (_user != null && _image == null) {
      result = GestureDetector(
          onTap: getImage,
          child: Icon(
            Icons.portrait_rounded,
            size: 82,
          ));
    }

    return Expanded(flex: 1, child: result);
  }
}
