part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final ctrlEmail = TextEditingController();
  final ctrlPass = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    ctrlEmail.dispose();
    ctrlPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Sign In"),
          backgroundColor: Colors.indigo,
        ),
        body: Stack(children: [
          Container(
            margin: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: ctrlEmail,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.indigo),
                          prefixIcon: Icon(Icons.mail, color: Colors.indigo),
                          labelText: 'Email',
                          hintText: "Write your active email",
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.indigo))),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: ctrlPass,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.indigo),
                          prefixIcon: Icon(Icons.lock, color: Colors.indigo),
                          labelText: 'Password',
                          hintText: "Password",
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.indigo))),
                    ),
                    SizedBox(height: 20),
                    RaisedButton.icon(
                      icon: Icon(Icons.cake),
                      label: Text("Sign In"),
                      textColor: Colors.white,
                      color: Colors.indigo,
                      onPressed: () async {
                        if (ctrlEmail.text == "" || ctrlPass.text == "") {
                          Fluttertoast.showToast(
                              msg: "Please fill all fields!",
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              toastLength: Toast.LENGTH_LONG);
                        } else {
                          setState(() {
                            isLoading = true;
                          });
                          String result = await AuthServices.signIn(
                              ctrlEmail.text, ctrlPass.text);
                          if (result == "success") {
                            Fluttertoast.showToast(
                              msg: "Sign in successful!",
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              gravity: ToastGravity.BOTTOM,
                              toastLength: Toast.LENGTH_LONG,
                              fontSize: 16.0,
                            );
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return MainMenu();
                            }));
                          } else {
                            Fluttertoast.showToast(
                              msg: result,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              gravity: ToastGravity.BOTTOM,
                              toastLength: Toast.LENGTH_LONG,
                              fontSize: 16.0,
                            );
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(height: 25),
                    RichText(
                      text: TextSpan(
                          text: "Don't have an account? Sign up",
                          style: TextStyle(color: Colors.indigo),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print(Text("coba"));
                              Navigator.pushReplacement(this.context,
                                  MaterialPageRoute(builder: (context) {
                                return SignUpPage();
                              }));
                            }),
                    ),
                  ],
                )
              ],
            ),
          ),
          isLoading == true
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.transparent,
                  child: SpinKitFadingCircle(
                    size: 50,
                    color: Colors.red,
                  ),
                )
              : Container()
        ]),
      ),
    );
  }
}
