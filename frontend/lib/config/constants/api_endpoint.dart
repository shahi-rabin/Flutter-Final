class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:3002/";
  // static const String baseUrl = "http://172.26.1.22:3000/api/v1/";
  // static const String baseUrl = "http://192.168.137.1:3000/api/v1/";
  // static const String baseUrl = "http://192.168.1.6:3001/";

  // ====================== Auth Routes ======================
  static const String login = "users/login";
  static const String register = "users/register";

  static const String uploadImage = "users/uploadImage";

  static const String getAllPackages = "packages/";
  static String getPackageById(String packageId) => "packages/$packageId";
  static const String getBookmarkedPackages = "packages/bookmarked-packages";
  static const String getUserPackages = "packages/my-packages";
  static const String uploadPackageCover = "packages/uploadPackageCover";
  static String get_all_reviews(String packageId) =>
      "packages/get-review/$packageId";
  static String addReview(String packageId) => "packages/add-review/$packageId";

  static const String addPackage = "packages/";
  static String updatePackage(String packageId) => "packages/$packageId";
  static String deletePackage(String packageId) => "packages/$packageId";
  static String bookmarkPackage(String packageId) =>
      "packages/bookmark/$packageId";
  static String unbookmarkPackage(String packageId) =>
      "packages/bookmark/$packageId";
  static const String searchPackages = "packages/search";

  static const String getUserProfile = "users/";
  static const String changePassword = "users/change-password";
  static const String editProfile = "users/edit-profile";

  static String createBookingRequest(String requestedPackage) =>
      "booking/$requestedPackage/booking-request";
  static const String getBookingRequests = "booking/booking-requests/";
  static String acceptBookingRequest(String requestId) =>
      "booking/booking-request/$requestId/accept";
  static String declineBookingRequest(String requestId) =>
      "booking/booking-request/$requestId/decline";

  static const String getAcceptedBookingRequest =
      "booking/booking-requests/accepted";
}
