import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripplanner/features/booking_requests/presentation/view/booking_requests_view.dart';
import 'package:tripplanner/features/home/presentation/view/homepage_view.dart';
import 'package:tripplanner/features/search/presentation/view/search_view.dart';
import 'package:tripplanner/features/user_profile/domain/entity/profile_entity.dart';
import 'package:tripplanner/features/user_profile/presentation/view/more_view.dart';

import '../../../../config/constants/app_color_theme.dart';
import '../../../../config/router/app_route.dart';
import '../../../booking_requests/presentation/viewmodel/booking_request_view_model.dart';
import '../../../user_profile/presentation/viewmodel/profile_view_model.dart';
import '../viewmodel/home_view_model.dart';

class CustomNavigationBar extends ConsumerStatefulWidget {
  final int selectedIndex;
  final void Function(int index) onItemTapped;

  const CustomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  ConsumerState<CustomNavigationBar> createState() =>
      _CustomNavigationBarState();
}

class _CustomNavigationBarState extends ConsumerState<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    var userState = ref.watch(profileViewModelProvider);
    List<ProfileEntity> userData = userState.usersData;
    bool isAdmin = userData.isNotEmpty && userData[0].userType == 'admin';
    print(isAdmin);
    return BottomAppBar(
      color: const Color.fromARGB(255, 49, 51, 53),
      child: SizedBox(
        height: 60, // Adjust this value to fit your design
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNavItem(Icons.home, 'Home', widget.selectedIndex == 0,
                () => widget.onItemTapped(0)),
            buildNavItem(Icons.search, 'Search', widget.selectedIndex == 1,
                () => widget.onItemTapped(1)),
            // Only show "Exchange" if user is admin
            buildNavItem(Icons.place, 'Bookings', widget.selectedIndex == 2,
                () => widget.onItemTapped(2)),
            buildNavItem(Icons.menu, 'More', widget.selectedIndex == 3,
                () => widget.onItemTapped(3)),
          ],
        ),
      ),
    );
  }

  Widget buildNavItem(
      IconData icon, String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? AppColors.primaryColor : Colors.grey),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.primaryColor : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  StreamSubscription<AccelerometerEvent>? accelerometerSubscription;
  double _currentX = 0.0;
  final double _accelerometerThreshold = 10.0;
  bool _canChangeMenu = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeViewModelProvider.notifier).getAllPackages();
      ref.read(profileViewModelProvider.notifier).getUserInfo();
      ref.read(homeViewModelProvider.notifier).getUserPackages();
      ref.read(homeViewModelProvider.notifier).getBookmarkedPackages();
      ref.read(bookingRequestViewModelProvider.notifier).getBookingRequests();
      ref
          .read(bookingRequestViewModelProvider.notifier)
          .getAcceptedBookingRequest();
    });

    accelerometerSubscription =
        accelerometerEvents?.listen((AccelerometerEvent event) {
      if (!_canChangeMenu) return;

      setState(() {
        _currentX = event.x;
      });

      if (_currentX.abs() > _accelerometerThreshold) {
        _canChangeMenu = false;
        if (_currentX > 0) {
          _navigateToNextMenuItem();
        } else {
          _navigateToPreviousMenuItem();
        }
        _resetNavigationFlag();
      }
    });
  }

  void _resetNavigationFlag() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _canChangeMenu = true; // Reset the navigation flag after a delay
      });
    });
  }

  @override
  void dispose() {
    accelerometerSubscription?.cancel();
    super.dispose();
  }

  int _selectedIndex = 0;

  List<Widget> screens = [
    const HomepageView(),
    const SearchView(),
    const BookingRequestsView(),
    const MoreView(),
  ];

  void _navigateToNextMenuItem() {
    int nextIndex = (_selectedIndex + 1) % screens.length;
    if (screens[nextIndex] != const SizedBox.shrink()) {
      setState(() {
        _selectedIndex = nextIndex;
      });
    }
  }

  void _navigateToPreviousMenuItem() {
    int prevIndex = (_selectedIndex - 1) % screens.length;
    if (screens[prevIndex] != const SizedBox.shrink()) {
      setState(() {
        _selectedIndex = prevIndex < 0 ? screens.length - 1 : prevIndex;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBottomNavigationBar() {
    return CustomNavigationBar(
      selectedIndex: _selectedIndex,
      onItemTapped: _onItemTapped,
    );
  }

  @override
  Widget build(BuildContext context) {
    var userState = ref.watch(profileViewModelProvider);
    List<ProfileEntity> userData = userState.usersData;
    bool isAdmin = userData.isNotEmpty && userData[0].userType == 'admin';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoute.addPackageRoute);
              },
              backgroundColor: AppColors.primaryColor,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              child: const Icon(Icons.add),
            )
          : null, // Hide the plus button for non-admin users
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavigationBar(),
      backgroundColor: const Color(0xffF1F4EE),
      body: screens[_selectedIndex],
    );
  }
}
