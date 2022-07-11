import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/util/shared_preferences_manager.dart';
import 'package:flutter_news_app/feature/presentation/page/login/login_page.dart';
import 'package:flutter_news_app/injection_container.dart';

class DashboardPage extends StatefulWidget {
  static const routeName = '/dashboard_page';

  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final sharedPreferencesManager = sl<SharedPreferencesManager>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await sharedPreferencesManager.clearAll();
            if (mounted) {
              Navigator.pushReplacementNamed(context, LoginPage.routeName);
            }
          },
          child: Text('sign_out'.tr()),
        ),
      ),
    );
  }
}
