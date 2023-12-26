import 'package:get/get.dart';

import '../models/character.dart';

class CharacterController extends GetxController {

  Character? character = Get.arguments;

  List<String> info = ['Status', 'Gender', 'Created At', 'Species', 'Origin'];

  @override
  void onInit() {
    super.onInit();
  }

}