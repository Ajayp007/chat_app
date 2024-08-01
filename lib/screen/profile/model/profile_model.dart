class ProfileModel {
  String? name, email, mobile,uId;

  ProfileModel({this.name, this.email, this.mobile,this.uId});

  factory ProfileModel.mapToModel(Map m1) {
    return ProfileModel(
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
