class PersonalModel {
  String? name, email, mobile,uId;

  PersonalModel({this.name, this.email, this.mobile,this.uId});

  factory PersonalModel.mapToModel(Map m1) {
    return PersonalModel(
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
