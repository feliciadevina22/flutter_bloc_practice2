part of 'models.dart';

class Users extends Equatable {
  final String uid;
  final String email;
  final String name;
  final String profilePicture;

  Users(this.uid, this.email, {this.name, this.profilePicture});

  //{} means allowed to be null
  @override
  // TODO: implement props
  List<Object> get props => [uid, email, name, profilePicture];
}
