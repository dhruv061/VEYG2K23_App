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
  bool? isScavengerHunt;

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

  //for ScavengerHunt
  String? ScavengerHuntUser1name;
  String? ScavengerHuntUser1email;
  String? ScavengerHuntUser1collegename;
  String? ScavengerHuntUser1enrollmentnO;
  String? ScavengerHuntUser1sem;
  String? ScavengerHuntUser1branch;
  String? ScavengerHuntUser1contactNo;
  String? ScavengerHuntUser2name;
  String? ScavengerHuntUser2email;
  String? ScavengerHuntUser2collegename;
  String? ScavengerHuntUser2enrollmentnO;
  String? ScavengerHuntUser2sem;
  String? ScavengerHuntUser2branch;
  String? ScavengerHuntUser2contactNo;
  String? ScavengerHuntUser3name;
  String? ScavengerHuntUser3email;
  String? ScavengerHuntUser3collegename;
  String? ScavengerHuntUser3enrollmentnO;
  String? ScavengerHuntUser3sem;
  String? ScavengerHuntUser3branch;
  String? ScavengerHuntUser3contactNo;

  //*******************************************************************************************************/

  //For Diploma Games
  //for check game
  bool? isGullyCricket;
  bool? isMultiMediaPrse;
  bool? isOneMinuteGame;
  bool? isPosterTalk;
  bool? isProjecExpo;
  bool? isSharkTank;
  bool? isTechnoSketch;
  bool? isTechOModel;
  bool? isVadicMaths;

  //for GullyCricket
  String? GullyCricketUser1name;
  String? GullyCricketUser1email;
  String? GullyCricketUser1collegename;
  String? GullyCricketUser1enrollmentnO;
  String? GullyCricketUser1sem;
  String? GullyCricketUser1branch;
  String? GullyCricketUser1contactNo;

  //for MultiMediaPrse
  String? MultiMediaPrseUser1name;
  String? MultiMediaPrseUser1email;
  String? MultiMediaPrseUser1collegename;
  String? MultiMediaPrseUser1enrollmentnO;
  String? MultiMediaPrseUser1sem;
  String? MultiMediaPrseUser1branch;
  String? MultiMediaPrseUser1contactNo;
  String? MultiMediaPrseUser2name;
  String? MultiMediaPrseUser2email;
  String? MultiMediaPrseUser2collegename;
  String? MultiMediaPrseUser2enrollmentnO;
  String? MultiMediaPrseUser2sem;
  String? MultiMediaPrseUser2branch;
  String? MultiMediaPrseUser2contactNo;

  //for OneMinuteGame
  String? OneMinuteGameUser1name;
  String? OneMinuteGameUser1email;
  String? OneMinuteGameUser1collegename;
  String? OneMinuteGameUser1enrollmentnO;
  String? OneMinuteGameUser1sem;
  String? OneMinuteGameUser1branch;
  String? OneMinuteGameUser1contactNo;

  //for PosterTalk
  String? PosterTalkUser1name;
  String? PosterTalkUser1email;
  String? PosterTalkUser1collegename;
  String? PosterTalkUser1enrollmentnO;
  String? PosterTalkUser1sem;
  String? PosterTalkUser1branch;
  String? PosterTalkUser1contactNo;

  //for ProjecExpo
  String? ProjecExpoUser1name;
  String? ProjecExpoUser1email;
  String? ProjecExpoUser1collegename;
  String? ProjecExpoUser1enrollmentnO;
  String? ProjecExpoUser1sem;
  String? ProjecExpoUser1branch;
  String? ProjecExpoUser1contactNo;
  String? ProjecExpoUser2name;
  String? ProjecExpoUser2email;
  String? ProjecExpoUser2collegename;
  String? ProjecExpoUser2enrollmentnO;
  String? ProjecExpoUser2sem;
  String? ProjecExpoUser2branch;
  String? ProjecExpoUser2contactNo;
  String? ProjecExpoUser3name;
  String? ProjecExpoUser3email;
  String? ProjecExpoUser3collegename;
  String? ProjecExpoUser3enrollmentnO;
  String? ProjecExpoUser3sem;
  String? ProjecExpoUser3branch;
  String? ProjecExpoUser3contactNo;
  String? ProjecExpoUser4name;
  String? ProjecExpoUser4email;
  String? ProjecExpoUser4collegename;
  String? ProjecExpoUser4enrollmentnO;
  String? ProjecExpoUser4sem;
  String? ProjecExpoUser4branch;
  String? ProjecExpoUser4contactNo;

  //for SharkTank
  String? SharkTankUser1name;
  String? SharkTankUser1email;
  String? SharkTankUser1collegename;
  String? SharkTankUser1enrollmentnO;
  String? SharkTankUser1sem;
  String? SharkTankUser1branch;
  String? SharkTankUser1contactNo;
  String? SharkTankUser2name;
  String? SharkTankUser2email;
  String? SharkTankUser2collegename;
  String? SharkTankUser2enrollmentnO;
  String? SharkTankUser2sem;
  String? SharkTankUser2branch;
  String? SharkTankUser2contactNo;

  //for TechnoSketch
  String? TechnoSketchUser1name;
  String? TechnoSketchUser1email;
  String? TechnoSketchUser1collegename;
  String? TechnoSketchUser1enrollmentnO;
  String? TechnoSketchUser1sem;
  String? TechnoSketchUser1branch;
  String? TechnoSketchUser1contactNo;

  //for TechOModel
  String? TechOModelUser1name;
  String? TechOModelUser1email;
  String? TechOModelUser1collegename;
  String? TechOModelUser1enrollmentnO;
  String? TechOModelUser1sem;
  String? TechOModelUser1branch;
  String? TechOModelUser1contactNo;
  String? TechOModelUser2name;
  String? TechOModelUser2email;
  String? TechOModelUser2collegename;
  String? TechOModelUser2enrollmentnO;
  String? TechOModelUser2sem;
  String? TechOModelUser2branch;
  String? TechOModelUser2contactNo;

  //for VadicMathss
  String? VadicMathsUser1name;
  String? VadicMathsUser1email;
  String? VadicMathsUser1collegename;
  String? VadicMathsUser1enrollmentnO;
  String? VadicMathsUser1sem;
  String? VadicMathsUser1branch;
  String? VadicMathsUser1contactNo;

  //*******************************************************************************************************/

  factory ParticipateData() {
    return _session;
  }

  ParticipateData._internal() {}
}
