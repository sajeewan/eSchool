import 'package:eschool/data/models/announcement.dart';

import 'controller/announcements_list_controller.dart';
import 'package:eschool/core/app_export.dart';
import 'package:eschool/widgets/app_bar/appbar_image.dart';
import 'package:eschool/widgets/app_bar/appbar_title.dart';
import 'package:eschool/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class AnnouncementsListScreen extends GetWidget<AnnouncementsListController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            appBar: CustomAppBar(
                height: getVerticalSize(98),
                leadingWidth: 50,
                leading: AppbarImage(
                    height: getVerticalSize(17),
                    width: getHorizontalSize(30),
                    svgPath: ImageConstant.imgArrowleft,
                    margin: getMargin(left: 20, top: 54, bottom: 27),
                    onTap: onTapArrowleft),
                centerTitle: true,
                title: AppbarTitle(
                    text: "lbl_announcements".tr,
                    margin: getMargin(top: 54, bottom: 20)),
                styleType: Style.bgFillBluegray700),
            body: Container(
              width: double.maxFinite,
              padding: getPadding(left: 22, top: 33, right: 22, bottom: 33),
              child: StreamBuilder<List<Announcement>>(
                stream: controller.announcementStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final announcements = snapshot.data!;
                    if (announcements.length == 0) {
                      return Center(
                        child: Text('No announcements added yet.'),
                      );
                    }
                    return ListView.builder(
                      itemCount: announcements.length,
                      itemBuilder: (context, index) {
                        final announcement = announcements[index];
                        return Container(
                          padding: EdgeInsets.only(top: 5, bottom: 2),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            shadowColor: Colors.blueGrey.shade700,
                            child: ListTile(
                              leading: Icon(Icons.announcement),
                              title: Text(
                                announcement.title,
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                announcement.message,
                                textAlign: TextAlign.left,
                              ),
                              onTap: () {},
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error fetching announcements'),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            )));
  }

  onTapArrowleft() {
    Get.back();
  }
}
