import 'package:get/get.dart';
import 'listrectangleone3_item_model.dart';

class StudentDashboardModel {
  RxList<Listrectangleone3ItemModel> listrectangleone3ItemList =
      RxList.generate(8, (index) => Listrectangleone3ItemModel());
}
