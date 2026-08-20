import 'package:flutter/material.dart';
import 'package:login_biometrics_app/core/constants/app_colors.dart';

class AppThemes {
  AppThemes._();

  static const textSelectionTheme = TextSelectionThemeData(
    cursorColor: AppColors.primary,
    selectionColor: AppColors.secondary,
    selectionHandleColor: Colors.deepPurple
  );

  // -------------------------------------------------------------
  // LIGHT THEME CONFIGURATION
  // -------------------------------------------------------------
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: .light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      
      // Pengaturan Warna Utama Material 3
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.danger,
      ),

      // Konfigurasi AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary, // Warna icon/teks
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        titleTextStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: .w600,
        ),
      ),

      // Konfigurasi Default TextFormField (Minimalis seperti sebelumnya)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.blueGrey.shade50,
        hintStyle: TextStyle(color: Colors.grey.shade700),
        contentPadding: const .symmetric(horizontal: 20, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: .circular(14),
          borderSide: BorderSide(color: Colors.blueGrey.shade100),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: .circular(14),
          borderSide: BorderSide(color: Colors.blueGrey.shade100),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: .circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: .circular(14),
          borderSide: const BorderSide(color: AppColors.danger, width: 1.5),
        ),
      ),

      textSelectionTheme: textSelectionTheme,

      // Konfigurasi Default Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const .symmetric(vertical: 12),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          disabledBackgroundColor: Colors.grey.shade300,
          disabledForegroundColor: Colors.grey.shade500,
          shape: RoundedRectangleBorder(
            borderRadius: .circular(14)
          )
        )
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const .symmetric(vertical: 12),
          foregroundColor: AppColors.primary,
          disabledBackgroundColor: Colors.grey.shade300,
          disabledForegroundColor: Colors.grey.shade500,
          side: const BorderSide(width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: .circular(14)
          )
        )
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const .symmetric(vertical: 12),
          foregroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: .circular(14)
          )
        )
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          // backgroundColor: AppColors.primary,
          // foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: .circular(14)
          )
        ),
      ),

      // Konfigurasi Checkbox
      checkboxTheme: const CheckboxThemeData(
        checkColor: WidgetStatePropertyAll(AppColors.secondary),
        side: BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: .all(.circular(5))
        )
      ),

      // Konfigurasi Default Card
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 2,
        shadowColor: Colors.black38,
        shape: RoundedRectangleBorder(
          borderRadius: .circular(16),
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // DARK THEME CONFIGURATION (Opsional jika aplikasi support Dark Mode)
  // -------------------------------------------------------------
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: .dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surfaceDark,
        error: AppColors.danger,
      ),

      // Konfigurasi AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: AppColors.textPrimaryVariant, // Warna icon/teks
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.textPrimaryVariant),
        titleTextStyle: TextStyle(
          color: AppColors.textPrimaryVariant,
          fontSize: 18,
          fontWeight: .w600,
        ),
      ),

      textSelectionTheme: textSelectionTheme,

      // Konfigurasi Default TextFormField (Minimalis seperti sebelumnya)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.blueGrey.shade900,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        contentPadding: const .symmetric(horizontal: 20, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: .circular(14),
          borderSide: BorderSide(color: Colors.blueGrey.shade800),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: .circular(14),
          borderSide: BorderSide(color: Colors.blueGrey.shade800),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: .circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: .circular(14),
          borderSide: const BorderSide(color: AppColors.danger, width: 1.5),
        ),
      ),

      // Konfigurasi Default Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const .symmetric(vertical: 12),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          disabledBackgroundColor: Colors.grey.shade300,
          disabledForegroundColor: Colors.grey.shade500,
          shape: RoundedRectangleBorder(
            borderRadius: .circular(14)
          )
        )
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const .symmetric(vertical: 12),
          foregroundColor: AppColors.primary,
          disabledBackgroundColor: Colors.grey.shade300,
          disabledForegroundColor: Colors.grey.shade500,
          side: const BorderSide(width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: .circular(14)
          )
        )
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const .symmetric(vertical: 12),
          foregroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: .circular(14)
          )
        )
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          // backgroundColor: AppColors.primary,
          // foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: .circular(14)
          )
        ),
      ),
    );
  }
}