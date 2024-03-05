import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tripplanner/features/home/domain/entity/package_entity.dart';
import 'package:tripplanner/features/home/presentation/viewmodel/home_view_model.dart';

import '../../../../core/common/snackbar/my_snackbar.dart';

class AddPackageView extends ConsumerStatefulWidget {
  const AddPackageView({super.key});

  @override
  ConsumerState<AddPackageView> createState() => _AddPackageViewState();
}

class _AddPackageViewState extends ConsumerState<AddPackageView> {
  late TextEditingController _packageNameController;
  late TextEditingController _packageTimeController;
  late TextEditingController _destinationController;
  late TextEditingController _PackageDescriptionController;
  late TextEditingController _locationController;
  late TextEditingController _priceController;
  late TextEditingController _remainingController;
  late TextEditingController _routeController;
  late TextEditingController _packagePlanController;

  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
  Future _browseImage(WidgetRef ref, ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          ref.read(homeViewModelProvider.notifier).uploadPackageCover(_img!);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _destinationController = TextEditingController();
    _packageNameController = TextEditingController();
    _packageTimeController = TextEditingController();
    _locationController = TextEditingController();
    _priceController = TextEditingController();
    _PackageDescriptionController = TextEditingController();
    _routeController = TextEditingController();
    _packagePlanController = TextEditingController();
    _remainingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Package'),
      ),
      backgroundColor: const Color.fromARGB(255, 78, 92, 101),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Package Cover',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 8.0),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: const Color.fromARGB(255, 108, 128, 142),
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (context) => Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              _browseImage(ref, ImageSource.camera);
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.camera),
                            label: const Text('Camera'),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              _browseImage(ref, ImageSource.gallery);
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.image),
                            label: const Text('Gallery'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 200,
                  // width: 200,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 108, 128, 142),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: _img != null
                        ? Image.file(
                            _img!,
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          )
                        : const Icon(
                            Icons.add_photo_alternate,
                            size: 50,
                            color: Colors.grey,
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Title',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _packageNameController,
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter packageName';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 108, 128, 142),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Location',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _locationController,
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter location';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 108, 128, 142),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Price',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _priceController,
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 108, 128, 142),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Destination',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _destinationController,
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter destination';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 108, 128, 142),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Remaining',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _remainingController,
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter remaining';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 108, 128, 142),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0,
                  ),
                ),
              ),
              const Text(
                'Time',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _packageTimeController,
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter packageTime';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 108, 128, 142),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Description',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _PackageDescriptionController,
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter PackageDescription';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 108, 128, 142),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Route',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _routeController,
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter route';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 108, 128, 142),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Package Plan',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _packagePlanController,
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter packagePlan';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 108, 128, 142),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_packageNameController.text.isEmpty ||
                        _packageTimeController.text.isEmpty ||
                        _PackageDescriptionController.text.isEmpty ||
                        _locationController.text.isEmpty ||
                        _routeController.text.isEmpty ||
                        _priceController.text.isEmpty ||
                        _destinationController.text.isEmpty ||
                        _remainingController.text.isEmpty ||
                        _packagePlanController.text.isEmpty) {
                      showSnackBar(
                        context: context,
                        message: 'Please fill all fields',
                        color: Colors.red,
                      );
                    } else if (_img == null) {
                      showSnackBar(
                        context: context,
                        message: 'Please select package cover',
                        color: Colors.red,
                      );
                    } else {
                      final packageName = _packageNameController.text;
                      final packageTime = _packageTimeController.text;
                      final PackageDescription =
                          _PackageDescriptionController.text;
                      final route = _routeController.text;
                      final location = _locationController.text;
                      final price = int.parse(_priceController.text);
                      final remaining = int.parse(_remainingController.text);
                      final destination = _destinationController.text;
                      final packagePlan = _packagePlanController.text;

                      PackageEntity package = PackageEntity(
                        packageName: packageName,
                        packageTime: packageTime,
                        packageDescription: PackageDescription,
                        route: route,
                        packagePlan: packagePlan,
                        location: location,
                        price: price,
                        remaining: remaining,
                        destinationName: destination,
                        packageCover:
                            ref.read(homeViewModelProvider).imageName ?? "",
                      );

                      ref
                          .read(homeViewModelProvider.notifier)
                          .addPackage(package);

                      if (ref.read(homeViewModelProvider).isLoading == false) {
                        _packageNameController.clear();
                        _packageTimeController.clear();
                        _PackageDescriptionController.clear();
                        _routeController.clear();
                        _packagePlanController.clear();
                        setState(() {
                          _img = null;
                        });

                        Navigator.pop(context);

                        showSnackBar(
                          context: context,
                          message: 'Package added successfully',
                          color: Colors.green,
                        );

                        ref
                            .read(homeViewModelProvider.notifier)
                            .getUserPackages();
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 24.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    'Add Package',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
