import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripplanner/features/home/domain/entity/package_entity.dart';
import 'package:tripplanner/features/home/presentation/viewmodel/home_view_model.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../home/presentation/view/package_details_view.dart';
import '../../domain/entity/profile_entity.dart';
import '../viewmodel/profile_view_model.dart';

class BookmarkedPackagesView extends ConsumerStatefulWidget {
  const BookmarkedPackagesView({Key? key}) : super(key: key);

  @override
  ConsumerState<BookmarkedPackagesView> createState() =>
      _BookmarkedPackagesViewState();
}

class _BookmarkedPackagesViewState
    extends ConsumerState<BookmarkedPackagesView> {
  @override
  Widget build(BuildContext context) {
    var userState = ref.watch(profileViewModelProvider);
    List<ProfileEntity> userData = userState.usersData;

    var bookmarkedPackagesState = ref.watch(homeViewModelProvider);
    List<PackageEntity> bookmarkedPackages =
        bookmarkedPackagesState.bookmarkedPackages;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 78, 92, 101),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref
              .read(homeViewModelProvider.notifier)
              .getBookmarkedPackages();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 16.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Bookmarked Packages',
                        style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70),
                      ),
                      const SizedBox(height: 20.0),
                      if (bookmarkedPackages.isEmpty)
                        const Center(
                          child: Text(
                            'No bookmarked packages',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        )
                      else
                        Column(
                          children: bookmarkedPackages
                              .map((package) =>
                                  buildPackageItem(context, package))
                              .toList(),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPackageItem(BuildContext context, PackageEntity package) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PackageDetailsView(package: package),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 108, 128, 142),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2.0,
              blurRadius: 5.0,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.bookmark),
                  color: Colors.white,
                  iconSize: 30,
                  onPressed: () {
                    showUnbookmarkDialog(context, package);
                  },
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    package.packageCover!.isEmpty
                        ? 'https://img.freepik.com/premium-photo/picture-image-symbol-blue-background_172429-2022.jpg'
                        : '${ApiEndpoints.baseUrl}/uploads/${package.packageCover}',
                    width: 80.0,
                    height: 120.0,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        package.packageName,
                        style: const TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        package.location,
                        style: const TextStyle(
                            fontSize: 16.0, color: Colors.white),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        package.location,
                        style: const TextStyle(
                            fontSize: 16.0, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  void showUnbookmarkDialog(BuildContext context, PackageEntity package) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Unbookmark Package'),
          content:
              const Text('Are you sure you want to unbookmark this package?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                ref
                    .watch(homeViewModelProvider.notifier)
                    .unbookmarkPackage(package.packageId!);

                ref
                    .watch(homeViewModelProvider.notifier)
                    .getBookmarkedPackages();

                ref.watch(homeViewModelProvider.notifier).getAllPackages();

                Navigator.pop(context);
              },
              child: const Text('Unbookmark'),
            ),
          ],
        );
      },
    );
  }
}
