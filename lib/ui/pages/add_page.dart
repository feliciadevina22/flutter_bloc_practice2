part of 'pages.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final ctrlName = TextEditingController();
  final ctrlPrice = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    ctrlName.dispose();
    ctrlPrice.dispose();
    super.dispose();
  }

  void clearForm() {
    ctrlName.clear();
    ctrlPrice.clear();
    setState(() {
      imageFile = null;
    });
  }

  PickedFile imageFile;
  final ImagePicker imagePicker = ImagePicker();

  Future chooseImage() async {
    final selectedImage = await imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      imageFile = selectedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Data"),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        leading: Container(),
      ),
      body: Stack(children: [
        Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: ctrlName,
                    decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.indigo),
                        prefixIcon: Icon(
                          Icons.widgets,
                          color: Colors.indigo,
                        ),
                        labelText: 'Product Name',
                        hintText: "Input your product name",
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.indigo))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: ctrlPrice,
                    decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.indigo),
                        prefixIcon: Icon(
                          Icons.attach_money,
                          color: Colors.indigo,
                        ),
                        labelText: 'Product Price',
                        hintText: "Input your product price",
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.indigo))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  imageFile == null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RaisedButton.icon(
                              onPressed: () {
                                chooseImage();
                              },
                              icon: Icon(Icons.image),
                              label: Text("Choose from Galery"),
                            ),
                            Text("File not Found")
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RaisedButton.icon(
                              onPressed: () {
                                chooseImage();
                              },
                              icon: Icon(Icons.image),
                              label: Text("Rehoose from Galery"),
                            ),
                            Semantics(
                              child: Image.file(
                                File(imageFile.path),
                                width: 100,
                              ),
                            )
                          ],
                        ),
                  SizedBox(
                    height: 40,
                  ),
                  RaisedButton(
                    child: Text("Add Product"),
                    color: Colors.indigo,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(10),
                    onPressed: () async {
                      if (ctrlName.text == "" ||
                          ctrlPrice.text == "" ||
                          imageFile == null) {
                        Fluttertoast.showToast(
                            msg: "Please fill all fields!",
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            toastLength: Toast.LENGTH_LONG);
                      } else {
                        setState(() {
                          isLoading = true;
                        });
                        Products product =
                            Products("", ctrlPrice.text, ctrlName.text, "");
                        bool result = await ProductServices.addProduct(
                            product, imageFile);
                        if (result == true) {
                          Fluttertoast.showToast(
                              msg: "Add Product Succsessful",
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              toastLength: Toast.LENGTH_LONG);
                          clearForm();
                          setState(() {
                            isLoading = false;
                          });
                        } else {
                          Fluttertoast.showToast(
                              msg: "Add Product Failed",
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              toastLength: Toast.LENGTH_LONG);
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                    },
                  ),
                  SizedBox(height: 20),
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
    );
  }
}
