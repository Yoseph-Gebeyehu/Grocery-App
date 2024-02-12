import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:grocery/data/local/shered_preference.dart';
import 'package:grocery/domain/constants/thems/theme.dart';

import 'presentation/shopping-cart/bloc/shopping_cart_bloc.dart';
import 'presentation/Auth/bloc/auth_bloc.dart';
import 'presentation/base-home-page/bloc/base_home_page_bloc.dart';
import 'presentation/Home/bloc/home_bloc.dart';
import 'presentation/transaction-history/bloc/transaction_history_bloc.dart';
import 'domain/Constants/router/app_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLanguage(BuildContext context) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.onGetAppLanguge();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? currentLanguage = "en";
  final AppRoute _appRoute = AppRoute();

  @override
  void initState() {
    super.initState();
    onGetAppLanguge();
  }

  onGetAppLanguge() async {
    String? lang = await LocalStorage.getLanguage('language');
    setState(() {
      currentLanguage = lang;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: AppTheme().lightTheme(),
      dark: AppTheme().darkTheme(),
      initial: AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeBloc(),
          ),
          BlocProvider(
            create: (context) => BaseHomePageBloc(),
          ),
          BlocProvider(
            create: (context) => AuthBloc(),
          ),
          BlocProvider(
            create: (context) => ShoppingCartBloc(),
          ),
          BlocProvider(
            create: (context) => TransactionHistoryBloc(),
          ),
        ],
        child: MaterialApp(
          theme: theme,
          darkTheme: darkTheme,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: _appRoute.onGenerateRoute,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: currentLanguage != null ? Locale(currentLanguage!) : null,
        ),
      ),
    );
  }
}
