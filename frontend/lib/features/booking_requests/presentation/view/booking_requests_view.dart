import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripplanner/features/user_profile/domain/entity/profile_entity.dart';
import 'package:tripplanner/features/user_profile/presentation/viewmodel/profile_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../core/common/provider/network_connection.dart';
import '../../../../core/common/snackbar/my_snackbar.dart';
import '../viewmodel/booking_request_view_model.dart';

enum RequestStatus { pending, accepted, all }

class BookingRequestsView extends ConsumerStatefulWidget {
  const BookingRequestsView({Key? key}) : super(key: key);

  @override
  ConsumerState<BookingRequestsView> createState() =>
      _BookingRequestsViewState();
}

class _BookingRequestsViewState extends ConsumerState<BookingRequestsView> {
  RequestStatus selectedStatus = RequestStatus.all;

  // Function to open Gmail
  void _sendEmail(String gmailAccount) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: gmailAccount,
      queryParameters: {
        'subject': 'tripplanner',
      },
    );
    launchUrl(emailLaunchUri);
  }

  @override
  Widget build(BuildContext context) {
    var userState = ref.watch(profileViewModelProvider);
    List<ProfileEntity> userData = userState.usersData;
    bool isAdmin = userData.isNotEmpty && userData[0].userType == 'admin';
    var bookingRequestsState = ref.watch(bookingRequestViewModelProvider);
    var bookingRequestsData = bookingRequestsState.bookingRequests;

    var filteredRequests = bookingRequestsData.where((request) {
      if (selectedStatus == RequestStatus.pending) {
        return request.status == 'pending';
      } else if (selectedStatus == RequestStatus.accepted) {
        return request.status == 'accepted';
      } else if (selectedStatus == RequestStatus.all) {
        return true;
      }
      return false;
    }).toList();

    bool hasPendingRequests = filteredRequests.any(
      (bookingRequest) => bookingRequest.status == 'pending',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Requests'),
      ),
      backgroundColor: const Color.fromARGB(255, 78, 92, 101),
      body: RefreshIndicator(
        onRefresh: () async {
          if (isAdmin) {
            await ref
                .read(bookingRequestViewModelProvider.notifier)
                .getBookingRequests();
          } else {
            await ref
                .read(bookingRequestViewModelProvider.notifier)
                .getAcceptedBookingRequest();
          }
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
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: isAdmin
                            ? CupertinoSlidingSegmentedControl<RequestStatus>(
                                groupValue: selectedStatus,
                                onValueChanged: (value) {
                                  setState(() {
                                    selectedStatus = value!;
                                  });
                                },
                                backgroundColor: Colors.white60,
                                children: const {
                                  RequestStatus.pending: Text('Pending'),
                                  RequestStatus.accepted: Text('Accepted'),
                                  RequestStatus.all: Text('All'),
                                },
                              )
                            : Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          71, 255, 255, 255)),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: const Text(
                                  'Accepted',
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ),
                      ),
                      const SizedBox(height: 15),
                      Expanded(
                        child: bookingRequestsState.isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : filteredRequests.isEmpty
                                ? const Center(
                                    child: Column(
                                      children: [
                                        SizedBox(height: 50),
                                        Text(
                                          'No requests found',
                                          style:
                                              TextStyle(color: Colors.white70),
                                        )
                                      ],
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: filteredRequests.length,
                                    itemBuilder: (context, index) {
                                      var bookingRequest =
                                          filteredRequests[index];

                                      return Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 108, 128, 142),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: const Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        margin:
                                            const EdgeInsets.only(bottom: 15.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 80,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    image: DecorationImage(
                                                      image: NetworkImage(bookingRequest
                                                                      .requestedPackage?[
                                                                  "package_cover"] ==
                                                              ""
                                                          ? 'https://img.freepik.com/premium-photo/picture-image-symbol-blue-background_172429-2022.jpg'
                                                          : '${ApiEndpoints.baseUrl}/uploads/${bookingRequest.requestedPackage?["package_cover"]}'),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                const Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Container(
                                                  alignment: Alignment.center,
                                                  child:
                                                      bookingRequest.status ==
                                                              'accepted'
                                                          ? Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                if (isAdmin &&
                                                                    bookingRequest
                                                                            .status ==
                                                                        'accepted')
                                                                  IconButton(
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .message),
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        191,
                                                                        199,
                                                                        220),
                                                                    onPressed:
                                                                        () async {
                                                                      _sendEmail(
                                                                          bookingRequest
                                                                              .requester!['email']);
                                                                    },
                                                                  ),
                                                                if (isAdmin &&
                                                                    bookingRequest
                                                                            .status ==
                                                                        'accepted')
                                                                  IconButton(
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .delete),
                                                                    color: Colors
                                                                            .red[
                                                                        100],
                                                                    onPressed:
                                                                        () {
                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return AlertDialog(
                                                                            title:
                                                                                const Text('Remove Request'),
                                                                            content:
                                                                                const Text('Are you sure you want to remove this request?'),
                                                                            actions: [
                                                                              TextButton(
                                                                                onPressed: () {
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                child: const Text('Cancel'),
                                                                              ),
                                                                              TextButton(
                                                                                onPressed: () {
                                                                                  ref.read(bookingRequestViewModelProvider.notifier).declineBookingRequest(bookingRequest.bookingId!);

                                                                                  ref.read(bookingRequestViewModelProvider.notifier).getBookingRequests();

                                                                                  Navigator.pop(context);
                                                                                  showSnackBar(
                                                                                    context: context,
                                                                                    message: 'Request removed successfully',
                                                                                    color: Colors.green,
                                                                                  );
                                                                                },
                                                                                child: const Text('Remove'),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                  ),
                                                              ],
                                                            )
                                                          : Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                IconButton(
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .check),
                                                                  color: Colors
                                                                      .green,
                                                                  onPressed:
                                                                      () {
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                          title:
                                                                              const Text('Accept Request'),
                                                                          content:
                                                                              const Text('Are you sure you want to accept this request?'),
                                                                          actions: [
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: const Text('Cancel'),
                                                                            ),
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                ref.read(bookingRequestViewModelProvider.notifier).acceptBookingRequest(bookingRequest.bookingId!);

                                                                                ref.read(bookingRequestViewModelProvider.notifier).getBookingRequests();

                                                                                Navigator.pop(context);
                                                                                showSnackBar(
                                                                                  context: context,
                                                                                  message: 'Request accepted',
                                                                                  color: Colors.green,
                                                                                );
                                                                              },
                                                                              child: const Text('Accept'),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                ),
                                                                IconButton(
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .close),
                                                                  color: Colors
                                                                      .red,
                                                                  onPressed:
                                                                      () {
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                          title:
                                                                              const Text('Decline Request'),
                                                                          content:
                                                                              const Text('Are you sure you want to decline this request?'),
                                                                          actions: [
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: const Text('Cancel'),
                                                                            ),
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                ref.read(bookingRequestViewModelProvider.notifier).declineBookingRequest(bookingRequest.bookingId!);

                                                                                ref.read(bookingRequestViewModelProvider.notifier).getBookingRequests();

                                                                                Navigator.pop(context);
                                                                                showSnackBar(
                                                                                  context: context,
                                                                                  message: 'Request declined',
                                                                                  color: Colors.green,
                                                                                );
                                                                              },
                                                                              child: const Text('Decline'),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                ),
                                              ],
                                            ),
                                            const Divider(),
                                            Row(
                                              children: [
                                                const Text(
                                                  "Requested Book : ",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Text(
                                                  bookingRequest
                                                          .requestedPackage![
                                                      'package_name'],
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Wrap(
                                              alignment: WrapAlignment.center,
                                              children: [
                                                const Text(
                                                  "Message : ",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Text(
                                                  bookingRequest
                                                      .furtherRequirements,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "Status : ",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Text(
                                                  bookingRequest.status,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                      ),
                    ],
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
