import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/snackbar/my_snackbar.dart';
import '../../domain/entity/profile_entity.dart';
import '../viewmodel/profile_view_model.dart';

class EditProfileView extends ConsumerStatefulWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  ConsumerState<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends ConsumerState<EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _bioController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var userData = ref.read(profileViewModelProvider).usersData;
    if (userData.isNotEmpty) {
      _fullNameController.text = userData[0].fullname;
      _usernameController.text = userData[0].username;
      _emailController.text = userData[0].email;
      _bioController.text = userData[0].bio ?? '';
      _phoneNumberController.text = userData[0].phoneNumber ?? '';
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var profileState = ref.watch(profileViewModelProvider.notifier);
    var userData = ref.watch(profileViewModelProvider).usersData;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 78, 92, 101),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: 5,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        color: Colors.white,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 180.0),
                      decoration: const BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height - 180.0,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const Text(
                                'Edit Profile',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              TextFormField(
                                controller: _fullNameController,
                                validator: (value) => value!.isEmpty
                                    ? 'Full Name is required'
                                    : null,
                                decoration: buildInputDecoration('Full Name'),
                              ),
                              const SizedBox(height: 20.0),
                              TextFormField(
                                controller: _usernameController,
                                validator: (value) => value!.isEmpty
                                    ? 'Username is required'
                                    : null,
                                decoration: buildInputDecoration('Username'),
                              ),
                              const SizedBox(height: 20.0),
                              TextFormField(
                                controller: _emailController,
                                validator: (value) =>
                                    value!.isEmpty ? 'Email is required' : null,
                                decoration: buildInputDecoration('Email'),
                              ),
                              const SizedBox(height: 20.0),
                              TextFormField(
                                controller: _bioController,
                                decoration:
                                    buildInputDecoration('Bio (Optional)'),
                              ),
                              const SizedBox(height: 20.0),
                              TextFormField(
                                controller: _phoneNumberController,
                                decoration: buildInputDecoration(
                                    'Phone number (Optional)'),
                              ),
                              const SizedBox(height: 20.0),
                              ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    ProfileEntity profile = ProfileEntity(
                                      fullname: _fullNameController.text,
                                      username: _usernameController.text,
                                      email: _emailController.text,
                                      bio: _bioController.text,
                                      phoneNumber: _phoneNumberController.text,
                                    );

                                    await profileState.editProfile(profile);
                                    await ref
                                        .read(profileViewModelProvider.notifier)
                                        .getUserInfo();

                                    showSnackBar(
                                      context: context,
                                      message: 'Profile edited successfully',
                                      color: Colors.green,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF0166AA),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0, horizontal: 15.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: const Text(
                                  'Save Changes',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration(String label) {
    return InputDecoration(
      hintStyle: TextStyle(color: Colors.grey[400]),
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey[700]),
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
    );
  }
}
