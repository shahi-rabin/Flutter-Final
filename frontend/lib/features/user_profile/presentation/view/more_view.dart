import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../../../config/router/app_route.dart';
import '../../../../config/constants/api_endpoint.dart';
import '../../../../config/constants/app_color_theme.dart';
import '../../../../core/common/provider/network_connection.dart';
import '../../../home/presentation/viewmodel/home_view_model.dart';
import '../../domain/entity/profile_entity.dart';
import '../viewmodel/logout_view_model.dart';
import '../viewmodel/profile_view_model.dart';

class MoreView extends ConsumerStatefulWidget {
  const MoreView({Key? key}) : super(key: key);

  @override
  ConsumerState<MoreView> createState() => _MoreViewState();
}

class _MoreViewState extends ConsumerState<MoreView> {
  File? img;

  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  Future _browseImage(WidgetRef ref, ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          img = File(image.path);
          ref.read(profileViewModelProvider.notifier).uploadImage(img!);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  ElevatedButton buildElevatedButton(
      BuildContext context, String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 108, 128, 142),
        padding: const EdgeInsets.all(20),
        minimumSize: const Size(double.infinity, 0),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var userState = ref.watch(profileViewModelProvider);
    List<ProfileEntity> userData = userState.usersData;

    var userPackagesState = ref.watch(homeViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(logoutViewModelProvider.notifier).logout(context);
            },
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 78, 92, 101),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(profileViewModelProvider.notifier).getUserInfo();
          await ref.read(homeViewModelProvider.notifier).getUserPackages();
          await ref
              .read(homeViewModelProvider.notifier)
              .getBookmarkedPackages();
        },
        child: FutureBuilder<bool>(
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

              if (!isNetworkConnected) {
                // If no internet, show the "No Internet" message.
                return const Center(
                  child: Text('No Internet Connection'),
                );
              } else {
                userState.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container();
                return userState.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Center(
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        backgroundColor:
                                            AppColors.secondaryColor,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  _browseImage(
                                                      ref, ImageSource.camera);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Camera'),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  _browseImage(
                                                      ref, ImageSource.gallery);
                                                  Navigator.pop(context);

                                                  setState(() {
                                                    ref
                                                        .read(
                                                            profileViewModelProvider
                                                                .notifier)
                                                        .getUserInfo();
                                                  });
                                                },
                                                child: const Text('Gallery'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: 65,
                                      backgroundImage: img != null
                                          ? FileImage(img!)
                                          : userData.isNotEmpty &&
                                                  userData[0].image != null
                                              ? NetworkImage(
                                                  '${ApiEndpoints.baseUrl}/uploads/${userData[0].image}',
                                                ) as ImageProvider
                                              : const AssetImage(
                                                  'assets/images/user.png'),
                                    ),
                                  ),
                                  const SizedBox(width: 30),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        userData[0].fullname,
                                        style: const TextStyle(
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white70),
                                      ),
                                      Text(
                                        '@${userData[0].username}',
                                        style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                userData[0].bio ?? 'No bio',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 15),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 8),
                                child: Column(
                                  children: [
                                    // buildElevatedButton(
                                    //   context,
                                    //   'Manage Your Packages',
                                    //   () {
                                    //     Navigator.pushNamed(
                                    //       context,
                                    //       AppRoute.userPackagesRoute,
                                    //     );
                                    //   },
                                    // ),
                                    // const SizedBox(height: 12.0),
                                    buildElevatedButton(
                                      context,
                                      'Bookmarked Packages',
                                      () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoute.bookmarkedPackagesRoute,
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 12.0),
                                    buildElevatedButton(
                                      context,
                                      'Edit Profile',
                                      () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoute.editProfileRoute,
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 12.0),
                                    buildElevatedButton(
                                      context,
                                      'Change Password',
                                      () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoute.changePasswordRoute,
                                        );
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
          },
        ),
      ),
    );
  }
}
