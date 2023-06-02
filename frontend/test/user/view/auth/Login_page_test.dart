import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro/user/model/user_model.dart';

import '../../../auth/view/auth/sign_up.dart';
import '../../bloc/user_bloc.dart';
import '../../bloc/user_event.dart';
import '../../user_exports.dart';
import '../login_pages.dart';

void main() {
  late UserBloc userBloc;

  setUp(() {
    userBloc = UserBloc();
  });

  testWidgets('LoginPages Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<UserBloc>.value(
          value: userBloc,
          child: LoginPages(),
        ),
      ),
    );

    // Verify the presence of form fields and buttons
    expect(find.text('LOGIN'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text("Don't have an account? Sign up"), findsOneWidget);

    // Simulate entering values in the form fields
    await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'password');

    // Simulate tapping the LOGIN button
    await tester.tap(find.text('LOGIN'));
    await tester.pumpAndSettle();

    // Verify the state and navigation
    expect(userBloc.state, isA<UserCreate>());
    expect(find.text('Error'), findsNothing);
  });

  testWidgets('CreateAccount Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<UserBloc>.value(
          value: userBloc,
          child: Builder(
            builder: (BuildContext context) {
              return Scaffold(
                body: CreateAccount(context),
              );
            },
          ),
        ),
      ),
    );

    // Simulate tapping the "Don't have an account? Sign up" text
    await tester.tap(find.text("Don't have an account? Sign up"));
    await tester.pumpAndSettle();

    // Verify the navigation
    expect(find.byType(SignUpPage), findsOneWidget);
  });
}
