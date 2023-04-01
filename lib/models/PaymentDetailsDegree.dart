//This class help full to store payment History
class DegreePaymentDetails {
  String? userId;
  String? cuponCode;
  String? paymentStatus;
  String? amount;
  String? timeDate;
  String? GameTalaash;
  String? GameTechTainment;
  String? GameTheCivilSafari;
  String? GameDekathon;
  String? GameOfficeTennis;
  String? GameScavengerHunt;
  String? playername;
  String? playeremail;
  String? playercollgename;
  String? playerenrollmentNo;

  DegreePaymentDetails({
    this.userId,
    this.cuponCode,
    this.paymentStatus,
    this.amount,
    this.timeDate,
    this.GameTalaash,
    this.GameTechTainment,
    this.GameTheCivilSafari,
    this.GameDekathon,
    this.GameOfficeTennis,
    this.GameScavengerHunt,
    this.playername,
    this.playeremail,
    this.playercollgename,
    this.playerenrollmentNo,
  });

  DegreePaymentDetails.fromJson(Map<dynamic, dynamic> json) {
    userId = json['userId'];
    cuponCode = json['cuponCode'];
    paymentStatus = json['paymentStatus'];
    amount = json['amount'];
    timeDate = json['timeDate'];
    GameTalaash = json['GameTalaash'];
    GameTechTainment = json['GameTechTainment'];
    GameTheCivilSafari = json['GameTheCivilSafari'];
    GameDekathon = json['GameDekathon'];
    GameOfficeTennis = json['GameOfficeTennis'];
    GameScavengerHunt = json['GameScavengerHunt'];
    playername = json['playername'];
    playeremail = json['playeremail'];
    playercollgename = json['playercollgename'];
    playerenrollmentNo = json['playerenrollmentNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['cuponCode'] = this.cuponCode;
    data['paymentStatus'] = this.paymentStatus;
    data['amount'] = this.amount;
    data['timeDate'] = this.timeDate;
    data['GameTalaash'] = this.GameTalaash;
    data['GameTechTainment'] = this.GameTechTainment;
    data['GameTheCivilSafari'] = this.GameTheCivilSafari;
    data['GameDekathon'] = this.GameDekathon;
    data['GameOfficeTennis'] = this.GameOfficeTennis;
    data['GameScavengerHunt'] = this.GameScavengerHunt;
    data['playername'] = this.playername;
    data['playeremail'] = this.playeremail;
    data['playercollgename'] = this.playercollgename;
    data['playerenrollmentNo'] = this.playerenrollmentNo;
    return data;
  }
}
