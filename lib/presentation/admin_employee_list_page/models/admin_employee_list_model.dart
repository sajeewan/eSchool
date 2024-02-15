import 'package:get/get.dart';
import 'listrectangleone6_item_model.dart';

class AdminEmployeeListModel {
  RxList<Listrectangleone6ItemModel> listrectangleone6ItemList =
      RxList.generate(8, (index) => Listrectangleone6ItemModel());
}
