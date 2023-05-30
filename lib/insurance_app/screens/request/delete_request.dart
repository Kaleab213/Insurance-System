import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/blocs.dart';
import '../../models/request.dart';

class DeleteRequest extends StatefulWidget {
  static const routeName = 'requestDelete';
  @override
  _DeleteRequestState createState() => _DeleteRequestState();
}

class _DeleteRequestState extends State<DeleteRequest> {
  bool _isChecked = false;
  String _password = '';
  String userPassword = "1111";
  late final Request request;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Delete Coverage Request'),
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
                  'By cancelling my Coverage Request, I acknowledge and accept that I will no longer be covered for any damages or losses mentioned in the coverage request I am deleting currently. I understand that I will not be entitled to any funds for any damages mentioned in the coverage request after the cancellation of the request. I also acknowledge that I am responsible for the damages or losses that may have occurred before the coverage request has been cancelled, and that I will not hold the insurance company liable for any such damages or losses. I confirm that I have read and understood the terms and conditions of my insurance policy regarding cancellation and that I am making this decision of my own free will.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Material(
                      child: Checkbox(
                        value: _isChecked,
                        onChanged: (bool? newValue) {
                          setState(() {
                            _isChecked = newValue!;
                          });
                        },
                      ),
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
                Material(
                  child: TextField(
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
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: _isChecked && (_password == userPassword)
                        ? () {
                            BlocProvider.of<RequestBloc>(context)
                                .add(RequestDelete(request.coverage_id ?? 0));
                            // Navigator.of(context).pushNamedAndRemoveUntil(
                            //     CoursesList.routeName, (route) => false);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent,
                      onSurface: Colors.grey,
                      minimumSize: const Size(180, 55),
                    ),
                    child: const Text(
                      'Delete Request',
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
