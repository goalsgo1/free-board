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
        seedColor: const Color(0xFF8B7355), // warmBrown
        brightness: Brightness.light,
        primary: const Color(0xFF8B7355),
        secondary: const Color(0xFFF5F1E8), // warmBeige
        surface: const Color(0xFFFFF8F0), // softCream
        background: const Color(0xFFFFF8F0),
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFFFF8F0), // softCream
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFF8B7355), // warmBrown
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withOpacity(0.95),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFF5F1E8), width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFF5F1E8), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF8B7355), width: 2.0),
        ),
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
            title: '추억의 정원',
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
