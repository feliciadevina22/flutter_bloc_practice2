import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_practice/bloc/bloc.dart';
import 'package:flutter_bloc_practice/main.dart';
import 'package:flutter_bloc_practice/models/models.dart';
import 'package:flutter_bloc_practice/services/services.dart';
import 'package:flutter_bloc_practice/ui/widgets/productCard.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

part 'add_page.dart';
part 'data_page.dart';
part 'account_page.dart';
part 'mainmenu.dart';
part 'signin_page.dart';
part 'signup_page.dart';
part 'update_page.dart';

//Ini nda dipake udahan
part 'main_page.dart';
part 'home_page.dart';
