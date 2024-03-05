import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripplanner/features/booking_requests/presentation/viewmodel/booking_request_view_model.dart';
import 'package:tripplanner/features/home/presentation/view/package_details_view.dart';

import '../../../../core/common/provider/internet_connectivity.dart';
import '../../../../core/common/provider/network_connection.dart';
import '../../domain/entity/package_entity.dart';
import '../viewmodel/home_view_model.dart';
import '../widget/buildPackageCard.dart';

class HomepageView extends ConsumerStatefulWidget {
  const HomepageView({Key? key}) : super(key: key);

  @override
  ConsumerState<HomepageView> createState() => _HomepageViewState();
}

class _HomepageViewState extends ConsumerState<HomepageView> {
  @override
  Widget build(BuildContext context) {
    var packageState = ref.watch(homeViewModelProvider);
    List<PackageEntity> homeList = packageState.packages;

    var internetState = ref.watch(connectivityStatusProvider);
    Future get_review(id) async {
      await ref.watch(homeViewModelProvider.notifier).get_all_reviews(id);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: const Color.fromARGB(255, 78, 92, 101),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(homeViewModelProvider.notifier).getAllPackages();
        },
        child: packageState.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: homeList.length,
                          itemBuilder: (context, index) {
                            final package = homeList[index];
                            final homeViewModel =
                                ref.read(homeViewModelProvider.notifier);
                            return FutureBuilder<bool>(
                                future: checkConnectivity(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text('Error: ${snapshot.error}'),
                                    );
                                  } else {
                                    final isNetworkConnected =
                                        snapshot.data ?? false;

                                    return GestureDetector(
                                      onTap: () {
                                        get_review(package.packageId!);
                                        if (isNetworkConnected) {
                                          //   final test =
                                          //       ref.watch(homeViewModelProvider);
                                          //  print(test);
                                          if (!context.mounted) return;
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PackageDetailsView(
                                                package: package,
                                              ),
                                            ),
                                          );
                                        } else {
                                          if (!context.mounted) return;
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'No Internet Connection'),
                                                content: const Text(
                                                    'Please check your internet connection and try again.'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('OK'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(); // Close the dialog
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      },
                                      child: buildPackageCard(
                                        packageId: package.packageId!,
                                        title: package.packageName,
                                        author: package.packagePlan,
                                        description: package.packageDescription,
                                        price: package.price.toString(),
                                        remaining: package.remaining.toString(),
                                        packageCover: package.packageCover!,
                                        date: package.price.toString(),
                                        formattedCreatedAt: package.packageTime,
                                        isBookmarked: package.isBookmarked!,
                                        homeViewModel: homeViewModel,
                                        context: context,
                                        user: package.user!,
                                        internetState: internetState,
                                        onPressed: () async {
                                          final requestedPackage = ref
                                              .read(homeViewModelProvider)
                                              .packageById;

                                          if (!context.mounted) return;

                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) =>
                                          //         CreateBookingRequestView(
                                          //             packageId: package.packageId!,
                                          //             requestedPackage:
                                          //                 requestedPackage),
                                          //   ),
                                          // );

                                          await ref
                                              .watch(homeViewModelProvider
                                                  .notifier)
                                              .getPackageById(
                                                  package.packageId!);

                                          await ref
                                              .watch(
                                                  bookingRequestViewModelProvider
                                                      .notifier)
                                              .getBookingRequests();

                                          final bookingRequests = ref
                                              .read(
                                                  bookingRequestViewModelProvider)
                                              .bookingRequests;
                                          print(bookingRequests);
                                        },
                                      ),
                                    );
                                  }
                                });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
