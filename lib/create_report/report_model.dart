// // To parse this JSON data, do
// //
// //     final report = reportFromJson(jsonString);

// import 'dart:convert';
// import 'dart:io';

// Report reportFromJson(String str) => Report.fromJson(json.decode(str));

// String reportToJson(Report data) => json.encode(data.toJson());

// class Report {
//   int status;
//   Data data;
//   String message;

//   Report({
//     required this.status,
//     required this.data,
//     required this.message,
//   });

//   factory Report.fromJson(Map<String, dynamic> json) => Report(
//         status: json["status"],
//         data: Data.fromJson(json["data"]),
//         message: json["message"],
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "data": data.toJson(),
//         "message": message,
//       };
// }

// class Data {
//   int? id;
//   int? userId;
//   String project;
//   String location;
//   int complaintPartyId;
//   String reportNumber;
//   DateTime? reportDate;
//   String contactName;
//   String contactPosition;
//   String contactNumber;
//   String? contactInfo;
//   DateTime? complaintDate;
//   String typeOfWork;
//   String? contractNumber;
//   DateTime? startingDateOfWork;
//   DateTime? finishingDateOfWork;
//   String? madeBy;
//   String? revisedBy;
//   int? fmeId;
//   DateTime? fmeDate;
//   int? estimationId;
//   DateTime? estimationDate;
//   String? acceptedBy;
//   String? client;
//   DateTime? clientDate;
//   String? clientNotes;
//   String? clientSignature;
//   String? clientSatisfaction;
//   String? notes;
//   String? statusClient;
//   String? statusAdmin;
//   String? uuid;
//   String? fmeSignature;
//   String? estimationSignature;
//   List<JobDescription> jobDescription;
//   String? fmeEmployee;
//   String? estimationEmployee;
//   ComplaintParty? complaintParty;

