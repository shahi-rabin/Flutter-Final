import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../../config/constants/hive_table_constants.dart';
import '../../../features/home/data/model/home_hive_model.dart';

final hiveServiceProvider = Provider<HiveService>((ref) => HiveService());

class HiveService {
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    // Register Adapters
    // Hive.registerAdapter(AuthHiveModelAdapter());
    Hive.registerAdapter(PackagehomeHiveModelAdapter());

    await addDummyPackage();
  }

  Future<void> addPackage(PackagehomeHiveModel package) async {
    var box = await Hive.openBox<PackagehomeHiveModel>(HiveTableConstant.packageBox);
    await box.put(package.packageId, package);
  }

  Future<List<PackagehomeHiveModel>> getAllPackages() async {
    var box = await Hive.openBox<PackagehomeHiveModel>(HiveTableConstant.packageBox);
    var packages = box.values.toList();
    box.close();
    return packages;
  }

  // get packagemarked packages
  Future<List<PackagehomeHiveModel>> getBookmarkedPackages() async {
    var box = await Hive.openBox<PackagehomeHiveModel>(HiveTableConstant.packageBox);
    var packages = box.values.toList();
    box.close();
    return packages;
  }

  // get user packages
  Future<List<PackagehomeHiveModel>> getUserPackages() async {
    var box = await Hive.openBox<PackagehomeHiveModel>(HiveTableConstant.packageBox);
    var packages = box.values.toList();
    box.close();
    return packages;
  }

  // ======================== Close Hive ========================
  Future<void> closeHive() async {
    await Hive.close();
  }

  // ======================== Delete Hive ========================
  Future<void> deleteHive() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
    await Hive.deleteFromDisk();
  }

  Future<void> addDummyPackage() async {
    var box = await Hive.openBox<PackagehomeHiveModel>(HiveTableConstant.packageBox);
    if (box.isEmpty) {
      final package1 = PackagehomeHiveModel(
        packageName: 
            'The Catcher in the Rye',
        packagePlan: 'J.D. Salinger',
        packageDescription:
            'The Catcher in the Rye is a novel by J. D. Salinger, partially published in serial form in 1945–1946 and as a novel in 1951. It was originally intended for adults, but is often read by adolescents for its themes of angst and alienation, and as a critique on superficiality in society.',
        location: 'Novel',
        price: 3,
        remaining: 5,
        route: 'English',
        packageCover:
            'https://images-na.ssl-images-amazon.com/images/I/81h2gWPTYJL.jpg',
        packageTime: '1951',
        

      );

      final package2 = PackagehomeHiveModel(
        packageName: 
            'The Catcher in the Rye',
        packagePlan: 'J.D. Salinger',
        packageDescription:
            'The Catcher in the Rye is a novel by J. D. Salinger, partially published in serial form in 1945–1946 and as a novel in 1951. It was originally intended for adults, but is often read by adolescents for its themes of angst and alienation, and as a critique on superficiality in society.',
        location: 'Novel',
        price: 3,
        remaining: 5,
        route: 'English',
        packageCover:
            'https://images-na.ssl-images-amazon.com/images/I/81h2gWPTYJL.jpg',
        packageTime: '1951',
      );

      List<PackagehomeHiveModel> packages = [package1, package2];

      for (var package in packages) {
        await addPackage(package);
      }
    }
  }
}
