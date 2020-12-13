import 'package:flutter/material.dart';
import 'package:flutter_bloc_practice/models/models.dart';
import 'package:flutter_bloc_practice/ui/pages/pages.dart';

class ProductCard extends StatelessWidget {
  final Products product;
  ProductCard({this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UpdatePage(product: product)));
        },
        title: Text(
          product.name,
          style: TextStyle(fontSize: 20),
        ),
        subtitle: Text(product.price),
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage(product.image, scale: 30),
        ),
        trailing: Icon(
          Icons.remove_red_eye,
          color: Colors.indigo,
        ),
      ),
    );
  }
}
