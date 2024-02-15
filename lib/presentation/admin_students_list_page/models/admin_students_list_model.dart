import 'package:get/get.dart';
import 'listrectangleone5_item_model.dart';

class AdminStudentsListModel {
  RxList<Listrectangleone5ItemModel> listrectangleone5ItemList =
      RxList.generate(8, (index) => Listrectangleone5ItemModel());
}
