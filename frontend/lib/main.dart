import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/Insurance/bloc/insurance_event.dart';
import 'package:pro/Insurance/bloc/insurance_bloc.dart';
import 'package:pro/Insurance/data_providers/API/API_insurance_data_provider.dart';
import 'package:pro/Insurance/model/insurance_model.dart';
import 'package:pro/Insurance/repository/insurance_repository.dart';

import 'package:pro/Insurance/view/add_item.dart';
import 'package:pro/Insurance/view/edit_item.dart';
import 'package:pro/Insurance/view/insurance_list.dart';
import 'package:pro/Insurance/view/item_detail.dart';
import 'package:pro/LocalStore/store.dart';
import 'package:pro/Notification/bloc/notification_bloc.dart';
import 'package:pro/Notification/bloc/notification_event.dart';
import 'package:pro/Notification/data_providers/notification_data_provider.dart';
import 'package:pro/Notification/repository/notification_repository.dart';
import 'package:pro/Notification/view/notificaion_view.dart';
import 'package:pro/auth/bloc/auth_bloc.dart';
import 'package:pro/auth/bloc/auth_event.dart';
import 'package:pro/auth/data_providers/auth_data_provider.dart';
import 'package:pro/auth/repository/information_repository.dart';
import 'package:pro/auth/view/auth/Admin_signup_page.dart';
import 'package:pro/auth/view/auth/sign_up.dart';
import 'package:pro/payment/bloc/payment_bloc.dart';
import 'package:pro/payment/bloc/payment_event.dart';
import 'package:pro/payment/data_providers/payment_data_provider.dart';
import 'package:pro/payment/repository/payment_repository.dart';
import 'package:pro/request/bloc/request_bloc.dart';
import 'package:pro/request/bloc/request_event.dart';
import 'package:pro/request/data_providers/request_data_provider.dart';
import 'package:pro/request/repository/request_repository.dart';
import 'package:pro/Insurance/view/Admin_insurance_list.dart';
import 'package:pro/request/view/add_item.dart';
import 'package:pro/request/view/request_list.dart';
import 'package:pro/screen/Admin/Admin_set_payment.dart';
import 'package:pro/user/user_exports.dart';
import 'auth/view/auth/Login_page.dart';
import 'payment/view/add_payment.dart';
import 'screen/Admin/Admin_insurance_detail.dart';

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
            AdminItemDetailScreen(insurance: state.extra as Insurance),
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

  @override
  Widget build(BuildContext context) {
    UserPreferences.init();
    return MultiBlocProvider(
      providers: [
        BlocProvider<InsuranceBloc>(
          create: (BuildContext context) => InsuranceBloc(
              insuranceRepository: InsuranceRepository(insuranceDataProvider))
            ..add(
              InsuranceLoad(),
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
