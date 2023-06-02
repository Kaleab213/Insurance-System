import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/Insurance/bloc/insurance_state.dart';
import 'package:pro/Insurance/view/add_item.dart';
import 'package:pro/Insurance/view/insurance_list.dart';
import 'package:pro/Insurance/view/item_detail.dart';
import 'package:your_app_name/bloc/insurance_bloc.dart';
import 'package:your_app_name/bloc/insurance_state.dart';
import 'package:your_app_name/model/insurance_model.dart';
import 'package:your_app_name/screen/add_item.dart';
import 'package:your_app_name/screen/item_detail.dart';
import 'package:your_app_name/screen/insurance_list_screen.dart';

void main() {
  late InsuranceBloc insuranceBloc;

  setUp(() {
    insuranceBloc = InsuranceBloc();
  });

  testWidgets('InsuranceListScreen Widget Test', (WidgetTester tester) async {
    // Create a mock list of insurance items
    final List<Insurance> mockItems = [
      Insurance(id: '1', size: 100, location: 'Location 1', status: 'Active'),
      Insurance(id: '2', size: 200, location: 'Location 2', status: 'Inactive'),
    ];

    // Define the mock routes for navigation
    final mockRoutes = {
      '/addinsurance': (BuildContext context) => AddItemScreen(),
      '/insurancedetail': (BuildContext context) => ItemDetailScreen(),
    };

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<InsuranceBloc>.value(
          value: insuranceBloc,
          child: GoRouter(
            routes: mockRoutes,
            initialLocation: '/insuranceList',
            child: InsuranceListScreen(),
          ),
        ),
      ),
    );

    // Verify loading state
    insuranceBloc.emit(InsuranceLoading());
    await tester.pumpAndSettle();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Verify loaded state with items
    insuranceBloc.emit(InsuranceDataLoaded(insurances: mockItems));
    await tester.pumpAndSettle();

    expect(find.text('Insurance List'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.text('No item'), findsNothing);

    // Verify the list of insurance items
    expect(find.byType(Card), findsNWidgets(mockItems.length));
    expect(find.text(mockItems[0].id!), findsOneWidget);
    expect(find.text(mockItems[0].location), findsOneWidget);
    expect(find.text(mockItems[0].size.toString()), findsOneWidget);
    expect(find.text(mockItems[0].status), findsOneWidget);

    // Simulate tapping on an insurance item
    await tester.tap(find.text(mockItems[0].id!));
    await tester.pumpAndSettle();

    // Verify navigation to ItemDetailScreen
    expect(find.byType(ItemDetailScreen), findsOneWidget);

    // Simulate tapping on the Add button
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Verify navigation to AddItemScreen
    expect(find.byType(AddItemScreen), findsOneWidget);
  });
}
