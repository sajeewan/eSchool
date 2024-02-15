import 'package:get/get.dart';
import 'role_screen_item_model.dart';

class RoleModel {
  RxList<RoleScreenItemModel> roleScreenItemList =
      RxList.generate(4, (index) => RoleScreenItemModel());
}
