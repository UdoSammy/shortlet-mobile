class AppUser {
  final String uid;
  final String name;
  final String email;
  final int phone;


  AppUser({required this.uid, required this.name, required this.email, required this.phone});

  // app user to json
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }

  // converting json back to appuser
  factory AppUser.fromJson(Map<String, dynamic> jsonUser) {
    return AppUser(
      uid: jsonUser['uid'],
      name: jsonUser['name'],
      email: jsonUser['email'],
      phone: jsonUser['phone']
    );
  }
}
