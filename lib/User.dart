import 'package:flutter/material.dart';

class User {
  String userName;
  String cardNumber;
  String experitionDay;
  String cv;

  int containerCapacity;
  int storageCapacity;

  int currentContainerCapacity;
  int currentStorageCapacity;
  List<int> lastSevenDays;
  User(
      {@required this.containerCapacity,
      @required this.storageCapacity,
      @required this.currentContainerCapacity,
      @required this.currentStorageCapacity,
      @required this.lastSevenDays});

  void printUser() {
    print(containerCapacity);
    print(storageCapacity);
    print(currentContainerCapacity);
    print(currentStorageCapacity);
  }
}
