import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/util/images.dart';
import 'package:flutter_news_app/core/util/shared_preferences_manager.dart';
import 'package:flutter_news_app/feature/presentation/page/dashboard/dashboard_page.dart';
import 'package:flutter_news_app/injection_container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login_page';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final firebaseAuth = FirebaseAuth.instance;
  final sharedPreferencesManager = sl<SharedPreferencesManager>();

  var heightScreen = 0.0;
  var paddingBottom = 0.0;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    heightScreen = mediaQueryData.size.height;
    paddingBottom = mediaQueryData.padding.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          buildWidgetBackgroundImage(),
          buildWidgetOverlayBackgroundImage(),
          buildWidgetForm(),
        ],
      ),
    );
  }

  Widget buildWidgetForm() {
    return Column(
      children: [
        Container(
          height: heightScreen / 1.8,
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: paddingBottom + 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'smart_news_for_smart_people'.tr(),
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        fontSize: 28,
                      ),
                  maxLines: 3,
                ),
                const SizedBox(height: 8),
                Text(
                  'get_started_by_sign_in_now'.tr(),
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: Colors.grey,
                      ),
                ),
                const SizedBox(height: 16),
                buildWidgetButtonSignIn(
                  'sign_in_with_google'.tr(),
                  const Color(0xFFFC2F1E),
                  FontAwesomeIcons.google,
                  onPressed: () async {
                    final userCredential = await signInWithGoogle();
                    sharedPreferencesManager.putBool(SharedPreferencesManager.keyIsLogin, true);
                    sharedPreferencesManager.putString(
                      SharedPreferencesManager.keyProfilePicture,
                      userCredential.user?.photoURL ?? '-',
                    );
                    sharedPreferencesManager.putString(
                      SharedPreferencesManager.keyDisplayName,
                      userCredential.user?.displayName ?? '-',
                    );
                    sharedPreferencesManager.putString(
                      SharedPreferencesManager.keyEmail,
                      userCredential.user?.email ?? '-',
                    );
                    await firebaseAuth.signOut();
                    if (mounted) {
                      Navigator.pushReplacementNamed(context, DashboardPage.routeName);
                    }
                  },
                ),
                buildWidgetButtonSignIn(
                  'sign_in_with_twitter'.tr(),
                  const Color(0xFF6BAAE8),
                  FontAwesomeIcons.twitter,
                  onPressed: () {
                    // TODO: Buat fitur sign in with twitter
                  },
                ),
                buildWidgetButtonSignIn(
                  'sign_in_with_github'.tr(),
                  const Color(0xFF191717),
                  FontAwesomeIcons.github,
                  onPressed: () {
                    // TODO: Buat fitur sign in with Github
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildWidgetButtonSignIn(
    String text,
    Color backgroundColor,
    IconData icon, {
    required Function() onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: backgroundColor,
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                icon,
                color: Colors.white,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildWidgetOverlayBackgroundImage() {
    return Positioned(
      left: 0,
      top: 0,
      right: 0,
      child: Container(
        width: double.infinity,
        height: heightScreen / 1.8,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.white.withOpacity(0.8),
              Colors.white,
            ],
            stops: const [
              0.0,
              0.8,
              1.0,
            ],
          ),
        ),
      ),
    );
  }

  Widget buildWidgetBackgroundImage() {
    return Positioned(
      left: 0,
      top: 0,
      right: 0,
      child: Container(
        height: heightScreen / 1.8,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.white.withOpacity(.5),
              Colors.white,
            ],
            stops: const [
              0.0,
              0.5,
              1,
            ],
          ),
        ),
        child: Image.asset(
          AssetsImage.newspaper,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await firebaseAuth.signInWithCredential(credential);
  }
}
