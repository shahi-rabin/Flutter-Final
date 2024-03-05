import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripplanner/core/common/snackbar/my_snackbar.dart';
import 'package:tripplanner/features/home/domain/entity/package_entity.dart';
import 'package:tripplanner/features/home/presentation/viewmodel/home_view_model.dart';

class UpdatePackageView extends ConsumerStatefulWidget {
  final PackageEntity package;

  const UpdatePackageView({required this.package, Key? key}) : super(key: key);

  @override
  ConsumerState<UpdatePackageView> createState() => _UpdatePackageViewState();
}

class _UpdatePackageViewState extends ConsumerState<UpdatePackageView> {
  late TextEditingController _packageNameController;
  late TextEditingController _packageTimeController;
  late TextEditingController _packageDescriptionController;
  late TextEditingController _packagePlanController;
  late TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    _packageNameController =
        TextEditingController(text: widget.package.packageName);
    _packageTimeController =
        TextEditingController(text: widget.package.packageTime);
    _packageDescriptionController =
        TextEditingController(text: widget.package.packageDescription);
    _packagePlanController =
        TextEditingController(text: widget.package.packagePlan);
    _locationController = TextEditingController(text: widget.package.location);
  }

  @override
  void dispose() {
    _packageNameController.dispose();
    _packageTimeController.dispose();
    _packageDescriptionController.dispose();
    _packagePlanController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  File? _img;

  Future _browseImage(WidgetRef ref, ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
        });
        ref.read(homeViewModelProvider.notifier).uploadPackageCover(_img!);
      } else {
        // User didn't select a new image, do nothing in this case
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Package'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8.0),
              const Text(
                'Title',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _packageNameController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Enter title',
                  hintStyle: const TextStyle(color: Colors.grey),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Author',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _packageTimeController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Enter author',
                  hintStyle: const TextStyle(color: Colors.grey),
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
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _packageDescriptionController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Enter description',
                  hintStyle: const TextStyle(color: Colors.grey),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Genre',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _packagePlanController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Enter genre',
                  hintStyle: const TextStyle(color: Colors.grey),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Language',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _locationController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Enter language',
                  hintStyle: const TextStyle(color: Colors.grey),
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
                    final title = _packageNameController.text;
                    final author = _packageTimeController.text;
                    final description = _packageDescriptionController.text;
                    final genre = _packagePlanController.text;
                    final language = _locationController.text;

                    PackageEntity package = PackageEntity(
                      packageId: widget.package.packageId,
                      packageName: title,
                      packageTime: author,
                      packageDescription: description,
                      packagePlan: genre,
                      location: language,
                      packageCover: _img != null
                          ? ref.read(homeViewModelProvider).imageName ?? ""
                          : widget.package.packageCover,
                    );

                    ref
                        .read(homeViewModelProvider.notifier)
                        .updatePackage(package, widget.package.packageId!);

                    ref
                        .read(homeViewModelProvider.notifier)
                        .getUserPackages()
                        .then((value) {
                      Navigator.pop(context);
                      showSnackBar(
                        message: 'Package updated successfully',
                        context: context,
                        color: Colors.green,
                      );
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
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
                    'Update Package',
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