//   Data({
//     this.id,
//     this.userId,
//     required this.project,
//     required this.location,
//     required this.complaintPartyId,
//     required this.reportNumber,
//     this.reportDate,
//     required this.contactName,
//     required this.contactPosition,
//     required this.contactNumber,
//     this.contactInfo,
//     this.complaintDate,
//     required this.typeOfWork,
//     this.contractNumber,
//     this.startingDateOfWork,
//     this.finishingDateOfWork,
//     this.madeBy,
//     this.revisedBy,
//     this.fmeId,
//     this.fmeDate,
//     this.estimationId,
//     this.estimationDate,
//     this.acceptedBy,
//     this.client,
//     this.clientDate,
//     this.clientNotes,
//     this.clientSignature,
//     this.clientSatisfaction,
//     this.notes,
//     this.statusClient,
//     this.statusAdmin,
//     this.uuid,
//     this.fmeSignature,
//     this.estimationSignature,
//     required this.jobDescription,
//     this.fmeEmployee,
//     this.estimationEmployee,
//     this.complaintParty,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         id: json["id"],
//         userId: json["user_id"],
//         project: json["project"],
//         location: json["location"],
//         complaintPartyId: json["complaint_party_id"],
//         reportNumber: json["report_number"],
//         reportDate: DateTime.parse(json["report_date"]),
//         contactName: json["contact_name"],
//         contactPosition: json["contact_position"],
//         contactNumber: json["contact_number"],
//         contactInfo: json["contact_info"],
//         complaintDate: json["complaint_date"],
//         typeOfWork: json["type_of_work"],
//         contractNumber: json["contract_number"],
//         startingDateOfWork: json["starting_date_of_work"],
//         finishingDateOfWork: json["finishing_date_of_work"],
//         madeBy: json["made_by"],
//         revisedBy: json["revised_by"],
//         fmeId: json["fme_id"],
//         fmeDate: json["fme_date"],
//         estimationId: json["estimation_id"],
//         estimationDate: json["estimation_date"],
//         acceptedBy: json["accepted_by"],
//         client: json["client"],
//         clientDate: json["client_date"],
//         clientNotes: json["client_notes"],
//         clientSignature: json["client_signature"],
//         clientSatisfaction: json["client_satisfaction"],
//         notes: json["notes"],
//         statusClient: json["status_client"],
//         statusAdmin: json["status_admin"],
//         uuid: json["uuid"],
//         fmeSignature: json["fme_signature"],
//         estimationSignature: json["estimation_signature"],
//         jobDescription: List<JobDescription>.from(
//             json["job_description"].map((x) => JobDescription.fromJson(x))),
//         fmeEmployee: json["fme_employee"],
//         estimationEmployee: json["estimation_employee"],
//         complaintParty: ComplaintParty.fromJson(json["complaint_party"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_id": userId,
//         "project": project,
//         "location": location,
//         "complaint_party_id": complaintPartyId,
//         "report_number": reportNumber,
//         "report_date":
//             "${reportDate!.year.toString().padLeft(4, '0')}-${reportDate!.month.toString().padLeft(2, '0')}-${reportDate!.day.toString().padLeft(2, '0')}",
//         "contact_name": contactName,
//         "contact_position": contactPosition,
//         "contact_number": contactNumber,
//         "contact_info": contactInfo,
//         "complaint_date": complaintDate,
//         "type_of_work": typeOfWork,
//         "contract_number": contractNumber,
//         "starting_date_of_work": startingDateOfWork,
//         "finishing_date_of_work": finishingDateOfWork,
//         "made_by": madeBy,
//         "revised_by": revisedBy,
//         "fme_id": fmeId,
//         "fme_date": fmeDate,
//         "estimation_id": estimationId,
//         "estimation_date": estimationDate,
//         "accepted_by": acceptedBy,
//         "client": client,
//         "client_date": clientDate,
//         "client_notes": clientNotes,
//         "client_signature": clientSignature,
//         "client_satisfaction": clientSatisfaction,
//         "notes": notes,
//         "status_client": statusClient,
//         "status_admin": statusAdmin,
//         "uuid": uuid,
//         "fme_signature": fmeSignature,
//         "estimation_signature": estimationSignature,
//         "job_description":
//             List<dynamic>.from(jobDescription.map((x) => x.toJson())),
//         "fme_employee": fmeEmployee,
//         "estimation_employee": estimationEmployee,
//         "complaint_party": complaintParty!.toJson(),
//       };
// }

// class ComplaintParty {
//   int id;
//   String name;

//   ComplaintParty({
//     required this.id,
//     required this.name,
//   });

//   factory ComplaintParty.fromJson(Map<String, dynamic> json) => ComplaintParty(
//         id: json["id"],
//         name: json["name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//       };
// }

// JobDesc jobDescFromJson(String str) => JobDesc.fromJson(json.decode(str));

// String jobDescToJson(JobDesc data) => json.encode(data.toJson());

// class JobDesc {
//   List<JobDescription> jobDescription;

//   JobDesc({
//     required this.jobDescription,
//   });

//   factory JobDesc.fromJson(Map<String, dynamic> json) => JobDesc(
//         jobDescription: List<JobDescription>.from(
//             json["job_description"].map((x) => JobDescription.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "job_description":
//             List<dynamic>.from(jobDescription.map((x) => x.toJson())),
//       };
// }

// class JobDescription {
//   int? id;
//   int? reportId;
//   dynamic materialId;
//   String? description;
//   File? desImg;
//   File? afterDesImg;
//   int? price;
//   int? quantity;
//   dynamic material;

//   JobDescription({
//     this.id,
//     this.reportId,
//     this.materialId,
//     this.description,
//     this.desImg,
//     this.afterDesImg,
//     this.price,
//     this.quantity,
//     this.material,
//   });

