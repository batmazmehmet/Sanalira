import 'package:flutter/material.dart';
import 'package:sanalira/model/bank_list_model.dart';
import 'package:sanalira/service/bank_list_service.dart';

class BankListProvider extends ChangeNotifier {
  bool loading = false;
  List<BankListModel>? bankListModel;
  

  getData() async {
    loading = true;
    bankListModel = await BankListService().getList()
        as List<BankListModel>;
    loading = false;
    notifyListeners();
    return bankListModel;
  }


}