import 'package:flutter/material.dart';
import 'package:tripplanner/features/home/presentation/viewmodel/home_view_model.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../core/common/provider/internet_connectivity.dart';
import '../../../../core/common/provider/network_connection.dart';
import '../../../../core/common/snackbar/my_snackbar.dart';

Widget buildPackageCard({
  required String packageId,
  required String title,
  required String author,
  required String description,
  required String remaining,
  required String price,
  required String packageCover,
  required String date,
  required String formattedCreatedAt,
  required bool isBookmarked,
  required HomeViewModel homeViewModel,
  required BuildContext context,
  required Map<String, dynamic> user,
  required VoidCallback onPressed,
  required ConnectivityStatus internetState,
}) {
  bool isAvailable = int.parse(remaining) > 0;

  return Column(
    children: [
      Container(
        height: 300,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            FutureBuilder<bool>(
                future: checkConnectivity(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    final isNetworkConnected = snapshot.data ?? false;

                    return Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 100,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          image: DecorationImage(
                            image:
                                // check for internet connection
                                isNetworkConnected
                                    // ignore: unnecessary_cast
                                    ? NetworkImage(
                                            '${ApiEndpoints.baseUrl}/uploads/$packageCover')
                                        as ImageProvider<Object>
                                    : const AssetImage(
                                        'assets/images/no_internet.jpg'), // Specify the type of AssetImage

                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }
                }),
            // const Positioned(
            //   top: 10,
            //   left: 10,
            //   child: CircleAvatar(
            //     radius: 20,
            //     backgroundImage: NetworkImage(
            //         'https://media.licdn.com/dms/image/C4E03AQFzMbkgAPQ5WA/profile-displayphoto-shrink_800_800/0/1626746224502?e=2147483647&v=beta&t=i0FMB8pQsIFJRqx4jagP_NjmwCI2tVK-bEXoUFGO2vg'),
            //   ),
            // ),
            Positioned.fill(
              top: 0,
              left: 0,
              right: 0,
              bottom: 100,
              child: Opacity(
                opacity: 0.5,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: isBookmarked
                    ? const Icon(Icons.bookmark)
                    : const Icon(Icons.bookmark_border_rounded),
                color: Colors.white,
                iconSize: 30,
                onPressed: () {
                  if (isBookmarked) {
                    homeViewModel.unbookmarkPackage(packageId);
                    showSnackBar(
                      context: context,
                      message: 'Package unbookmarked',
                      color: Colors.lightGreen,
                    );
                  } else {
                    homeViewModel.bookmarkPackage(packageId);
                    showSnackBar(
                      context: context,
                      message: 'Package bookmarked',
                      color: Colors.green,
                    );
                  }

                  homeViewModel.getAllPackages();

                  homeViewModel.getBookmarkedPackages();
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  height: 130, color: const Color.fromARGB(255, 166, 180, 192)),
            ),

            Positioned(
              top: 175,
              left: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    author,
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 235,
              left: 10,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.price_change,
                                size: 20,
                                color: Color.fromARGB(255, 5, 55, 131),
                              ),
                              Text(
                                'Price: Rs. $price',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 5, 55, 131)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          // Display availability badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 3,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: isAvailable ? Colors.green : Colors.red,
                            ),
                            child: Text(
                              isAvailable ? 'Available' : 'Not Available',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}
