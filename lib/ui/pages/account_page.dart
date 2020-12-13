part of 'pages.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String id, name, img;
  final user = FirebaseAuth.instance.currentUser;
  var document = FirebaseFirestore.instance.collection('users');
  bool isLoading = false;

  PickedFile imageFile;
  final ImagePicker imagePicker = ImagePicker();

  Future chooseImage() async {
    final selectedImage = await imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      imageFile = selectedImage;
    });
  }

  void getUserdata() {
    //Ambil data
    document.doc(user.uid).snapshots().listen((event) {
      name = event.data()['name'];
      img = event.data()['profilePicture'];
      if (img == "") {
        img = null;
      }
      setState(() {});
    });
  }

  void initState() {
    getUserdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Data"),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        leading: Container(),
      ),
      body: Stack(children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(img ??
                              "https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png")),
                      SizedBox(
                        height: 10,
                      ),
                      FlatButton.icon(
                        onPressed: () async {
                          await chooseImage();
                          setState(() {
                            isLoading = true;
                          });
                          await UserServices.updateProfile(user.uid, imageFile)
                              .then((value) {
                            if (value) {
                              Fluttertoast.showToast(
                                  msg: "Update Profile Successfull",
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  toastLength: Toast.LENGTH_LONG);
                              setState(() {
                                isLoading = false;
                              });
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Update Profile Failed",
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  toastLength: Toast.LENGTH_LONG);
                              setState(() {
                                isLoading = false;
                              });
                            }
                          });
                        },
                        icon: Icon(Icons.camera_alt),
                        color: Colors.indigo[200],
                        label: Text("Edit Profile"),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(name ?? 'Name'),
                      SizedBox(
                        height: 5,
                      ),
                      Text(user.email),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("SignOut Confirmation"),
                          content: Text("Are you sure to SignOut?"),
                          actions: [
                            FlatButton(
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                await AuthServices.signOut().then((value) {
                                  if (value) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return SignInPage();
                                      }),
                                    );
                                    setState(() {
                                      isLoading = false;
                                    });
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                });
                              },
                              child: Text("Yes"),
                            ),
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("No"))
                          ],
                        );
                      });
                  setState(() {
                    isLoading = false;
                    print(isLoading);
                  });
                },
                child: Text("Sign Out"),
                color: Colors.red[200],
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
    );
  }
}
