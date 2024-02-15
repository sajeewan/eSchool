import 'package:get/get.dart';
import 'listrectangleone2_item_model.dart';

class TeacherDasboardModel {
  RxList<Listrectangleone2ItemModel> listrectangleone2ItemList =
      RxList.generate(8, (index) => Listrectangleone2ItemModel());
}
