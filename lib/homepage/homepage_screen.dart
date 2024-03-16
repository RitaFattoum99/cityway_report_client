import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/homepage/reoport_list_controller.dart';
import '/homepage/allreport_model.dart';
import '/core/resource/color_manager.dart';

class TabBarWithListView extends StatelessWidget {
  TabBarWithListView({Key? key}) : super(key: key);

  final ReportListController controller = Get.put(ReportListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التقاريـر'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: controller.reportList.length,
            itemBuilder: (context, index) {
              DataAllReport report = controller.reportList[index];
              Color statusColor = _getStatusColor(report.statusClient!);
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
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
                      ),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("اسم المشروع: ${report.project}",
                                style: const TextStyle(
                                  color: AppColorManger.secondaryAppColor,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text("موقع المشروع: ${report.location}",
                                style: const TextStyle(
                                  color: AppColorManger.secondaryAppColor,
                                )),
                          ],
                        ),
                        subtitle: Text("حالة المشروع: ${report.statusClient}",
                            style: TextStyle(
                              color: statusColor,
                              fontWeight: FontWeight.w500,
                            )),
                        leading: Icon(Icons.stacked_bar_chart,
                            color: statusColor, size: 25),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Get.toNamed('create');
          var result = await Get.toNamed(
              'create'); // Assuming this route returns 'true' when a report is successfully created.
          if (result == true) {
            controller
                .fetchReports(); // Refresh reports only if a new report was added
          }
        },
        backgroundColor: AppColorManger.mainAppColor,
        child: const Icon(Icons.add, color: AppColorManger.white),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Complete':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      case 'In-Progress':
        return Colors.blue;
      case 'Pending':
        return Colors.grey;
      case 'Done':
        return Colors.yellow[700]!;
      default:
        return Colors.purple;
    }
  }
}
