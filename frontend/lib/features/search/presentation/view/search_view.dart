import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripplanner/config/constants/api_endpoint.dart';
import 'package:tripplanner/features/home/presentation/view/package_details_view.dart';

// import '../../../home/presentation/view/package_details_view.dart';
import '../viewmodel/search_view_model.dart';

class SearchView extends ConsumerStatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<SearchView> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Packages'),
      ),
      backgroundColor: const Color.fromARGB(255, 78, 92, 101),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(154, 190, 204, 216),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.search),
                          ),
                          Expanded(
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  searchText = value;
                                  ref
                                      .watch(searchViewModelProvider.notifier)
                                      .getSearchedPackages(searchText);
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: "Search packages for booking",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              if (searchText.isEmpty) // When nothing is searched initially
                const Center(
                  child: Column(
                    children: [
                      Text(
                        'Your search results will appear here',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                )
              else if (searchState.isLoading)
                const Center(child: CircularProgressIndicator())
              // else if (searchState.searchedPackages.isEmpty)
              //   const Expanded(
              //     child: Center(
              //       child: Text('No packages found'),
              //     ),
              //   )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: searchState.searchedPackages.length,
                    itemBuilder: (context, index) {
                      final package = searchState.searchedPackages[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PackageDetailsView(package: package),
                            ),
                          );
                        },
                        child: PackageListItem(
                          packageCover: package.packageCover!,
                          packageTitle: package.packageName,
                          packageTime: package.packageTime,
                          location: package.location,
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class PackageListItem extends StatelessWidget {
  final String? packageCover;
  final String packageTitle;
  final String packageTime;
  final String location;

  const PackageListItem({
    Key? key,
    this.packageCover,
    required this.packageTitle,
    required this.packageTime,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 108, 128, 142),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Package Cover
          Container(
            width: 110,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "${ApiEndpoints.baseUrl}/uploads/$packageCover"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Package Title
                Text(
                  packageTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Date: $packageTime",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // Location
                Text(
                  "Location: $location",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
