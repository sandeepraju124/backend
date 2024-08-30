// // ignore_for_file: prefer_const_constructors, use_build_context_synchronously

// import 'dart:io';

// import 'package:backendapp/screens/redirection.dart';

// import 'package:backendapp/utils/constants.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';

// class Register extends StatefulWidget {
//   const Register({super.key});

//   @override
//   State<Register> createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   final _emailcontroller = TextEditingController();
//   final _passwordcontroller = TextEditingController();
//   final _firstnamecontroller = TextEditingController();
//   final _lastnamecontroller = TextEditingController();
//   File? _profile_image_url;
//   bool _isLoading = false;

//   Future imagePicker(ImageSource source) async {
//     ImagePicker pick = ImagePicker();
//     final pickedFile = await pick.pickImage(source: source);
//     setState(() {
//       _profile_image_url = File(pickedFile!.path);
//     });
//   }

//   bool _obscureText = true;

//   // Future postUser(userid) async {

//   // Map<String, String> body = {
//   //       // 'name': _firstnamecontroller.text.trim(),
//   //       'email': _emailcontroller.text.trim(),
//   //       "username": _lastnamecontroller.text.trim(),
//   //       "userid": userid.toString(),
//   //       "business_uid":"jhbegf"
//   //     };
//   //     final url = Uri.parse('https://supernova1137.azurewebsites.net/pg/business');
//   //     // final jsonData = json.encode(body);

//   // String selectedGender = "";

//   Future signup() async {
//     setState(() {
//       _isLoading = true;
//     });

//     // print('Sign up clicked');
//     try {
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: _emailcontroller.text.trim(),
//           password: _passwordcontroller.text.trim());

//       final user = FirebaseAuth.instance.currentUser;
//       final userid = user?.uid;

//       Map<String, String> body = {
//         "name": _firstnamecontroller.text.trim(),
//         "email": _emailcontroller.text.trim(),
//         "username": _lastnamecontroller.text.trim(),
//         "userid": userid.toString(),
//         "business_account": "true"
//       };

//       final request = http.MultipartRequest(
//           "POST",
//           Uri.parse(
//             "$baseUrl/user",
//           ));
//       if (_profile_image_url != null) {
//         request.files.add(await http.MultipartFile.fromPath(
//             'profile_image_url', _profile_image_url!.path));
//       }
//       // ..files.add(await http.MultipartFile.fromPath('dp', _dp!.path))
//       request.fields.addAll(body);

//       final response = await request.send();
//       // print(response.statusCode);
//       // print(response);
//       if (response.statusCode == 200) {
//         final responseBody = await response.stream.bytesToString();
//         print(responseBody);
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//               builder: (context) =>
//                   redirection()), // Use redirection widget here
//         );
//         setState(() {
//           _isLoading = false;
//         });

//         //fetch data and store on provider
//         // userpro.userProvider();

//         // print('user created successfully');
//         return responseBody;
//       } else {
//         throw Exception('Failed to create user');
//       }
//     } on FirebaseAuthException catch (e) {
//       print(e);
//       showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               content: Text(e.message.toString()),
//             );
//           });
//     } catch (e) {
//       print(e.toString());
//       throw Exception('EXception Failed to create user : $e');
//     }
//   }

