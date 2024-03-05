import 'package:flutter/material.dart';
import 'package:tripplanner/features/booking_requests/presentation/view/booking_requests_view.dart';
import 'package:tripplanner/features/home/domain/entity/package_entity.dart';
import 'package:tripplanner/features/home/presentation/view/update_book_view.dart';
import 'package:tripplanner/features/user_profile/presentation/view/more_view.dart';

import '../../features/auth/presentation/view/login_view.dart';
import '../../features/auth/presentation/view/signup_view.dart';
import '../../features/booking_requests/presentation/view/create_exchange_request.dart';
import '../../features/home/domain/entity/book_entity.dart';
import '../../features/home/presentation/view/add_package_view.dart';
import '../../features/home/presentation/view/package_details_view.dart';
import '../../features/home/presentation/view/dashboard_view.dart';
import '../../features/home/presentation/view/homepage_view.dart';
import '../../features/splash/presentation/view/splash_view.dart';
import '../../features/user_profile/presentation/view/bookmarked_books_view.dart';
import '../../features/user_profile/presentation/view/change_password_view.dart';
import '../../features/user_profile/presentation/view/edit_profile_view.dart';
import '../../features/user_profile/presentation/view/user_books_view.dart';

class AppRoute {
  AppRoute._();

  static const String homeRoute = '/home';
  static const String bookScreen = '/book';
  static const String bookDetails = '/bookDetails';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String messagesRoute = '/messages';
  static const String chatRoute = '/chat';
  static const String splashRoute = '/splash';
  static const String userPackagesRoute = '/userBooks';
  static const String bookmarkedPackagesRoute = '/bookmarkedBooks';
  static const String changePasswordRoute = '/changePassword';
  static const String editProfileRoute = '/editProfile';
  static const String addPackageRoute = '/addPackage';
  static const String updatePackageRoute = '/updatePackage';
  static const String createExchangeRequestView = '/createExchangeRequest';
  static const String exchangeRequestView = '/exchangeRequest';
  static const String morePackagesRoute = '/morePackages';

  static getApplicationRoute() {
    return {
      loginRoute: (context) => const LoginView(),
      homeRoute: (context) => const DashboardView(),
      bookScreen: (context) => const HomepageView(),
      bookDetails: (context) => PackageDetailsView(
            package: null,
          ),
      registerRoute: (context) => const SignupView(),
      splashRoute: (context) => const SplashView(),
      morePackagesRoute: (context) => const MoreView(),
      userPackagesRoute: (context) => const UserPackagesView(),
      bookmarkedPackagesRoute: (context) => const BookmarkedPackagesView(),
      changePasswordRoute: (context) => const ChangePasswordView(),
      editProfileRoute: (context) => const EditProfileView(),
      addPackageRoute: (context) => const AddPackageView(),
      updatePackageRoute: (context) {
        final package =
            ModalRoute.of(context)!.settings.arguments as PackageEntity;
        return UpdatePackageView(package: package);
      },
      createExchangeRequestView: (context) => const CreateBookingRequestView(),
      exchangeRequestView: (context) => const BookingRequestsView(),
    };
  }
}
