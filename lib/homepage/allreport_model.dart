import 'dart:convert';

Allreports allreportsFromJson(String str) =>
    Allreports.fromJson(json.decode(str));

String allreportsToJson(Allreports data) => json.encode(data.toJson());

class Allreports {
  int status;
  List<DataAllReport> data;
  String message;

  Allreports({
    required this.status,
    required this.data,
    required this.message,
  });

  factory Allreports.fromJson(Map<String, dynamic> json) => Allreports(
        status: json["status"],
        data: List<DataAllReport>.from(
            json["data"].map((x) => DataAllReport.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class DataAllReport {
  int id;
  String qrCode;
  String project;
  String location;
  String googleMapLocation;
  int complaintPartyId;
  String complaintNumber;
  DateTime complaintDate;
  DateTime reportDate;
  String typeOfWork;
  int contractNumber;
  dynamic startingDateOfWork;
  dynamic finishingDateOfWork;
  String statusClient;
  String statusAdmin;
  int urgent;
  int budget;
  DateTime createdAt;
  DateTime updatedAt;
  String complaintParty;
  List<ContactInfo> contactInfo;
  List<dynamic> reportJobDescription;
  List<ReportDescription> reportDescription;

  DataAllReport({
    required this.id,
    required this.qrCode,
    required this.project,
    required this.location,
    required this.googleMapLocation,
    required this.complaintPartyId,
    required this.complaintNumber,
    required this.complaintDate,
    required this.reportDate,
    required this.typeOfWork,
    required this.contractNumber,
    required this.startingDateOfWork,
    required this.finishingDateOfWork,
    required this.statusClient,
    required this.statusAdmin,
    required this.urgent,
    required this.budget,
    required this.createdAt,
    required this.updatedAt,
    required this.complaintParty,
    required this.contactInfo,
    required this.reportJobDescription,
    required this.reportDescription,
  });

  factory DataAllReport.fromJson(Map<String, dynamic> json) => DataAllReport(
        id: json["id"],
        qrCode: json["qr_code"],
        project: json["project"],
        location: json["location"],
        googleMapLocation: json["google_map_location"],
        complaintPartyId: json["complaint_party_id"],
        complaintNumber: json["complaint_number"],
        complaintDate: DateTime.parse(json["complaint_date"]),
        reportDate:
            DateTime.parse(json["report_date"] ?? DateTime.now().toString()),
        typeOfWork: json["type_of_work"],
        contractNumber:
            int.tryParse(json["contract_number"]?.toString() ?? '0') ?? 0,
        startingDateOfWork: json["starting_date_of_work"],
        finishingDateOfWork: json["finishing_date_of_work"],
        statusClient: json["status_client"],
        statusAdmin: json["status_admin"],
        urgent: json["urgent"],
        budget: json["budget"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        complaintParty: json["complaint_party"],
        contactInfo: List<ContactInfo>.from(
            json["contact_info"].map((x) => ContactInfo.fromJson(x))),
        reportJobDescription:
            List<dynamic>.from(json["report_job_description"].map((x) => x)),
        reportDescription: List<ReportDescription>.from(
            json["report_description"]
                .map((x) => ReportDescription.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "qr_code": qrCode,
        "project": project,
        "location": location,
        "google_map_location": googleMapLocation,
        "complaint_party_id": complaintPartyId,
        "complaint_number": complaintNumber,
        "complaint_date":
            "${complaintDate.year.toString().padLeft(4, '0')}-${complaintDate.month.toString().padLeft(2, '0')}-${complaintDate.day.toString().padLeft(2, '0')}",
        "report_date":
            "${reportDate.year.toString().padLeft(4, '0')}-${reportDate.month.toString().padLeft(2, '0')}-${reportDate.day.toString().padLeft(2, '0')}",
        "type_of_work": typeOfWork,
        "contract_number": contractNumber,
        "starting_date_of_work": startingDateOfWork,
        "finishing_date_of_work": finishingDateOfWork,
        "status_client": statusClient,
        "status_admin": statusAdmin,
        "urgent": urgent,
        "budget": budget,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "complaint_party": complaintParty,
        "contact_info": List<dynamic>.from(contactInfo.map((x) => x.toJson())),
        "report_job_description":
            List<dynamic>.from(reportJobDescription.map((x) => x)),
        "report_description":
            List<dynamic>.from(reportDescription.map((x) => x.toJson())),
      };
}

class ContactInfo {
  int? id;
  String? name;
  String? position;
  String? phone;
  String? financialNumber;
  Pivot? pivot;

  ContactInfo({
    this.id,
    this.name,
    this.position,
    this.phone,
    this.financialNumber,
    this.pivot,
  });

  factory ContactInfo.fromJson(Map<String, dynamic> json) => ContactInfo(
        id: json["id"],
        name: json["name"],
        position: json["position"],
        phone: json["phone"],
        financialNumber: json["financial_number"],
        pivot: Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "position": position,
        "phone": phone,
        "financial_number": financialNumber,
        "pivot": pivot!.toJson(),
      };
}

class Pivot {
  int reportId;
  int contactInfoId;
  int id;

  Pivot({
    required this.reportId,
    required this.contactInfoId,
    required this.id,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        reportId: json["report_id"],
        contactInfoId: json["contact_info_id"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "report_id": reportId,
        "contact_info_id": contactInfoId,
        "id": id,
      };
}

class ReportDescription {
  int id;
  int reportId;
  String description;
  dynamic note;
  String desImg;
  DateTime createdAt;
  DateTime updatedAt;

  ReportDescription({
    required this.id,
    required this.reportId,
    required this.description,
    required this.note,
    required this.desImg,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReportDescription.fromJson(Map<String, dynamic> json) =>
      ReportDescription(
        id: json["id"],
        reportId: json["report_id"],
        description: json["description"],
        note: json["note"],
        desImg: json["des_img"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "report_id": reportId,
        "description": description,
        "note": note,
        "des_img": desImg,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
