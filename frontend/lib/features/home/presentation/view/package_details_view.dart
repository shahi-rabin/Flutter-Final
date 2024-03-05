import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripplanner/features/booking_requests/presentation/view/create_exchange_request.dart';
import 'package:tripplanner/features/booking_requests/presentation/viewmodel/booking_request_view_model.dart';
import 'package:tripplanner/features/home/domain/entity/review_entity.dart';
import 'package:tripplanner/features/home/presentation/viewmodel/home_view_model.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../config/constants/app_color_theme.dart';
import '../../../../core/common/snackbar/my_snackbar.dart';
import '../../../home/domain/entity/package_entity.dart';

class PackageDetailsView extends ConsumerStatefulWidget {
  final PackageEntity? package;

  const PackageDetailsView({Key? key, this.package}) : super(key: key);

  @override
  ConsumerState<PackageDetailsView> createState() => _PackageDetailsViewState();
}

class _PackageDetailsViewState extends ConsumerState<PackageDetailsView> {
  double screenHeight = window.physicalSize.height / window.devicePixelRatio;

  @override
  Widget build(BuildContext context) {
    final package = widget.package;
    final homeViewModel = ref.watch(homeViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 78, 92, 101),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      package?.isBookmarked == true
                          ? Icons.bookmark
                          : Icons.bookmark_border_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      if (package?.isBookmarked == true) {
                        ref
                            .watch(homeViewModelProvider.notifier)
                            .unbookmarkPackage(package!.packageId!);
                      } else {
                        ref
                            .watch(homeViewModelProvider.notifier)
                            .bookmarkPackage(package!.packageId!);
                      }

                      ref
                          .watch(homeViewModelProvider.notifier)
                          .getAllPackages();

                      ref
                          .watch(homeViewModelProvider.notifier)
                          .getBookmarkedPackages();

                      showSnackBar(
                        message: package.isBookmarked == true
                            ? 'Package unbookmarked'
                            : 'Package bookmarked',
                        context: context,
                        color: Colors.green,
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        '${ApiEndpoints.baseUrl}/uploads/${package?.packageCover}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    package!.packageName,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    package.packageTime,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        package.packagePlan,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_city,
                        color: Colors.greenAccent,
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        package.location,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Description:",
                        style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70),
                      ),
                      Text(
                        package.packageDescription,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        await ref
                            .watch(homeViewModelProvider.notifier)
                            .getPackageById(package.packageId!);

                        await ref
                            .watch(bookingRequestViewModelProvider.notifier)
                            .getBookingRequests();

                        final bookingRequests = ref
                            .read(bookingRequestViewModelProvider)
                            .bookingRequests;
                        print(bookingRequests);

                        final requestedPackage =
                            ref.read(homeViewModelProvider).packageById;

                        if (!context.mounted) return;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateBookingRequestView(
                              packageId: package.packageId!,
                              requestedPackage: requestedPackage,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 15.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        'Request Package',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ReviewListWidget(
              reviews: ref.watch(homeViewModelProvider).reviews,
              packageId: package.packageId.toString(),
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewListWidget extends StatelessWidget {
  final List<ReviewEntity?>? reviews;
  final String packageId;

  const ReviewListWidget({Key? key, this.reviews, required this.packageId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Reviews:",
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddReviewPage(
                        packageId: packageId,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Add Review',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          if (reviews != null && reviews!.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              itemCount: reviews!.length,
              itemBuilder: (context, index) {
                final review = reviews![index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review!.review,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Ratings: ${review.rating}',
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              },
            )
          else
            const Text(
              "No reviews available.",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}

class AddReviewPage extends ConsumerStatefulWidget {
  final String packageId;

  const AddReviewPage({Key? key, required this.packageId}) : super(key: key);

  @override
  _AddReviewPageState createState() => _AddReviewPageState();
}

class _AddReviewPageState extends ConsumerState<AddReviewPage> {
  double _rating = 0.0;
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.watch(homeViewModelProvider.notifier).get_all_reviews(widget.packageId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Review'),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rating:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: _rating,
              min: 0,
              max: 5,
              divisions: 5,
              onChanged: (value) {
                setState(() {
                  _rating = value;
                });
              },
              label: _rating.toStringAsFixed(1),
            ),
            const Text(
              'Review:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _reviewController,
              decoration: const InputDecoration(
                hintText: 'Enter your review...',
                border: OutlineInputBorder(),
              ),
              maxLines: null,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                String reviewText = _reviewController.text;
                print(_rating);
                print(reviewText);
                await ref.read(homeViewModelProvider.notifier).addReviews(
                    reviewText, _rating.toString(), widget.packageId);

                Navigator.pop(context);
              },
              child: const Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }
}
