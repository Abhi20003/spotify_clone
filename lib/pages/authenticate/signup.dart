import 'package:flutter/material.dart';
import 'package:spotify_clone/main.dart';
import 'package:spotify_clone/services/auth.dart';
import 'package:spotify_clone/shared/decoration.dart';
import 'package:spotify_clone/shared/loading.dart';

String err = "";

class SignUp extends StatefulWidget {
  final Function value;
  SignUp({required this.value});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool errText = false;
  bool loading = false;

  String username = '';
  String pass = '';
  // String err = '';

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
                      EdgeInsets.symmetric(vertical: 80.0, horizontal: 0.0),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        "assets/spotify_logo.png",
                        scale: 6,
                      ),
                      SizedBox(
                        height: 10 * sH / mysH,
                      ),
                      Center(
                        child: Text(
                          "SignUp",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 55,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20 * sH / mysH,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 50.0),
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
                                          side: BorderSide(width: 200)),
                                      color: Colors.green,
                                      child: Text(
                                        'SignUp',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () async {
                                        if (_formkey.currentState!.validate()) {
                                          setState(() {
                                            loading = true;
                                            print(username);
                                            print(pass);
                                          });
                                          dynamic result =
                                              await _auth.CreateNewUser(
                                                  username, pass);
                                          print(result);
                                          if (result == null) {
                                            setState(() {
                                              loading = false;
                                              errText = true;
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
                                    color: errText
                                        ? Colors.red[300]
                                        : Colors.black,
                                    fontSize: 14.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 40 * sW / mysW,
                                    ),
                                    Text(
                                      "Already have an account",
                                      style: TextStyle(
                                        color: Colors.grey[300],
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () => widget.value(),
                                      child: Text("LogIn"),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20.0 * sH / mysH),
                              ],
                            ),
                          )),
                    ],
                  ),
                )),
          );
  }
}
