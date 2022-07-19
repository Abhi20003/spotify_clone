import 'package:spotify_clone/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:spotify_clone/services/auth.dart';
import 'package:spotify_clone/shared/loading.dart';
import 'package:spotify_clone/shared/decoration.dart';

bool result = false;

class LogIn extends StatefulWidget {
  final Function value;
  LogIn({required this.value});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formkey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  bool loading = false;

  //text field state

  String username = '';
  String pass = '';
  String err = '';

  @override
  Widget build(BuildContext context) {
    double sW = MediaQuery.of(context).size.width;
    double sH = MediaQuery.of(context).size.height;
    return loading
        ? Loading()
        : SafeArea(
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.black,
                body: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 100.0, horizontal: 0.0),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/spotify_logo.png",
                              scale: 10,
                            ),
                            SizedBox(
                              width: 10 * sW / mysW,
                            ),
                            Text(
                              "LogIn",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20 * sH / mysH,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0 * sH / mysH,
                              horizontal: 50.0 * sW / mysW),
                          child: Form(
                            key: _formkey,
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 20.0 * sH / mysH),
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  decoration: TextInputDecoration.copyWith(
                                      hintText: "USERNAME"),
                                  onChanged: (val) {
                                    setState(() {
                                      username = val;
                                    });
                                  },
                                ),
                                SizedBox(height: 20.0 * sH / mysH),
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  decoration: TextInputDecoration.copyWith(
                                      hintText: "PASSWORD"),
                                  obscureText: true,
                                  onChanged: (val) {
                                    setState(() {
                                      pass = val;
                                    });
                                  },
                                ),
                                SizedBox(height: 20.0 * sH / mysH),
                                Container(
                                  width: 300,
                                  height: 50,
                                  child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          side: BorderSide(
                                              width: 200 * sW / mysW)),
                                      color: Colors.green,
                                      child: Text(
                                        'LogIn',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () async {
                                        if (_formkey.currentState!.validate()) {
                                          setState(() {
                                            loading = true;
                                            print(username);
                                            print(pass);
                                          });
                                          dynamic result = await _auth
                                              .SignInWithEmailAndPassword(
                                                  username, pass);
                                          print(result);
                                          if (result == null) {
                                            setState(() {
                                              loading = false;
                                              err =
                                                  'One or both of Email and Password is incorrect';
                                            });
                                          }
                                        }
                                      }),
                                ),
                                SizedBox(
                                  height: 12 * sH / mysH,
                                ),
                                Text(
                                  err,
                                  style: TextStyle(
                                    color: Colors.red[300],
                                    fontSize: 14.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don't have an account",
                                      style: TextStyle(
                                        color: Colors.grey[300],
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () => widget.value(),
                                      child: Text("SignUp"),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20.0 * sH / mysH),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10.0 * sW / mysW,
                                            vertical: 0.0),
                                        child: Divider(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "OR",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10.0 * sW / mysW,
                                            vertical: 0.0),
                                        child: Divider(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                        width: 300.0 * sW / mysW,
                        height: 50.0 * sH / mysH,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Row(
                              children: [
                                Icon(FeatherIcons.globe),
                                SizedBox(
                                  width: 40 * sW / mysW,
                                ),
                                Text(
                                  "LogIn With Google",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15.0),
                                ),
                              ],
                            ),
                            color: Colors.white,
                            onPressed: () async {
                              setState(() {
                                loading = true;
                              });
                              await _auth.SignInWithGoogle();
                            }),
                      ),
                      SizedBox(height: 12.0 * sH / mysH),
                      SizedBox(
                        width: 300.0 * sW / mysW,
                        height: 50.0 * sH / mysH,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Row(
                              children: [
                                Icon(FeatherIcons.facebook),
                                SizedBox(
                                  width: 40 * sW / mysW,
                                ),
                                Text(
                                  "LogIn With Facebook",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15.0),
                                ),
                              ],
                            ),
                            color: Colors.white,
                            onPressed: () {}),
                      ),
                    ],
                  ),
                )),
          );
  }
}
