import 'package:assignment/model/search_response.dart';
import 'package:flutter/material.dart';

import '../model/device_model.dart';

class AppProvider extends ChangeNotifier {
  String make = 'All';
  String condition = 'All';
  String warranty = 'All';
  String storage = 'All';
  String ram = 'All';
  String verification = 'All';
  int minPrice = 0;
  int maxPrice = 40000;
  List<Device> devices = [];
  SearchResponse? searchResponse;

  void changeMake(String newMake) {
    make = newMake;
    notifyListeners();
  }

  void changeCondition(String newCondition) {
    condition = newCondition;
    notifyListeners();
  }

  void changeWarranty(String newWarranty) {
    warranty = newWarranty;
    notifyListeners();
  }

  void changeStorage(String newStorage) {
    storage = newStorage;
    notifyListeners();
  }

  void changeRam(String newRam) {
    ram = newRam;
    notifyListeners();
  }

  void changeVerification(String newVerification) {
    verification = newVerification;
    notifyListeners();
  }

  void changeMinPrice(int newMinPrice) {
    minPrice = newMinPrice;
    notifyListeners();
  }

  void changeMaxPrice(int newMaxPrice) {
    maxPrice = newMaxPrice;
    notifyListeners();
  }

  void updateDevices(List<Device> newDevices) {
    devices = newDevices;
    notifyListeners();
  }

  void updateSearchResponse(SearchResponse? newSearchResponse) {
    searchResponse = newSearchResponse;
    notifyListeners();
  }

  void resetFilters() {
    make = 'All';
    condition = 'All';
    warranty = 'All';
    storage = 'All';
    ram = 'All';
    verification = 'All';
    minPrice = 0;
    maxPrice = 40000;
    notifyListeners();
  }
}
