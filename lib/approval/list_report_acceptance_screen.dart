import 'package:cityway_report_client/homepage/reoport_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/config/information.dart';
import '/core/native_service/secure_storage.dart';
import '/core/resource/color_manager.dart';
import '/homepage/allreport_model.dart';
import '../homepage/homepage_screen.dart';
import 'report_accept.dart';

class ReportAcceptanceScreen extends StatelessWidget {
  ReportAcceptanceScreen({Key? key}) : super(key: key);

  final ReportListController controller = Get.put(ReportListController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DefaultTabController(
        length: 3, // Only one tab for "Complete" reports
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'الموافقة على التسعير',
              style: TextStyle(color: AppColorManager.white),
            ),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'مكتمل'),
                Tab(text: 'مقبول'),
                Tab(text: 'مرفوض'),
              ],
              labelColor: AppColorManager.white,
              unselectedLabelColor: AppColorManager.babyGreyAppColor,
              indicatorColor: AppColorManager.white,
            ),
            backgroundColor: AppColorManager.mainAppColor,
          ),
          body: TabBarView(
            children: [
              _buildReportList(status: 'Complete'),
              _buildReportList(status: 'Approved'),
              _buildReportList(status: 'Rejected'),
            ],
          ),
          drawer: _buildDrawer(context),
          floatingActionButton: _buildAddReportButton(context),
        ),
      );
    });
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(Information.username),
            accountEmail: Text(Information.email),
            currentAccountPicture: CircleAvatar(
                backgroundColor: AppColorManager.white,
                child: Image.asset("assets/images/logo.png")),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: AppColorManager.secondaryAppColor,
            ),
            title: const Text(
              'الصفحة الرئيسية',
              style: TextStyle(
                  color: AppColorManager.secondaryAppColor,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Get.to(() => const TabBarWithListView());
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.attach_money,
              color: AppColorManager.secondaryAppColor,
            ),
            title: const Text(
              'الموافقة على التسعير',
              style: TextStyle(
                  color: AppColorManager.secondaryAppColor,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: AppColorManager.secondaryAppColor,
            ),
            title: const Text(
              'تسجيل خروج',
              style: TextStyle(
                  color: AppColorManager.secondaryAppColor,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () => _showLogoutConfirmationDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildReportList({required String status}) {
    if (controller.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    } else {
      var reports = controller.reportList
          .where((report) => report.statusClient == status) // Updated filter
          .toList();

      if (reports.isEmpty) {
        return _buildEmptyListAnimation();
      } else {
        return RefreshIndicator(
          onRefresh: () async {
            controller.fetchReports();
          },
          child: ListView.builder(
            itemCount: reports.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Get.to(() => ReportAcceptScreen(report: reports[index]));
              },
              child: _buildReportItem(reports[index]),
            ),
          ),
        );
      }
    }
  }
  // Widget _buildReportList({required String status}) {
  //   if (controller.isLoading.value) {
  //     return const Center(child: CircularProgressIndicator());
  //   } else {
  //     var reports = controller.reportList
  //         .where((report) =>
  //             report.statusClient ==
  //             'Complete') // Filter only "Complete" reports
  //         .toList();

  //     if (reports.isEmpty) {
  //       return _buildEmptyListAnimation();
  //     } else {
  //       return RefreshIndicator(
  //         onRefresh: () async {
  //           controller.fetchReports();
  //         },
  //         child: ListView.builder(
  //           itemCount: reports.length,
  //           itemBuilder: (context, index) => GestureDetector(
  //               onTap: () {
  //                 Get.to(() => ReportAcceptScreen(report: reports[index]));
  //               },
  //               child: _buildReportItem(reports[index])),
  //         ),
  //       );
  //     }
  //   }
  // }

  Widget _buildEmptyListAnimation() {
    return const AnimatedOpacity(
      opacity: 1.0, // Fully visible
      duration: Duration(seconds: 2), // Duration of the animation
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.report_problem, size: 80, color: Colors.grey),
            Text('ما من بلاغات مقدمة بعد..',
                style: TextStyle(fontSize: 24, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildReportItem(DataAllReport report) {
    Color statusColor = _getStatusColor(report.statusClient);
    String statusValue = _getStatusValue(report.statusClient);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: _itemDecoration(statusColor),
            child: ListTile(
              title: _buildTitle(report),
              subtitle: Text("حالة المشروع: $statusValue",
                  style: TextStyle(
                      color: statusColor, fontWeight: FontWeight.w500)),
              leading:
                  Icon(Icons.stacked_bar_chart, color: statusColor, size: 25),
            ),
          ),
        ),
      ],
    );
  }

  BoxDecoration _itemDecoration(Color statusColor) {
    return BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: statusColor.withOpacity(0.5),
          spreadRadius: 3,
          blurRadius: 4,
          offset: const Offset(0, 1),
        ),
      ],
      borderRadius: BorderRadius.circular(10),
    );
  }

  Column _buildTitle(DataAllReport report) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(report.project,
            style: const TextStyle(
                color: AppColorManager.secondaryAppColor,
                fontWeight: FontWeight.bold)),
        Text("موقع المشروع: ${report.location}",
            style: const TextStyle(color: AppColorManager.secondaryAppColor)),
      ],
    );
  }

  FloatingActionButton _buildAddReportButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        var result = await Get.toNamed('create');
        if (result == true) {
          controller.fetchReports();
        }
      },
      backgroundColor: AppColorManager.mainAppColor,
      child: const Icon(Icons.add, color: AppColorManager.white),
    );
  }

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    final confirmLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تسجيل خروج'),
        content: const Text('هل أنت متأكد؟'),
        actions: <Widget>[
          TextButton(
              child: const Text('إلغاء'),
              onPressed: () => Navigator.of(context).pop(false)),
          TextButton(
              child: const Text('تأكيد'),
              onPressed: () => Navigator.of(context).pop(true)),
        ],
      ),
    );

    if (confirmLogout == true) {
      _logout();
    }
  }

  void _logout() async {
    final secureStorage = SecureStorage();
    await secureStorage.delete('token');
    Information.TOKEN = '';
    Get.offAllNamed('/signin');
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Urgent':
        return Colors.red;
      case 'Complete':
        return Colors.deepOrange;
      case 'Rejected':
        return Colors.pink;
      case 'In-Progress':
        return Colors.blue;
      case 'Pending':
        return Colors.grey;
      case 'Done':
        return Colors.yellow[700]!;
      case 'Approved':
        return Colors.green;
      default:
        return Colors.purple;
    }
  }

  String _getStatusValue(String status) {
    switch (status) {
      case 'Urgent':
        return 'عاجل';
      case 'Complete':
        return 'مكتمل';
      case 'Rejected':
        return 'مرفوض';
      case 'In-Progress':
        return 'قيد التطوير';
      case 'Pending':
        return 'قيد الانتظار';
      case 'Done':
        return 'منتهي';
      case 'Approved':
        return 'مقبول';
      default:
        return '';
    }
  }
}
