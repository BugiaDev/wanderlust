class User {
  String uid;
  String email;

  User(this.uid, this.email);

  bool get isActivatedUser => email != '';
}