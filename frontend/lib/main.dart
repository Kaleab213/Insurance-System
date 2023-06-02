import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/payment/view/payment_list.dart';
import 'Insurance/bloc/insurance_bloc.dart';
import 'Insurance/bloc/insurance_event.dart';
import 'Insurance/data_providers/API/API_insurance_data_provider.dart';
import 'Insurance/data_providers/local_storage/DB_insurance_data_provider.dart';
import 'Insurance/model/insurance_model.dart';
import 'Insurance/repository/insurance_repository.dart';
import 'Insurance/view/Admin_insurance_list.dart';
import 'Insurance/view/add_item.dart';
import 'Insurance/view/approval_insurance.dart';
import 'Insurance/view/edit_item.dart';
import 'Insurance/view/insurance_list.dart';
import 'Insurance/view/item_detail.dart';
import 'LocalStore/store.dart';
import 'Notification/bloc/notification_bloc.dart';
import 'Notification/bloc/notification_event.dart';
import 'Notification/data_providers/notification_data_provider.dart';
import 'Notification/repository/notification_repository.dart';
import 'auth/bloc/auth_bloc.dart';
import 'auth/bloc/auth_event.dart';
import 'auth/data_providers/auth_data_provider.dart';
import 'auth/repository/information_repository.dart';
import 'auth/view/auth/Admin_signup_page.dart';
import 'auth/view/auth/Login_page.dart';
import 'auth/view/auth/sign_up.dart';
import 'payment/bloc/payment_bloc.dart';
import 'payment/bloc/payment_event.dart';
import 'payment/data_providers/payment_data_provider.dart';
import 'payment/repository/payment_repository.dart';
import 'payment/view/add_payment.dart';
import 'request/bloc/request_bloc.dart';
import 'request/bloc/request_event.dart';
import 'request/data_providers/request_data_provider.dart';
import 'request/model/request_model.dart';
import 'request/repository/request_repository.dart';
import 'request/view/add_item.dart';
import 'request/view/edit_item.dart';
import 'request/view/request_list.dart';
import 'Insurance/view/Admin_insurance_detail.dart';
import 'user/bloc/user_bloc.dart';
import 'user/bloc/user_event.dart';
import 'user/data_providers/user_data_provider.dart';
import 'user/repository/information_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final gorouter = GoRouter(
    initialLocation: "/",
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: "/signup",
        builder: (context, state) => SignUpPage(),
      ),
      GoRoute(
        path: "/adminsignup",
        builder: (context, state) => AdminSignUpPage(),
      ),
      GoRoute(
        path: "/insuranceList",
        builder: (context, state) => InsuranceListScreen(),
      ),
       GoRoute(
        path: "/paymentList",
        builder: (context, state) => PaymentListScreen(),
      ),
      GoRoute(
        path: "/requestList",
        builder: (context, state) => RequestListScreen(),
      ),
      GoRoute(
        path: "/admininsuranceList",
        builder: (context, state) => AdminInsuranceListScreen(),
      ),
      GoRoute(
        path: "/addinsurance",
        builder: (context, state) => AddItemScreen(),
      ),
      
      GoRoute(
        path: "/addrequest",
        builder: (context, state) => AddRequestScreen(),
      ),
      GoRoute(
        path: "/payment",
        builder: (context, state) => AddPayment(),
      ),
      GoRoute(
        path: "/insurancedetail",
        builder: (context, state) =>
            ItemDetailScreen(state.extra as Insurance),
      ),
      GoRoute(
        path: "/admininsurancedetail",
        builder: (context, state) =>
            AdminItemDetailScreen(state.extra as Insurance),
      ),
      GoRoute(
        path: "/approval",
        builder: (context, state) =>
            ApprovalPage(state.extra as Insurance),
      ),

      // GoRoute(
      //   path: "/setpayment",
      //   builder: (context, state) => setPayment(),
      // ),
      // GoRoute(
      //   path: "/mynotification",
      //   builder: (context, state) =>  NotificationListScreen(userID: ),
      // ),
      GoRoute(
        path: "/editinsurance",
        builder: (context, state) =>
            EditItemScreen(item: state.extra as Insurance),
      ),
      GoRoute(
        path: "/editrequest",
        builder: (context, state) =>
            RequestEditScreen(item: state.extra as Request),
      ),
      GoRoute(
        path: "/error",
        pageBuilder: (context, state) => MaterialPage(
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Error page"),
            ),
            body: Center(
              child: Center(
                child: Column(
                  children: [
                    const Text("You don't have account"),
                    ElevatedButton(
                      child: const Text("back"),
                      onPressed: () {
                        context.go("/");
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
  final InsuranceDataProvider insuranceDataProvider = InsuranceDataProvider();
  final NotificationDataProvider notificationdataProvider =
      NotificationDataProvider();
  final UserDataProvider userDataProvider = UserDataProvider();
  final PaymentDataProvider paymentDataProvide = PaymentDataProvider();
  final RequestDataProvider requestDataProvider = RequestDataProvider();
  final AuthDataProvider authDataProvider = AuthDataProvider();
  final InsuranceDbHelper insurancedbHelper = InsuranceDbHelper();

  @override
  Widget build(BuildContext context) {
    UserPreferences.init();
    insurancedbHelper.openDb();
    return MultiBlocProvider(
      providers: [
        BlocProvider<InsuranceBloc>(
          create: (BuildContext context) => InsuranceBloc(
              insuranceRepository: InsuranceRepository(insuranceDataProvider,insurancedbHelper))
            ..add(
              InsuranceLoad(),
            ),
        ),
        BlocProvider<AdminInsuranceBloc>(
          create: (BuildContext context) => AdminInsuranceBloc(
              insuranceRepository: InsuranceRepository(insuranceDataProvider,insurancedbHelper))
            ..add(
              InsuranceLoadforAdmin(),
            ),
        ),
        BlocProvider<RequestBloc>(
          create: (BuildContext context) => RequestBloc(
              requestRepository: RequestRepository(requestDataProvider))
            ..add(
              RequestLoad(),
            ),
        ),
        BlocProvider<UserBloc>(
          create: (BuildContext context) =>
              UserBloc(userRepository: UserRepository(userDataProvider))
                ..add(
                  UserLoad(),
                ),
        ),
        BlocProvider<PaymentBloc>(
          create: (BuildContext context) => PaymentBloc(
              paymentRepository: PaymentRepository(paymentDataProvide))
            ..add(PaymentLoad()),
        ),
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(
              authRepository: AuthRepository(authDataProvider))
            ..add(AuthLoad()),
        ),
        BlocProvider<NotificationBloc>(
          create: (BuildContext context) => NotificationBloc(
              notificationRepository:
                  NotificationRepository(notificationdataProvider))
            ..add(NotificationLoad()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerDelegate: gorouter.routerDelegate,
        routeInformationParser: gorouter.routeInformationParser,
        routeInformationProvider: gorouter.routeInformationProvider,
      ),
    );
  }
}
