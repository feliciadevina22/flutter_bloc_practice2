part of 'models.dart';

class Products extends Equatable {
  final String id;
  final String price;
  final String name;
  final String image;

  Products(this.id, this.price, this.name, this.image);

  //{} means allowed to be null
  @override
  // TODO: implement props
  List<Object> get props => [id, name, price, image];
}