//   factory JobDescription.fromJson(Map<String, dynamic> json) => JobDescription(
//         id: json["id"],
//         reportId: json["report_id"],
//         materialId: json["material_id"],
//         description: json["description"],
//         desImg: json["des_img"],
//         afterDesImg: json["after_des_img"],
//         price: json["price"],
//         quantity: json["quantity"],
//         material: json["material"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "report_id": reportId,
//         "material_id": materialId,
//         "description": description,
//         "des_img": desImg,
//         "after_des_img": afterDesImg,
//         "price": price,
//         "quantity": quantity,
//         "material": material,
//       };
// }

// To parse this JSON data, do
//
//     final report = reportFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

Report reportFromJson(String str) => Report.fromJson(json.decode(str));

String reportToJson(Report data) => json.encode(data.toJson());

class Report {
  int status;
  Data data;
  String message;

  Report({
    required this.status,
    required this.data,
    required this.message,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        status: json["status"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  int? id;
  String? qrCode;
  String? project;
  String? location;
  String? googleMapLocation;
  int? complaintPartyId;
  String? complaintNumber;
  DateTime? complaintDate;
  DateTime? reportDate;
  String? typeOfWork;
  int? contractNumber;
  DateTime? startingDateOfWork;
  DateTime? finishingDateOfWork;
  String? statusClient;
  String? statusAdmin;
  int? urgent;
  int? budget;
  String? complaintParty;
  List<ContactInfo>? contactInfo;
  List<dynamic>? reportJobDescription;
  List<ReportDescription> reportDescription;

  Data({
    this.id,
    this.qrCode,
    this.project,
    this.location,
    this.googleMapLocation,
    this.complaintPartyId,
    this.complaintNumber,
    this.complaintDate,
    this.reportDate,
    this.typeOfWork,
    this.contractNumber,
    this.startingDateOfWork,
    this.finishingDateOfWork,
    this.statusClient,
    this.statusAdmin,
    this.urgent,
    this.budget,
    this.complaintParty,
    this.contactInfo,
    this.reportJobDescription,
    required this.reportDescription,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        qrCode: json["qr_code"],
        project: json["project"],
        location: json["location"],
        googleMapLocation: json["google_map_location"],
        complaintPartyId: json["complaint_party_id"],
        complaintNumber: json["complaint_number"],
        complaintDate: DateTime.parse(json["complaint_date"]),
        reportDate: DateTime.parse(json["report_date"]),
        typeOfWork: json["type_of_work"],
        contractNumber: json["contract_number"],
        startingDateOfWork: json["starting_date_of_work"],
        finishingDateOfWork: json["finishing_date_of_work"],
        statusClient: json["status_client"],
        statusAdmin: json["status_admin"],
        urgent: json["urgent"],
        budget: json["budget"],
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
            "${complaintDate?.year.toString().padLeft(4, '0')}-${complaintDate?.month.toString().padLeft(2, '0')}-${complaintDate?.day.toString().padLeft(2, '0')}",
        "report_date":
            "${reportDate?.year.toString().padLeft(4, '0')}-${reportDate?.month.toString().padLeft(2, '0')}-${reportDate?.day.toString().padLeft(2, '0')}",
        "type_of_work": typeOfWork,
        "contract_number": contractNumber,
        "starting_date_of_work": startingDateOfWork,
        "finishing_date_of_work": finishingDateOfWork,
        "status_client": statusClient,
        "status_admin": statusAdmin,
        "urgent": urgent,
        "budget": budget,
        "complaint_party": complaintParty,
        "contact_info": List<dynamic>.from(contactInfo!.map((x) => x.toJson())),
        "report_job_description":
            List<dynamic>.from(reportJobDescription!.map((x) => x)),
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
  int? id;
  int? reportId;
  String? description;
  String? note;
  File? desImg;

  ReportDescription({
    this.id,
    this.reportId,
    this.description,
    this.note,
    this.desImg,
  });

  factory ReportDescription.fromJson(Map<String, dynamic> json) =>
      ReportDescription(
        id: json["id"],
        reportId: json["report_id"],
        description: json["description"],
        note: json["note"],
        desImg: json["des_img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "report_id": reportId,
        "description": description,
        "note": note,
        "des_img": desImg,
      };
}
