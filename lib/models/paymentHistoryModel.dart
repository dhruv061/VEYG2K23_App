//This class help full to store payment History
class PaymentHistory {
  String? userId;
  String? paymentId;
  String? amount;
  String? timeDate;
  String? playername;
  String? playeremail;
  String? playercollgename;
  String? playerenrollmentNo;

  PaymentHistory({
    this.userId,
    this.paymentId,
    this.amount,
    this.timeDate,
    this.playername,
    this.playeremail,
    this.playercollgename,
    this.playerenrollmentNo,
  });

  PaymentHistory.fromJson(Map<dynamic, dynamic> json) {
    userId = json['userId'];
    paymentId = json['paymentId'];
    amount = json['amount'];
    timeDate = json['timeDate'];
    playername = json['playername'];
    playeremail = json['playeremail'];
    playercollgename = json['playercollgename'];
    playerenrollmentNo = json['playerenrollmentNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['paymentId'] = this.paymentId;
    data['amount'] = this.amount;
    data['timeDate'] = this.timeDate;
    data['playername'] = this.playername;
    data['playeremail'] = this.playeremail;
    data['playercollgename'] = this.playercollgename;
    data['playerenrollmentNo'] = this.playerenrollmentNo;
    return data;
  }
}
