import 'package:get/get.dart';
import 'listrectangleone4_item_model.dart';

class AdminTeachersListModel {
  RxList<Listrectangleone4ItemModel> listrectangleone4ItemList =
      RxList.generate(8, (index) => Listrectangleone4ItemModel());
}
