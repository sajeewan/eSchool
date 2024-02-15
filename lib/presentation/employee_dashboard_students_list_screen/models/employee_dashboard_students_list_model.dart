import 'package:get/get.dart';
import 'listrectangleone1_item_model.dart';

class EmployeeDashboardStudentsListModel {
  RxList<Listrectangleone1ItemModel> listrectangleone1ItemList =
      RxList.generate(8, (index) => Listrectangleone1ItemModel());
}
