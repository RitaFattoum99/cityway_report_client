// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../core/native_service/secure_storage.dart';
import '../homepage/reoport_list_controller.dart';
import '/core/resource/color_manager.dart';
import '/core/resource/size_manager.dart';
import '/create_report/report_controller.dart';

class CreateReport extends StatefulWidget {
  const CreateReport({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CreateReportState createState() => _CreateReportState();
}

class _CreateReportState extends State<CreateReport> {
  final ReportController reportController = Get.put(ReportController());
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final storage = SecureStorage();
  // Placeholder for user name
  String userName = "";
  final TextEditingController _projectController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _reportNumController = TextEditingController();
  final TextEditingController _administratorController =
      TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  // String? _selectedReportType;
  final List<String> _selectedWorkTypes = [];
  List<Map<String, dynamic>> data = [
    {
      'description': TextEditingController(),
      'descriptionImage': null,
    },
  ];

  @override
  void initState() {
    super.initState();
    // Fetch user name on widget initialization
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    // Fetch user name using the key
    String? name = await storage.read("username");
    if (name != null) {
      setState(() {
        userName = name; // Set the user name if found
        print("username in creste screen: $userName");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppPaddingManager.p60,
            horizontal: AppPaddingManager.p12,
          ),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(size),
                const SizedBox(height: 10),
                _buildTextField(_projectController, 'اسم المشروع',
                    'ادخل اسم المشروع', Icons.file_copy, 'اسم المشروع مطلوب'),
                const SizedBox(height: 16),
                _buildLocationAndReportNumberFields(),
                // _buildDropdown(),
                const SizedBox(height: 16),
                _complainant(userName),
                const SizedBox(height: 16),
                _buildAdministratorAndPositionields(),
                const SizedBox(height: 16),
                _buildTextField(_numberController, 'رقم المسؤول',
                    'ادخل رقم المسؤول', Icons.phone, 'رقم المسؤول مطلوب'),
                const SizedBox(height: 16),
                buildWorkTypeCheckboxes(),
                const SizedBox(height: 16),
                const Text(
                  "وصف البلاغ",
                  style: TextStyle(
                      color: AppColorManager.mainAppColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                _buildDynamicDescriptionList(),
                const SizedBox(height: 16),
                _buildAddDescriptionButton(),
                const SizedBox(height: 16),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Size size) {
    return Center(
      child: SizedBox(
        height: size.height * 0.1,
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      String hint, IconData icon, String validationMessage) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle:
            const TextStyle(color: AppColorManager.greyAppColor, fontSize: 12),
        hintText: hint,
        hintStyle:
            const TextStyle(color: AppColorManager.greyAppColor, fontSize: 10),
        prefixIcon: Icon(icon, color: AppColorManager.mainAppColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.all(12),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return validationMessage;
        return null;
      },
    );
  }

  Widget _buildLocationAndReportNumberFields() {
    return Row(
      children: [
        Expanded(
          child: _buildTextField(_locationController, 'موقع المشروع',
              'ادخل موقع المشروع', Icons.location_on, 'موقع المشروع مطلوب'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildTextField(_reportNumController, 'رقم البلاغ',
              'ادخل رقم البلاغ', Icons.numbers, 'رقم البلاغ مطلوب'),
        ),
      ],
    );
  }

  Widget _buildAdministratorAndPositionields() {
    return Row(
      children: [
        Expanded(
          child: _buildTextField(_administratorController, 'اسم المسؤول',
              'ادخل اسم المسؤول', Icons.person_2_rounded, 'اسم المسؤول مطلوب'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildTextField(
              _positionController,
              'منصب المسؤول',
              'ادخل منصب المسؤول',
              Icons.person_2_rounded,
              'منصب المسؤول مطلوب'),
        ),
      ],
    );
  }

  Widget buildWorkTypeCheckboxes() {
    final List<FormBuilderFieldOption<String>> options = [
      const FormBuilderFieldOption(value: 'میكانیـك', child: Text('میكانیـك')),
      const FormBuilderFieldOption(
          value: 'تھویة وتبرید', child: Text('تھویة وتبرید')),
      const FormBuilderFieldOption(
          value: 'أعمال مدنیـة', child: Text('أعمال مدنیـة')),
      const FormBuilderFieldOption(value: 'كھرباء', child: Text('كھرباء')),
      const FormBuilderFieldOption(
          value: 'تمدیدات صحية', child: Text('تمدیدات صحية')),
      const FormBuilderFieldOption(
          value: 'أعمال أخرى', child: Text('أعمال أخرى')),
    ];

    return FormBuilderCheckboxGroup<String>(
      name: 'work_types',
      decoration: InputDecoration(
        labelText: 'نوع العمل',
        labelStyle: const TextStyle(color: AppColorManager.greyAppColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
      options: options,
      onChanged: (List<String>? newValues) {
        setState(() {
          _selectedWorkTypes.clear();
          if (newValues != null) {
            _selectedWorkTypes.addAll(newValues);
          }
        });
      },
    );
  }

  Widget _buildDynamicDescriptionList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return _buildDescriptionRow(index);
      },
    );
  }

  Widget _buildDescriptionRow(int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: data[index]['description'],
              decoration: InputDecoration(labelText: 'وصف البلاغ ${index + 1}'),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildImagePreview(index),
                IconButton(
                  icon: const Icon(
                    Icons.remove_circle_outline,
                    color: AppColorManager.mainAppColor,
                  ),
                  onPressed: () => _removeDescriptionRow(index),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Add new method to build the Add Card button
  Widget _buildAddDescriptionButton() {
    return GestureDetector(
      onTap: _addDescriptionRow,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green,
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildImagePreview(int index) {
    return GestureDetector(
      onTap: () => _pickImage(index),
      child: data[index]['descriptionImage'] != null
          ? Image.file(
              data[index]['descriptionImage'],
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            )
          : const SizedBox(
              width: 150,
              height: 150,
              child: Icon(Icons.add_a_photo, size: 50),
            ),
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _submitReport,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColorManager.mainAppColor,
        ),
        child:
            const Text('إرسال', style: TextStyle(color: AppColorManager.white)),
      ),
    );
  }

  void _submitReport() async {
    print("إرسال");
    for (int i = 0; i < data.length; i++) {
      print("description in data: ${data[i]['description']}");
      reportController.reportDescription[i].description = data[i]['description'];
      print("description: ${reportController.reportDescription[i].description}");
    }

    EasyLoading.show(status: 'loading...', dismissOnTap: true);
    await reportController.create();
    if (reportController.createStatus) {
      EasyLoading.showSuccess(reportController.message,
          duration: const Duration(seconds: 2));
      final reportListController = Get.find<ReportListController>();
      reportListController.fetchReports();

      Get.offNamed('home');
    } else {
      EasyLoading.showError(reportController.message);
      print("error create report");
    }
  }

  Future<void> _pickImage(int index) async {
    final ImageSource? source = await _getImageSource();
    if (source == null) return;

    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        data[index]['descriptionImage'] = File(image.path);
      });
    }
  }

  Future<ImageSource?> _getImageSource() async {
    return await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("اختر مصدر الصورة"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(ImageSource.camera),
            child: const Text("الكاميرا"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
            child: const Text("المعرض"),
          ),
        ],
      ),
    );
  }

  void _addDescriptionRow() {
    setState(() {
      data.add(
          {'description': TextEditingController(), 'descriptionImage': null});
    });
  }

  void _removeDescriptionRow(int index) {
    setState(() {
      if (data.length > 1) {
        data.removeAt(index);
      }
    });
  }
}

Widget _complainant(String userName) {
  return Padding(
    padding: const EdgeInsets.only(right: 8.0),
    child: Text(
      "مقدم البلاغ: $userName",
      style: const TextStyle(
          color: AppColorManager.secondaryAppColor, fontSize: 16),
    ),
  );
}
