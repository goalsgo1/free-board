import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:free_board/firebase_options.dart';
import 'package:free_board/providers/accessibility_provider.dart';
import 'package:free_board/providers/auth_provider.dart';
import 'package:free_board/providers/post_provider.dart';
import 'package:free_board/providers/comment_provider.dart';
import 'package:free_board/providers/memorial_provider.dart';
import 'package:free_board/screens/app/app_screens.dart';
import 'package:free_board/screens/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 2,
      ),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AccessibilityProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => PostProvider()),
        ChangeNotifierProvider(create: (_) => CommentProvider()),
        ChangeNotifierProvider(create: (_) => MemorialProvider()),
      ],
      child: Consumer<AccessibilityProvider>(
        builder: (context, accessibility, child) {
          final theme = baseTheme.copyWith(
            textTheme: accessibility.modifyTextTheme(baseTheme.textTheme),
          );

          return MaterialApp(
            title: '기억의 정원',
            debugShowCheckedModeBanner: false,
            theme: theme,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ko', 'KR'),
              Locale('en', 'US'),
            ],
            locale: const Locale('ko', 'KR'),
            builder: (context, child) {
              final mediaQuery = MediaQuery.of(context);
              return MediaQuery(
                data: mediaQuery.copyWith(
                  textScaler: TextScaler.linear(accessibility.textScale),
                  boldText: accessibility.boldText,
                ),
                child: child ?? const SizedBox.shrink(),
              );
            },
            routes: appRouteBuilders,
            home: const AuthWrapper(),
          );
        },
      ),
    );
  }
}

// 인증 상태에 따라 화면을 보여주는 래퍼
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        // 로딩 중
        if (authProvider.isLoading && authProvider.currentUser == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        
        // 로그인 여부 확인
        if (authProvider.isAuthenticated) {
          return const HomeScreen();
        }
        return const AuthScreen();
      },
    );
  }
}