//   Gender? _selectedGender;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           elevation: 1,
//           backgroundColor: tgPrimaryColor,
//           leading: IconButton(
//             icon: Icon(
//               Icons.keyboard_arrow_left_rounded,
//               color: Colors.black,
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           title: const Text(
//             "Sign Up for a Business Account",
//             style: TextStyle(
//                 color: Colors.black87,
//                 fontSize: 17,
//                 fontWeight: FontWeight.w500),
//           )),
//       body: SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.only(top: 20),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   flex: 65,
//                   child: Container(
//                     // color: Colors.red,
//                     height: 150,
//                     child: Padding(
//                       padding: const EdgeInsets.all(14.0),
//                       child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             TextField(
//                               controller: _firstnamecontroller,
//                               decoration: InputDecoration(
//                                 contentPadding: EdgeInsets.all(10),
//                                 border: OutlineInputBorder(),
//                                 labelText: 'First name',
//                               ),
//                               autofocus: false,
//                               maxLines: null,
//                               keyboardType: TextInputType.text,
//                             ),
//                             TextField(
//                               controller: _lastnamecontroller,
//                               decoration: InputDecoration(
//                                 contentPadding: EdgeInsets.all(10),
//                                 border: OutlineInputBorder(),
//                                 labelText: 'Last name',
//                               ),
//                               autofocus: false,
//                               maxLines: null,
//                               keyboardType: TextInputType.text,
//                             ),
//                           ]),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     imagePicker(ImageSource.gallery);
//                   },
//                   child: Container(
//                     padding: EdgeInsets.all(10),
//                     color: Colors.grey[200],
//                     height: 150,
//                     child:
//                         // Image.network(
//                         // "https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg")
//                         _profile_image_url == null
//                             ? CircleAvatar(
//                                 radius: 50,
//                                 backgroundImage:
//                                     AssetImage("assets/defaulltdp.png"))
//                             : CircleAvatar(
//                                 radius: 50,
//                                 backgroundImage: FileImage(_profile_image_url!),
//                               ),
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(
//               height: 13,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildGenderOption(Gender.male, "Male"),
//                 _buildGenderOption(Gender.female, "Female"),
//                 _buildGenderOption(Gender.preferNotToSay, "prefer not to say")
//               ],
//             ),
//             SizedBox(
//               height: 6,
//             ),
//             const Divider(
//               height: 4,
//               thickness: 3,
//               color: secondaryColor10LightTheme,
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: TextField(
//                 controller: _emailcontroller,
//                 decoration: InputDecoration(
//                   contentPadding: EdgeInsets.all(10),
//                   border: OutlineInputBorder(),
//                   labelText: ' Email',
//                 ),
//                 autofocus: false,
//                 maxLines: null,
//                 keyboardType: TextInputType.emailAddress,
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: TextField(
//                 obscureText: _obscureText,
//                 controller: _passwordcontroller,
//                 decoration: InputDecoration(
//                     contentPadding: EdgeInsets.all(10),
//                     border: OutlineInputBorder(),
//                     labelText: 'Password',
//                     suffixIcon: IconButton(
//                       onPressed: () {
//                         setState(() {
//                           _obscureText = !_obscureText;
//                         });
//                       },
//                       icon: Icon(
//                         _obscureText ? Icons.visibility : Icons.visibility_off,
//                       ),
//                     )),
//                 autofocus: false,
//                 maxLines: 1,
//                 // expands:true,
//                 // minLines: 1,
//                 maxLength: 250,
//                 keyboardType: TextInputType.visiblePassword,
//               ),
//             ),
//           ],
//         ),
//       )),
//       bottomNavigationBar: InkWell(
//         onTap: () {
//           signup();
//           // navigatorPush(context,AddService() );
//           // navigatorPush(context,SearchLocationScreen() );
//         },
//         child: Container(
//           height: 55,
//           width: double.infinity,
//           color: tgAccentColor,
//           child: Center(
//               child: _isLoading
//                   ? Center(
//                       child: CircularProgressIndicator(
//                       backgroundColor: Colors.white,
//                     ))
//                   : Text(
//                       "Join",
//                       style: TextStyle(color: Colors.white, fontSize: 17),
//                     )),
//         ),
//       ),
//     );
//   }

//   Widget _buildGenderOption(Gender gender, String label) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedGender = gender;
//         });
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         decoration: BoxDecoration(
//             // borderRadius: BorderRadius.circular(16),
//             color: _selectedGender == gender
//                 ? tgLightPrimaryColor
//                 : Colors.grey[200]),
//         child: Text(label),
//       ),
//     );
//   }
// }

// enum Gender { male, female, preferNotToSay }

import 'dart:convert';
import 'dart:io';
import 'package:backendapp/register/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:backendapp/screens/redirection.dart';
import 'package:backendapp/utils/constants.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscurePassword = true;
  File? _profileImage;
  Gender? _selectedGender;

  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  // Future<void> signup() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   try {
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: _emailController.text.trim(),
  //       password: _passwordController.text.trim(),
  //     );

  //     final user = FirebaseAuth.instance.currentUser;
  //     final userid = user?.uid;

  //     Map<String, String> body = {
  //       "name": _nameController.text.trim(),
  //       "email": _emailController.text.trim(),
  //       "username": _usernameController.text.trim(),
  //       "userid": userid.toString(),
  //       "business_account": "true",
  //       "phone": _phoneController.text.trim(),
  //       "gender": _selectedGender?.toString() ?? "prefer_not_to_say",
  //     };

  //     final request = http.MultipartRequest(
  //       "POST",
  //       Uri.parse("$baseUrl/user"),
  //     );

  //     if (_profileImage != null) {
  //       request.files.add(await http.MultipartFile.fromPath(
  //         'profile_image_url',
  //         _profileImage!.path,
  //       ));
  //     }

  //     request.fields.addAll(body);

  //     final response = await request.send();

  //     if (response.statusCode == 200) {
  //       final responseBody = await response.stream.bytesToString();
  //       print(responseBody);
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => redirection()),
  //       );
  //     } else {
  //       throw Exception('Failed to create user');
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           content: Text(e.message.toString()),
  //         );
  //       },
  //     );
  //   } catch (e) {
  //     print(e.toString());
  //     throw Exception('Exception Failed to create user: $e');
  //   } finally {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }
  Future<void> signup() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Step 1: Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final user = userCredential.user;
      if (user == null) {
        throw Exception('Failed to create Firebase user');
      }

      final userid = user.uid;
      print("Firebase User Created: $userid");

      // Step 2: Prepare user data
      Map<String, String> body = {
        "name": _nameController.text.trim(),
        "email": _emailController.text.trim(),
        "username": _usernameController.text.trim(),
        "userid": userid,
        "business_account": "true",
        "phone": _phoneController.text.trim(),
        "gender": _selectedGender?.toString() ?? "prefer_not_to_say",
      };

      // Step 3: Prepare multipart request
      final request = http.MultipartRequest(
        "POST",
        Uri.parse("$baseUrl/user"),
      );

      if (_profileImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'profile_image_url',
          _profileImage!.path,
        ));
      }

      request.fields.addAll(body);

      // Step 4: Send request and handle response
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("User created successfully. Status code: ${response.statusCode}");
        print("Response body: $responseBody");

        // Parse the response to get the database user ID
        final Map<String, dynamic> responseData = json.decode(responseBody);
        final String dbUserId = responseData['_id'];
        print("Database User ID: $dbUserId");

        // Navigate to the next screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => redirection()),
        );
      } else {
        print("Failed to create user. Status code: ${response.statusCode}");
        print("Response body: $responseBody");
        throw Exception(
            'Failed to create user. Server responded with status code: ${response.statusCode}');
      }
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException: ${e.message}");
      showErrorDialog("Firebase Auth Error",
          e.message ?? "An error occurred during authentication");
    } catch (e) {
      print("Exception during signup: $e");
      showErrorDialog("Signup Error", e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      await signup();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tgPrimaryColor,
        title: const Text(
          'Join Us Today',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.keyboard_arrow_left_rounded),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 32),
                _buildProfileImagePicker(),
                const SizedBox(height: 32),
                _buildForm(),
                const SizedBox(height: 32),
                _buildSubmitButton(),
                const SizedBox(height: 16),
                _buildSignInLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
          child: Text(
            'Please fill in the information below',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.grey[700],
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImagePicker() {
    return Center(
      child: GestureDetector(
        onTap: _pickImage,
        child: CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey[200],
          backgroundImage:
              _profileImage != null ? FileImage(_profileImage!) : null,
          child: _profileImage == null
              ? Icon(Icons.add_a_photo, size: 30, color: Colors.grey[400])
              : null,
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            controller: _nameController,
            label: 'Full Name',
            icon: Icons.person_outline,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _usernameController,
            label: 'Username',
            icon: Icons.alternate_email,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a username';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _emailController,
            label: 'Email',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _passwordController,
            label: 'Password',
            icon: Icons.lock_outline,
            obscureText: _obscurePassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters long';
              }
              return null;
            },
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _phoneController,
            label: 'Phone Number',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          // _buildGenderDropdown(),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
    String? Function(String?)? validator,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        prefixIcon: Icon(icon, size: 20),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: const Color(0xFF1A3365)),
        ),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
    );
  }

  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<Gender>(
      value: _selectedGender,
      decoration: InputDecoration(
        labelText: 'Gender',
        prefixIcon: const Icon(Icons.people_outline),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: const Color(0xFF1A3365)),
        ),
      ),
      items: Gender.values
          .map((gender) => DropdownMenuItem(
              value: gender, child: Text(gender.toString().split('.').last)))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedGender = value;
        });
      },
      validator: (value) {
        if (value == null) {
          return 'Please select a gender';
        }
        return null;
      },
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1A3365),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                'Create Account',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
      ),
    );
  }

  Widget _buildSignInLink() {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login()));
        },
        child: Text(
          'Already have an account? Sign in',
          style: TextStyle(color: const Color(0xFF1A3365)),
        ),
      ),
    );
  }
}

enum Gender { male, female, preferNotToSay }
