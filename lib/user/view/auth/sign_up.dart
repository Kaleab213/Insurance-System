import 'package:flutter/material.dart';

class SignUpPages extends StatelessWidget {
  SignUpPages({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // ignore: non_constant_identifier_names
  final TextEditingController _FirstnameController = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController _LastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _kebeleController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passswordConfirmationController =
      TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      // Clear the form fields after submission
      _emailController.clear();
      _passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign Up",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Roboto',
          ),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Color.fromARGB(255, 99, 237, 232),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _FirstName(_FirstnameController),
                  const SizedBox(height: 16.0),
                  _LastName(_LastnameController),
                  const SizedBox(height: 16.0),
                  _email(_emailController),
                  const SizedBox(height: 16.0),
                  _phoneNumber(_phoneNumberController),
                  const SizedBox(height: 16.0),
                   _accountNumber(_accountNumberController),
                  const SizedBox(height: 16.0),
                   _kebele(_kebeleController),
                  const SizedBox(height: 16.0),
                  _Password(_passwordController),
                  const SizedBox(height: 16.0),
                  _ConfirmPassword(_passswordConfirmationController),
                  const SizedBox(height: 32.0),
                  Signup(_submitForm),
                ],
              ),
            )),
      ),
    );
  }
}

Widget _FirstName(nameController) {
  return TextFormField(
    controller: nameController,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Please enter your first name';
      }
      return null;
    },
    decoration: const InputDecoration(
        labelText: 'First Name', prefixIcon: Icon(Icons.person)),
  );
}

Widget _LastName(nameController) {
  return TextFormField(
    controller: nameController,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Please enter your last name';
      }
      return null;
    },
    decoration: const InputDecoration(
        labelText: 'Last Name', prefixIcon: Icon(Icons.person)),
  );
}
Widget _phoneNumber(phoneNumberController) {
  return TextFormField(
    controller: phoneNumberController,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Please enter your phone number';
      }
      if (!RegExp(r"^\+?[1-9]\d{1,14}$").hasMatch(value)) {
        return 'Please enter a valid phone number';
      }
      return null;
    },
    keyboardType: TextInputType.phone,
    decoration: const InputDecoration(
        labelText: 'Phone Number', prefixIcon: Icon(Icons.phone)),
  );
}
Widget _accountNumber(accountNumberController) {
  return TextFormField(
    controller: accountNumberController,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Please enter your account number';
      }
      return null;
    },
    keyboardType: TextInputType.number,
    decoration: const InputDecoration(
        labelText: 'Account Number', prefixIcon: Icon(Icons.account_balance)),
  );
}
Widget _kebele(kebeleController) {
  return TextFormField(
    controller: kebeleController,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Please enter your kebele name';
      }
      return null;
    },
    keyboardType: TextInputType.text,
    decoration: const InputDecoration(
        labelText: 'Kebele Name', prefixIcon: Icon(Icons.location_city)),
  );
}
Widget _email(emailController) {
  return TextFormField(
    controller: emailController,
    validator: (value) {
      if (value!.isEmpty) {
        return "please enter your email";
      }
      return null;
    },
    decoration: const InputDecoration(
        labelText: 'Email', prefixIcon: Icon(Icons.email)),
  );
}

Widget _Password(passwordController) {
  return TextFormField(
    controller: passwordController,
    validator: (value) {
      if (value!.isEmpty) {
        return "please enter your password";
      }
      return null;
    },
    obscureText: true,
    decoration: const InputDecoration(
        labelText: 'Password', prefixIcon: Icon(Icons.lock)),
  );
}

Widget _ConfirmPassword(passswordConfirmationController) {
  return TextFormField(
    controller: passswordConfirmationController,
    validator: (value) {
      if (value!.isEmpty) {
        return "please confirm your password";
      }
      return null;
    },
    obscureText: true,
    decoration: const InputDecoration(
        labelText: 'Confirm Password', prefixIcon: Icon(Icons.lock)),
  );
}

Widget Signup(submitForm) {
  return ElevatedButton(
      onPressed: submitForm,
      child: const Text(
        'Sign Up',
        style: TextStyle(
          fontFamily: 'Roboto',
        ),
      ));
}
