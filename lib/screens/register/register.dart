import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../controllers/register/registercontroller.dart';
import '../../statics/appcolors.dart';
import '../../widgets/loadingui.dart';
import '../login/loginview.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final MyRegistrationController controller = Get.find();
  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _fullNameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _rePasswordController;
  late final TextEditingController _phoneNumberController;
  final _formKey = GlobalKey<FormState>();
  bool isObscured = true;
  bool isPosting = false;
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _fullNameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _rePasswordFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  bool emailError = false;
  bool usernameError = false;
  bool phoneNumberError = false;
  bool fullNameError = false;

  void _startPosting() async {
    setState(() {
      isPosting = true;
    });
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      isPosting = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _fullNameController = TextEditingController();
    _passwordController = TextEditingController();
    _rePasswordController = TextEditingController();
    _phoneNumberController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 18.0, bottom: 18),
                    child: Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: TextFormField(
                      controller: _usernameController,
                      focusNode: _usernameFocusNode,
                      decoration: InputDecoration(
                          labelText: "Username",
                          labelStyle: const TextStyle(color: defaultBlack),
                          focusColor: defaultBlack,
                          fillColor: defaultBlack,
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: defaultBlack, width: 2),
                              borderRadius: BorderRadius.circular(12)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                      cursorColor: defaultBlack,
                      style: const TextStyle(color: defaultBlack),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter username";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: TextFormField(
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: const TextStyle(color: defaultBlack),
                          focusColor: defaultBlack,
                          fillColor: defaultBlack,
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: defaultBlack, width: 2),
                              borderRadius: BorderRadius.circular(12)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                      cursorColor: defaultBlack,
                      style: const TextStyle(color: defaultBlack),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter email";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: TextFormField(
                      controller: _fullNameController,
                      focusNode: _fullNameFocusNode,
                      decoration: InputDecoration(
                          labelText: "Full Name",
                          labelStyle: const TextStyle(color: defaultBlack),
                          focusColor: defaultBlack,
                          fillColor: defaultBlack,
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: defaultBlack, width: 2),
                              borderRadius: BorderRadius.circular(12)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                      cursorColor: defaultBlack,
                      style: const TextStyle(color: defaultBlack),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter full name";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: TextFormField(
                      controller: _phoneNumberController,
                      focusNode: _phoneNumberFocusNode,
                      decoration: InputDecoration(
                          labelText: "Phone Number",
                          labelStyle: const TextStyle(color: defaultBlack),
                          focusColor: defaultBlack,
                          fillColor: defaultBlack,
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: defaultBlack, width: 2),
                              borderRadius: BorderRadius.circular(12)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                      cursorColor: defaultBlack,
                      style: const TextStyle(color: defaultBlack),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter phone number";
                        }
                        if (value.length < 10) {
                          return "Enter a valid phone number";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: TextFormField(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isObscured = !isObscured;
                              });
                            },
                            icon: Icon(
                              isObscured
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: defaultBlack,
                            ),
                          ),
                          focusColor: defaultBlack,
                          fillColor: defaultBlack,
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: defaultBlack, width: 2),
                              borderRadius: BorderRadius.circular(12)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          hintText: "Password",
                          hintStyle: const TextStyle(color: defaultBlack)),
                      cursorColor: defaultBlack,
                      style: const TextStyle(color: defaultBlack),
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      obscureText: isObscured,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter password";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: TextFormField(
                      controller: _rePasswordController,
                      focusNode: _rePasswordFocusNode,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isObscured = !isObscured;
                              });
                            },
                            icon: Icon(
                              isObscured
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: defaultBlack,
                            ),
                          ),
                          focusColor: defaultBlack,
                          fillColor: defaultBlack,
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: defaultBlack, width: 2),
                              borderRadius: BorderRadius.circular(12)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          hintText: "Retype Password",
                          hintStyle: const TextStyle(color: defaultBlack)),
                      cursorColor: defaultBlack,
                      style: const TextStyle(color: defaultBlack),
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      obscureText: isObscured,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "confirm password";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  isPosting
                      ? const LoadingUi()
                      : RawMaterialButton(
                          onPressed: () {
                            _startPosting();
                            if (_formKey.currentState!.validate()) {
                              if (controller.allUsernames
                                  .contains(_usernameController.text)) {
                                Get.snackbar("Username Error",
                                    "A user with the same username already exists",
                                    colorText: defaultTextColor1,
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red);
                                return;
                              } else if (controller.allEmails
                                  .contains(_emailController.text)) {
                                Get.snackbar("Email Error",
                                    "A user with the same email already exists",
                                    colorText: defaultTextColor1,
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red);
                                return;
                              } else if (controller.allPhoneNumbers
                                  .contains(_phoneNumberController.text)) {
                                Get.snackbar("Phone number Error",
                                    "A user with the same phone number already exists",
                                    colorText: defaultTextColor1,
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red);
                                return;
                              } else if (controller.allFullNames
                                  .contains(_fullNameController.text)) {
                                Get.snackbar("Name Error",
                                    "A user with the same name already exists",
                                    colorText: defaultTextColor1,
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red);
                                return;
                              } else {
                                controller.registerUser(
                                    _usernameController.text.trim(),
                                    _emailController.text.trim(),
                                    _fullNameController.text.trim(),
                                    _phoneNumberController.text.trim(),
                                    _passwordController.text.trim(),
                                    _rePasswordController.text.trim());
                              }
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 8,
                          fillColor: buttonColor,
                          splashColor: primaryYellow,
                          child: const Text(
                            "Register",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: defaultTextColor1),
                          ),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: defaultBlack),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: defaultTextColor1),
                        ),
                        onPressed: () {
                          Get.to(() => const NewLogin());
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
