class UserModel {
  String? name, email, mobile;

  UserModel({this.name, this.email, this.mobile});

  factory UserModel.mapToModel(Map m1) {
    return UserModel(
        name: m1['name'], email: m1['email'], mobile: m1['mobile']);
  }

  Map<String,dynamic> modelToMap()
  {
    return {
      'name' : name,
      'email' : email,
      'mobile' : mobile,
    };
  }
}
