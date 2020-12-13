part of 'pages.dart';

class UpdatePage extends StatefulWidget {
  final Products product;

  UpdatePage({Key key, @required this.product}) : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  String id, name, price;
  final ctrlName = TextEditingController();
  final ctrlPrice = TextEditingController();
  Products product;
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
  void initState() {
    product = widget.product;
    super.initState();

    id = product.id;
    ctrlName.text = product.name;
    ctrlPrice.text = product.price;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Data"),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
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
                        labelText: 'Price',
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
                            Image(
                              image: NetworkImage(product.image),
                              width: 100,
                            )
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RaisedButton(
                        child: Text("Update Product"),
                        color: Colors.indigo,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(10),
                        onPressed: () async {
                          String image = product.image;
                          if (ctrlName.text == "" ||
                              ctrlPrice.text == "" ||
                              imageFile == null) {
                            if (ctrlName.text == "") {
                              ctrlName.text = name;
                            }
                            if (ctrlPrice.text == "") {
                              ctrlPrice.text = price;
                            }
                            Fluttertoast.showToast(
                                msg: "The empty field saved with old data!",
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                toastLength: Toast.LENGTH_LONG);
                            setState(() {
                              isLoading = true;
                            });
                            Products product = Products(
                                id, ctrlPrice.text, ctrlName.text, image);
                            bool result =
                                await ProductServices.updateProduct(product);
                            if (result == true) {
                              Fluttertoast.showToast(
                                  msg: "Update Product Succsessful",
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  toastLength: Toast.LENGTH_LONG);
                              clearForm();
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pop(context);
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Update Product Failed",
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  toastLength: Toast.LENGTH_LONG);
                              setState(() {
                                isLoading = false;
                              });
                            }
                          } else {
                            setState(() {
                              isLoading = true;
                            });
                            if (imageFile == null) {
                            } else {
                              Products product = Products(
                                  id, ctrlPrice.text, ctrlName.text, "");
                              bool result = await ProductServices.updateProduct(
                                  product, imageFile);
                              if (result == true) {
                                Fluttertoast.showToast(
                                    msg: "Update Product Succsessful",
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    toastLength: Toast.LENGTH_LONG);
                                clearForm();
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.pop(context);
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Update Product Failed",
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    toastLength: Toast.LENGTH_LONG);
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                          }
                        },
                      ),
                      RaisedButton(
                        color: Colors.indigo,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(10),
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          Products product =
                              Products(id, ctrlPrice.text, ctrlName.text, "");
                          bool result =
                              await ProductServices.deleteProduct(product);
                          if (result == true) {
                            Fluttertoast.showToast(
                                msg: "Delete Product Succsessful",
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                toastLength: Toast.LENGTH_LONG);
                            clearForm();
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.pop(context);
                          } else {
                            Fluttertoast.showToast(
                                msg: "Delete Product Failed",
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                toastLength: Toast.LENGTH_LONG);
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                        child: Text("Delete Data"),
                      )
                    ],
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
