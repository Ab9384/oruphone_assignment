import 'dart:convert';

import 'package:assignment/functions/request_helpers.dart';
import 'package:assignment/model/device_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../model/search_response.dart';
import '../utils/app_provider.dart';
import '../utils/global_variable.dart';

class HelperMethods {
  // get filters api

  static Future<void> getFilters() async {
    // check if filters is empty
    if (filters.isEmpty) {
      // get filters from api
      var response = await RequestHelper.getRequest(
          'https://dev2be.oruphones.com/api/v1/global/assignment/getFilters?isLimited=true');
      // check if response is not failed
      if (response != 'failed') {
        // add filters to filters list
        filters = (response['filters']);
        var make = filters['make'];

        print('make: $make');
        print('filters: $filters');
      }
    }
  }

  static Future<void> getDeviceList(context) async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://dev2be.oruphones.com/api/v1/global/assignment/getListings?page=1&limit=20'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var decodedResponse = await response.stream.bytesToString();
      List<Device> devices = [];
      var data = jsonDecode(decodedResponse);
      var listings = data['listings'];
      for (var listing in listings) {
        devices.add(Device.fromJson(listing));
      }
      Provider.of<AppProvider>(context, listen: false).updateDevices(devices);
    } else {
      print(response.reasonPhrase);
    }
  }

  // search response api
  static Future<void> getSearchResponse(context, String query) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://dev2be.oruphones.com/api/v1/global/assignment/searchModel'));
    request.body = json.encode({"searchModel": query});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // Convert the stream to a single value (string)
      String decodedResponse = await response.stream.bytesToString();
      print(decodedResponse); // Print the response for debugging (optional)

      var data = jsonDecode(decodedResponse);
      Provider.of<AppProvider>(context, listen: false)
          .updateSearchResponse(SearchResponse.fromJson(data));
    } else {
      print(response.reasonPhrase);
    }
  }

  // format into indian rupee
  static String formatCurrency(String amount) {
    var format = NumberFormat.currency(locale: 'HI', symbol: '₹ ');
    return format.format(double.parse(amount)).split('.')[0];
  }

  // format 05/13/2021 to 13 May
  static String formatDate(String date) {
    var format = DateFormat('MM/dd/yyyy');
    var newDate = format.parse(date);
    var newFormat = DateFormat('dd MMM');
    return newFormat.format(newDate);
  }

  static void navigateTo(BuildContext context, Widget page, double offset) {
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return page;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(offset, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ));
  }
}
