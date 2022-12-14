// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BankListModel {
  String? bankName;
  String? bankIban;
  String? bankAccountName;
  String? descriptionNo;
  BankListModel({
    this.bankName,
    this.bankIban,
    this.bankAccountName,
    this.descriptionNo,
  });

  BankListModel copyWith({
    String? bankName,
    String? bankIban,
    String? bankAccountName,
    String? descriptionNo,
  }) {
    return BankListModel(
      bankName: bankName ?? this.bankName,
      bankIban: bankIban ?? this.bankIban,
      bankAccountName: bankAccountName ?? this.bankAccountName,
      descriptionNo: descriptionNo ?? this.descriptionNo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bankName': bankName,
      'bankIban': bankIban,
      'bankAccountName': bankAccountName,
      'descriptionNo': descriptionNo,
    };
  }

  factory BankListModel.fromMap(Map<String, dynamic> map) {
    return BankListModel(
      bankName: map['bankName'] != null ? map['bankName'] as String : null,
      bankIban: map['bankIban'] != null ? map['bankIban'] as String : null,
      bankAccountName: map['bankAccountName'] != null ? map['bankAccountName'] as String : null,
      descriptionNo: map['descriptionNo'] != null ? map['descriptionNo'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BankListModel.fromJson(String source) => BankListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BankListModel(bankName: $bankName, bankIban: $bankIban, bankAccountName: $bankAccountName, descriptionNo: $descriptionNo)';
  }

  @override
  bool operator ==(covariant BankListModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.bankName == bankName &&
      other.bankIban == bankIban &&
      other.bankAccountName == bankAccountName &&
      other.descriptionNo == descriptionNo;
  }

  @override
  int get hashCode {
    return bankName.hashCode ^
      bankIban.hashCode ^
      bankAccountName.hashCode ^
      descriptionNo.hashCode;
  }
}
