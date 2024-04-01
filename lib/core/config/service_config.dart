class ServiceConfig {
  //https://cityway.boomuae.com/api/
  //http://192.168.1.106:8000/api/
  //192.168.172.20
  static const domainNameServer = 'https://cityway-reports.katbi.net/api/';
  static String baseUrl = 'https://cityway-reports.katbi.net/';

//! Auth
  static const signIn = 'login';
  static const register = 'register';

//! create report
  static const create = 'report';
  static const edit = 'report';
  static const complaintParty = 'complaint_party';
  static const getListReport = 'report';
  static const getListMaterial = 'material';
  static const getListDes = 'job_description';
  static const approval = 'report/approval';
  String getFullImageUrl(String? partialUrl) {
    Uri uri = Uri.parse(partialUrl!);
    return ServiceConfig.baseUrl + uri.path;
  }
}
