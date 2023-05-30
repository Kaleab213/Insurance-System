import 'package:flutter/material.dart';

class DeleteInsurancePage extends StatefulWidget {
  @override
  _DeleteInsurancePageState createState() => _DeleteInsurancePageState();
}

class _DeleteInsurancePageState extends State<DeleteInsurancePage> {
  bool _isChecked = false;
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Delete Insurance'),
            centerTitle: true,
            backgroundColor: Colors.redAccent,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'IMPORTANT: Please read the following condition before proceeding:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'By cancelling my home insurance policy, I acknowledge and accept that I will no longer be covered for any damages or losses related to my home, belongings, or property. I understand that I will not be entitled to any refunds or reimbursements for any premiums paid prior to the cancellation of the policy. I also acknowledge that I am responsible for any damages or losses that may occur after the policy has been cancelled, and that I will not hold the insurance company liable for any such damages or losses. I confirm that I have read and understood the terms and conditions of my insurance policy regarding cancellation and that I am making this decision of my own free will.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _isChecked = newValue!;
                        });
                      },
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isChecked = !_isChecked;
                          });
                        },
                        child: const Text(
                          'I have read and accepted the condition.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed:
                        _isChecked && _password.isNotEmpty ? () {} : null,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent,
                      onSurface: Colors.grey,
                      minimumSize: const Size(180, 55),
                    ),
                    child: const Text(
                      'Delete Insurance',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
