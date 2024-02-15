import 'package:get/get.dart';
import 'listrectangleone_item_model.dart';

class EmployeeDashboardTeachersListModel {
  RxList<ListrectangleoneItemModel> listrectangleoneItemList =
      RxList.generate(8, (index) => ListrectangleoneItemModel());
}
