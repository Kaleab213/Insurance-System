import 'package:flutter/material.dart';
import '../../insurance.dart';
import 'Insurance_add.dart';
import 'Insurance_details.dart';
import 'Insurance_list.dart';

class InsuranceAppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => InsuranceList());
    }

    if (settings.name == AddUpdateInsurance.routeName) {
      InsuranceArgument? args = settings.arguments as InsuranceArgument?;
      return MaterialPageRoute(
        builder: (context) => AddUpdateInsurance(args: args),
      );
    }

    if (settings.name == InsuranceDetail.routeName) {
      Insurance? insurance = settings.arguments as Insurance?;
      return MaterialPageRoute(
        builder: (context) => InsuranceDetail(insurance: insurance!),
      );
    }

    return MaterialPageRoute(builder: (context) => InsuranceList());
  }
}

class InsuranceArgument {
  final Insurance insurance;
  final bool edit;
  InsuranceArgument({required this.insurance, required this.edit});
}
