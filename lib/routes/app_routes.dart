import 'package:eschool/presentation/splash_screen/splash_screen.dart';
import 'package:eschool/presentation/splash_screen/binding/splash_binding.dart';
import 'package:eschool/presentation/announcements_list_screen/announcements_list_screen.dart';
import 'package:eschool/presentation/announcements_list_screen/binding/announcements_list_binding.dart';
import 'package:eschool/presentation/announcements_screen/announcements_screen.dart';
import 'package:eschool/presentation/announcements_screen/binding/announcements_binding.dart';
import 'package:eschool/presentation/my_profile_screen/my_profile_screen.dart';
import 'package:eschool/presentation/my_profile_screen/binding/my_profile_binding.dart';
import 'package:eschool/presentation/employee_dashboard_teachers_list_screen/employee_dashboard_teachers_list_screen.dart';
import 'package:eschool/presentation/employee_dashboard_teachers_list_screen/binding/employee_dashboard_teachers_list_binding.dart';
import 'package:eschool/presentation/employee_dashboard_students_list_screen/employee_dashboard_students_list_screen.dart';
import 'package:eschool/presentation/employee_dashboard_students_list_screen/binding/employee_dashboard_students_list_binding.dart';
import 'package:eschool/presentation/teacher_dasboard_screen/teacher_dasboard_screen.dart';
import 'package:eschool/presentation/teacher_dasboard_screen/binding/teacher_dasboard_binding.dart';
import 'package:eschool/presentation/student_dashboard_screen/student_dashboard_screen.dart';
import 'package:eschool/presentation/student_dashboard_screen/binding/student_dashboard_binding.dart';
import 'package:eschool/presentation/role_screen/role_screen.dart';
import 'package:eschool/presentation/role_screen/binding/role_binding.dart';
import 'package:eschool/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:eschool/presentation/sign_in_screen/binding/sign_in_binding.dart';
import 'package:eschool/presentation/admin_students_list_tab_container_screen/admin_students_list_tab_container_screen.dart';
import 'package:eschool/presentation/admin_students_list_tab_container_screen/binding/admin_students_list_tab_container_binding.dart';
import 'package:eschool/presentation/password_change_screen/password_change_screen.dart';
import 'package:eschool/presentation/password_change_screen/binding/password_change_binding.dart';
import 'package:eschool/presentation/add_teacher_screen/add_teacher_screen.dart';
import 'package:eschool/presentation/add_teacher_screen/binding/add_teacher_binding.dart';
import 'package:eschool/presentation/add_student_screen/add_student_screen.dart';
import 'package:eschool/presentation/add_student_screen/binding/add_student_binding.dart';
import 'package:eschool/presentation/add_employee_screen/add_employee_screen.dart';
import 'package:eschool/presentation/add_employee_screen/binding/add_employee_binding.dart';
import 'package:eschool/presentation/app_navigation_screen/app_navigation_screen.dart';
import 'package:eschool/presentation/app_navigation_screen/binding/app_navigation_binding.dart';
import 'package:get/get.dart';

import '../presentation/employee_tab_container/binding/employee_tab_container_binding.dart';
import '../presentation/employee_tab_container/employee_tab_container_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String announcementsListScreen = '/announcements_list_screen';

  static const String announcementsScreen = '/announcements_screen';

  static const String myProfileScreen = '/my_profile_screen';

  static const String employeeDashboardTeachersListScreen =
      '/employee_dashboard_teachers_list_screen';

  static const String employeeDashboardStudentsListScreen =
      '/employee_dashboard_students_list_screen';

  static const String teacherDasboardScreen = '/teacher_dasboard_screen';

  static const String studentDashboardScreen = '/student_dashboard_screen';

  static const String roleScreen = '/role_screen';

  static const String signInScreen = '/sign_in_screen';

  static const String adminTeachersListPage = '/admin_teachers_list_page';

  static const String adminStudentsListPage = '/admin_students_list_page';

  static const String adminStudentsListTabContainerScreen =
      '/admin_students_list_tab_container_screen';

  static const String employeeTabContainerScreen =
      '/employee_tab_container_screen';

  static const String adminEmployeeListPage = '/admin_employee_list_page';

  static const String passwordChangeScreen = '/password_change_screen';

  static const String addTeacherScreen = '/add_teacher_screen';

  static const String addStudentScreen = '/add_student_screen';

  static const String addEmployeeScreen = '/add_employee_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static String initialRoute = '/initialRoute';

  static List<GetPage> pages = [
    GetPage(
      name: employeeTabContainerScreen,
      page: () => EmployeeTebContainer(),
      bindings: [
        EmployeeTabContainerBinding(),
      ],
    ),
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(),
      bindings: [
        SplashBinding(),
      ],
    ),
    GetPage(
      name: announcementsListScreen,
      page: () => AnnouncementsListScreen(),
      bindings: [
        AnnouncementsListBinding(),
      ],
    ),
    GetPage(
      name: announcementsScreen,
      page: () => AnnouncementsScreen(),
      bindings: [
        AnnouncementsBinding(),
      ],
    ),
    GetPage(
      name: myProfileScreen,
      page: () => MyProfileScreen(),
      bindings: [
        MyProfileBinding(),
      ],
    ),
    GetPage(
      name: employeeDashboardTeachersListScreen,
      page: () => EmployeeDashboardTeachersListScreen(),
      bindings: [
        EmployeeDashboardTeachersListBinding(),
      ],
    ),
    GetPage(
      name: employeeDashboardStudentsListScreen,
      page: () => EmployeeDashboardStudentsListScreen(),
      bindings: [
        EmployeeDashboardStudentsListBinding(),
      ],
    ),
    GetPage(
      name: teacherDasboardScreen,
      page: () => TeacherDasboardScreen(),
      bindings: [
        TeacherDasboardBinding(),
      ],
    ),
    GetPage(
      name: studentDashboardScreen,
      page: () => StudentDashboardScreen(),
      bindings: [
        StudentDashboardBinding(),
      ],
    ),
    GetPage(
      name: roleScreen,
      page: () => RoleScreen(),
      bindings: [
        RoleBinding(),
      ],
    ),
    GetPage(
      name: signInScreen,
      page: () => SignInScreen(),
      bindings: [
        SignInBinding(),
      ],
    ),
    GetPage(
      name: adminStudentsListTabContainerScreen,
      page: () => AdminStudentsListTabContainerScreen(),
      bindings: [
        AdminStudentsListTabContainerBinding(),
      ],
    ),
    GetPage(
      name: passwordChangeScreen,
      page: () => PasswordChangeScreen(),
      bindings: [
        PasswordChangeBinding(),
      ],
    ),
    GetPage(
      name: addTeacherScreen,
      page: () => AddTeacherScreen(),
      bindings: [
        AddTeacherBinding(),
      ],
    ),
    GetPage(
      name: addStudentScreen,
      page: () => AddStudentScreen(),
      bindings: [
        AddStudentBinding(),
      ],
    ),
    GetPage(
      name: addEmployeeScreen,
      page: () => AddEmployeeScreen(),
      bindings: [
        AddEmployeeBinding(),
      ],
    ),
    GetPage(
      name: appNavigationScreen,
      page: () => AppNavigationScreen(),
      bindings: [
        AppNavigationBinding(),
      ],
    ),
    GetPage(
      name: initialRoute,
      page: () => SplashScreen(),
      bindings: [
        SplashBinding(),
      ],
    )
  ];
}
