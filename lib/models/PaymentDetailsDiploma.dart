//This class help full to store payment History
class DiplomaPaymentDetails {
  String? userId;
  String? cuponCode;
  String? paymentStatus;
  String? amount;
  String? timeDate;
  String? GameProjectExpo;
  String? GamePosterTalk;
  String? GameTechnoSketch;
  String? GameSharkTank;
  String? GameGullyCricket;
  String? GameVadicMaths;
  String? GameOneMinuteGame;
  String? GameTechOModel;
  String? GameMultimediaPrse;
  String? playername;
  String? playeremail;
  String? playercollgename;
  String? playerenrollmentNo;

  DiplomaPaymentDetails({
    this.userId,
    this.cuponCode,
    this.paymentStatus,
    this.amount,
    this.timeDate,
    this.GameProjectExpo,
    this.GamePosterTalk,
    this.GameTechnoSketch,
    this.GameSharkTank,
    this.GameGullyCricket,
    this.GameVadicMaths,
    this.GameOneMinuteGame,
    this.GameTechOModel,
    this.GameMultimediaPrse,
    this.playername,
    this.playeremail,
    this.playercollgename,
    this.playerenrollmentNo,
  });

  DiplomaPaymentDetails.fromJson(Map<dynamic, dynamic> json) {
    userId = json['userId'];
    cuponCode = json['cuponCode'];
    paymentStatus = json['paymentStatus'];
    amount = json['amount'];
    timeDate = json['timeDate'];
    GameProjectExpo = json['GameProjectExpo'];
    GamePosterTalk = json['GamePosterTalk'];
    GameTechnoSketch = json['GameTechnoSketch'];
    GameSharkTank = json['GameSharkTank'];
    GameGullyCricket = json['GameGullyCricket'];
    GameVadicMaths = json['GameVadicMaths'];
    GameOneMinuteGame = json['GameOneMinuteGame'];
    GameTechOModel = json['GameTechOModel'];
    GameMultimediaPrse = json['GameMultimediaPrse'];
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
    data['GameProjectExpo'] = this.GameProjectExpo;
    data['GamePosterTalk'] = this.GamePosterTalk;
    data['GameTechnoSketch'] = this.GameTechnoSketch;
    data['GameSharkTank'] = this.GameSharkTank;
    data['GameGullyCricket'] = this.GameGullyCricket;
    data['GameVadicMaths'] = this.GameVadicMaths;
    data['GameOneMinuteGame'] = this.GameOneMinuteGame;
    data['GameTechOModel'] = this.GameTechOModel;
    data['GameMultimediaPrse'] = this.GameMultimediaPrse;
    data['playername'] = this.playername;
    data['playeremail'] = this.playeremail;
    data['playercollgename'] = this.playercollgename;
    data['playerenrollmentNo'] = this.playerenrollmentNo;
    return data;
  }
}
