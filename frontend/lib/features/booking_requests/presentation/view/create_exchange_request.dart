import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripplanner/config/constants/api_endpoint.dart';
import 'package:tripplanner/core/common/snackbar/my_snackbar.dart';
import 'package:tripplanner/features/booking_requests/domain/entity/booking_request_entity.dart';
import 'package:tripplanner/features/booking_requests/presentation/viewmodel/booking_request_view_model.dart';
import 'package:tripplanner/features/home/domain/entity/package_entity.dart';
import 'package:tripplanner/features/home/presentation/viewmodel/home_view_model.dart';

class CreateBookingRequestView extends ConsumerStatefulWidget {
  final String packageId;
  final List<PackageEntity>? requestedPackage;
  const CreateBookingRequestView(
      {super.key, this.packageId = '', this.requestedPackage});

  @override
  ConsumerState<CreateBookingRequestView> createState() =>
      _CreateBookingRequestViewState();
}

class _CreateBookingRequestViewState
    extends ConsumerState<CreateBookingRequestView> {
  @override
  void initState() {
    super.initState();
    _loadUserPackages();
  }

  List<PackageEntity> userPackages = [];

  final _emailController = TextEditingController();
  final _contactNumController = TextEditingController();
  final _furtherRequirementsController = TextEditingController();

  String _selectedPackage = ''; // Initially no book selected

  Future<void> _loadUserPackages() async {
    var userPackagesState = ref.read(homeViewModelProvider);
    userPackages = userPackagesState.userPackages;

    _selectedPackage = '';
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final PackageId = widget.packageId;
    final requestedPackage = widget.requestedPackage;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Booking Request',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white70),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 78, 92, 101),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 180,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: NetworkImage(
                                "${ApiEndpoints.baseUrl}/uploads/${requestedPackage![0].packageCover}",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons
                                        .library_books, // Relevant icon for a package name
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    requestedPackage[0].packageName,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons
                                        .route, // Relevant icon for a route or person
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    requestedPackage[0].route.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons
                                        .location_on, // Relevant icon for a location
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    requestedPackage[0].location,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons
                                        .attach_money, // Relevant icon for a price
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    requestedPackage[0].price.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 25),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                ),
                const Text(
                  'Email',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        border: InputBorder.none,
                      ),
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Phone Number',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _contactNumController,
                      decoration: const InputDecoration(
                        hintText: 'Number',
                        border: InputBorder.none,
                      ),
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your number';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Requirements',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _furtherRequirementsController,
                      decoration: const InputDecoration(
                        hintText: 'requirement',
                        border: InputBorder.none,
                      ),
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your requirement';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      BookingRequestEntity bookingRequest =
                          BookingRequestEntity(
                        email: _emailController.text,
                        contactNum: _contactNumController.text,
                        furtherRequirements:
                            _furtherRequirementsController.text,
                      );

                      ref
                          .read(bookingRequestViewModelProvider.notifier)
                          .createBookingRequest(
                            bookingRequest,
                            PackageId,
                          );

                      if (ref.read(bookingRequestViewModelProvider).isLoading) {
                        showSnackBar(
                          message: 'Booking request created successfully',
                          context: context,
                          color: Colors.green,
                        );

                        Navigator.pop(context);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Request Booking',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
