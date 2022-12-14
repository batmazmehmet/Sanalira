import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sanalira/config/config.dart';
import 'package:sanalira/model/bank_list_model.dart';

class BankListService with ChangeNotifier {
  Future<dynamic> getList() async {
    try {
      var response = await http.get(
        Uri.parse('${Config().connection}'),
        headers: Config().header,
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        List<BankListModel> getBankList = [];

        for (var element in data["data"]) {
          BankListModel getBanks = BankListModel.fromMap(element);
          getBankList.add(getBanks);
        }

        notifyListeners();
        return getBankList;
      } else {
        throw Exception('');
      }
    } catch (error) {
      print(error);
    }
    return null;
  }
}
