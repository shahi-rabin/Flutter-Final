import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tripplanner/features/home/domain/entity/package_entity.dart';



Future<List<PackageEntity>> getAllPackages() async {
  final response = await rootBundle.loadString('test_data/package_test_data.json');
  final jsonList = await json.decode(response);

  final List<PackageEntity> movieList = jsonList
      .map<PackageEntity>(
        (json) => PackageEntity.fromJson(json),
      )
      .toList();

  print(movieList);
  return Future.value(movieList);
}

Future<List<PackageEntity>> getBookmarkedPackages() async {
  final response =
      await rootBundle.loadString('test_data/Bookmarked_Packages_data.json');
  final jsonList = await json.decode(response);

  final List<PackageEntity> Bookmarked = jsonList
      .map<PackageEntity>(
        (json) => PackageEntity.fromJson(json),
      )
      .toList();

  return Future.value(Bookmarked);
}

Future<List<PackageEntity>> getUserPackages() async {
  final response =
      await rootBundle.loadString('test_data/user_Packages_test.json');
  final jsonList = await json.decode(response);

  final List<PackageEntity> userPackages = jsonList
      .map<PackageEntity>(
        (json) => PackageEntity.fromJson(json),
      )
      .toList();

  return Future.value(userPackages);
}
