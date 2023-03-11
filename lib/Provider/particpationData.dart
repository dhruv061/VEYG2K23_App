//in this class we store participation data for temporary

class ParticipateData {
  //this  _instance use beacuse we can easily access the UserData class data in every page
  static final ParticipateData _session = ParticipateData._internal();

  //Total games added in cart --> this help full in check out pages
  int totalGame = 0;

  //for check game
  bool? isTechTainment;
  bool? isTalaash;
  bool? isTheCivilSafari;
  bool? isDekathon;
  bool? isOfficeTennis;

  //partcipation details game vise
  //for talassh
  String? talaashUser1name;
  String? talaashUser1email;
  String? talaashUser1collegename;
  String? talaashUser1enrollmentnO;
  String? talaashUser1sem;
  String? talaashUser1branch;
  String? talaashUser1contactNo;
  String? talaashUser2name;
  String? talaashUser2email;
  String? talaashUser2collegename;
  String? talaashUser2enrollmentnO;
  String? talaashUser2sem;
  String? talaashUser2branch;
  String? talaashUser2contactNo;

  //for Tech Tainment
  String? techTainmentUser1name;
  String? techTainmentUser1email;
  String? techTainmentUser1collegename;
  String? techTainmentUser1enrollmentnO;
  String? techTainmentUser1sem;
  String? techTainmentUser1branch;
  String? techTainmentUser1contactNo;
  String? techTainmentUser2name;
  String? techTainmentUser2email;
  String? techTainmentUser2collegename;
  String? techTainmentUser2enrollmentnO;
  String? techTainmentUser2sem;
  String? techTainmentUser2branch;
  String? techTainmentUser2contactNo;
  String? techTainmentUser3name;
  String? techTainmentUser3email;
  String? techTainmentUser3collegename;
  String? techTainmentUser3enrollmentnO;
  String? techTainmentUser3sem;
  String? techTainmentUser3branch;
  String? techTainmentUser3contactNo;

  //for Dekathon
  String? DekathonUser1name;
  String? DekathonUser1email;
  String? DekathonUser1collegename;
  String? DekathonUser1enrollmentnO;
  String? DekathonUser1sem;
  String? DekathonUser1branch;
  String? DekathonUser1contactNo;
  String? DekathonUser2name;
  String? DekathonUser2email;
  String? DekathonUser2collegename;
  String? DekathonUser2enrollmentnO;
  String? DekathonUser2sem;
  String? DekathonUser2branch;
  String? DekathonUser2contactNo;
  String? DekathonUser3name;
  String? DekathontUser3email;
  String? DekathonUser3collegename;
  String? DekathonUser3enrollmentnO;
  String? DekathonUser3sem;
  String? DekathonUser3branch;
  String? DekathonUser3contactNo;
  String? DekathonUser4name;
  String? DekathontUser4email;
  String? DekathonUser4collegename;
  String? DekathonUser4enrollmentnO;
  String? DekathonUser4sem;
  String? DekathonUser4branch;
  String? DekathonUser4contactNo;

  //for OfficeTennis
  String? OfficeTennisUser1name;
  String? OfficeTennisUser1email;
  String? OfficeTennisUser1collegename;
  String? OfficeTennisUser1enrollmentnO;
  String? OfficeTennisUser1sem;
  String? OfficeTennisUser1branch;
  String? OfficeTennisUser1contactNo;
  String? OfficeTennisUser2name;
  String? OfficeTennisUser2email;
  String? OfficeTennisUser2collegename;
  String? OfficeTennisUser2enrollmentnO;
  String? OfficeTennisUser2sem;
  String? OfficeTennisUser2branch;
  String? OfficeTennisUser2contactNo;

  //TheCivilSafari
  String? TheCivilSafariUser1name;
  String? TheCivilSafariUser1email;
  String? TheCivilSafariUser1collegename;
  String? TheCivilSafariUser1enrollmentnO;
  String? TheCivilSafariUser1sem;
  String? TheCivilSafariUser1branch;
  String? TheCivilSafariUser1contactNo;
  String? TheCivilSafariUser2name;
  String? TheCivilSafariUser2email;
  String? TheCivilSafariUser2collegename;
  String? TheCivilSafariUser2enrollmentnO;
  String? TheCivilSafariUser2sem;
  String? TheCivilSafariUser2branch;
  String? TheCivilSafariUser2contactNo;
  String? TheCivilSafariUser3name;
  String? TheCivilSafariUser3email;
  String? TheCivilSafariUser3collegename;
  String? TheCivilSafariUser3enrollmentnO;
  String? TheCivilSafariUser3sem;
  String? TheCivilSafariUser3branch;
  String? TheCivilSafariUser3contactNo;

  factory ParticipateData() {
    return _session;
  }

  ParticipateData._internal() {}
}
