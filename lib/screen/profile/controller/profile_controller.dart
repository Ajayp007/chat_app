
import 'package:chat_app/utils/helper/firedb_helper.dart';
import 'package:get/get.dart';

import '../model/profile_model.dart';

class ProfileController extends GetxController
{
  Rx<ProfileModel> model = ProfileModel().obs;

  Future<void> getUserData()
  async {
    ProfileModel data = await FireDbHelper.helper.currentUser();
      model.value = data;
  }

}