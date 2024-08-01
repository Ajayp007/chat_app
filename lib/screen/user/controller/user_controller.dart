
import 'package:chat_app/screen/profile/controller/profile_controller.dart';
import 'package:chat_app/screen/profile/model/profile_model.dart';
import 'package:chat_app/utils/helper/firedb_helper.dart';
import 'package:get/get.dart';

class UserController extends GetxController
{
  RxList<ProfileModel> l1 = <ProfileModel>[].obs;

  ProfileController controller = Get.put(ProfileController());

  Future<void> getAllUser()
  async {
    List<ProfileModel> modelList = await FireDbHelper.helper.getAllUser(controller.model.value);
    l1.value= modelList;
  }

}
