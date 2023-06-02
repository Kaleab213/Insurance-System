import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/Insurance/bloc/insurance_bloc.dart';
import 'package:pro/Insurance/bloc/insurance_event.dart';
import 'package:pro/Insurance/bloc/insurance_state.dart';
import 'package:pro/Insurance/model/insurance_model.dart';
import 'package:pro/Insurance/view/Admin_insurance_list.dart';

void main() {
  late AdminInsuranceBloc insuranceBloc;
  late List<Insurance> mockInsuranceData;

  setUp(() {
    insuranceBloc = AdminInsuranceBloc();
    mockInsuranceData = [
      Insurance(
        id: '1',
        size: 100,
        location: 'Location 1',
        status: 'Status 1',
      ),
      Insurance(
        id: '2',
        size: 200,
        location: 'Location 2',
        status: 'Status 2',
      ),
    ];
  });

  tearDown(() {
    insuranceBloc.close();
  });

  testWidgets('AdminInsuranceListScreen Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: insuranceBloc,
          child: AdminInsuranceListScreen(),
        ),
      ),
    );

    // Set the initial state to InsuranceLoadingforAdmin
    insuranceBloc.add(InsuranceLoadingforAdmin() as InsuranceEvent);

    // Verify that the CircularProgressIndicator is shown
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Update the state to InsuranceDataLoadedforAdmin with mock data
    insuranceBloc.add(InsuranceDataLoadedforAdmin(mockInsuranceData) as InsuranceEvent);

    // Verify that the ListView.builder is shown with the correct number of items
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(mockInsuranceData.length));

    // Simulate tapping a list item
    await tester.tap(find.byType(ListTile).first);
    await tester.pumpAndSettle();

    // Verify that the navigation occurs
    expect(find.text('/admininsurancedetail'), findsOneWidget);

    // Simulate tapping the bottom navigation bar
    await tester.tap(find.byIcon(Icons.request_page_outlined));
    await tester.pumpAndSettle();

    // Verify that the navigation occurs
    expect(find.text('/admininsuranceList'), findsOneWidget);

    // Add your own assertions for the other navigation items if needed
  });
}
