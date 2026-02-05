import 'package:flutter/material.dart';

/// App localization support
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'app_name': 'Mobile Template',
      'login': 'Login',
      'register': 'Register',
      'email': 'Email',
      'password': 'Password',
      'confirm_password': 'Confirm Password',
      'forgot_password': 'Forgot Password?',
      'dont_have_account': "Don't have an account?",
      'already_have_account': 'Already have an account?',
      'sign_up': 'Sign Up',
      'sign_in': 'Sign In',
      'logout': 'Logout',
      'home': 'Home',
      'profile': 'Profile',
      'settings': 'Settings',
      'cancel': 'Cancel',
      'confirm': 'Confirm',
      'save': 'Save',
      'delete': 'Delete',
      'edit': 'Edit',
      'loading': 'Loading...',
      'error': 'Error',
      'success': 'Success',
      'retry': 'Retry',
      'no_internet': 'No internet connection',
      'something_went_wrong': 'Something went wrong',
      // Validation messages
      'email_required': 'Email is required',
      'email_invalid': 'Please enter a valid email',
      'password_required': 'Password is required',
      'password_min_length': 'Password must be at least 8 characters',
      'passwords_not_match': 'Passwords do not match',
    },
    'ar': {
      'app_name': 'قالب موبايل',
      'login': 'تسجيل الدخول',
      'register': 'تسجيل',
      'email': 'البريد الإلكتروني',
      'password': 'كلمة المرور',
      'confirm_password': 'تأكيد كلمة المرور',
      'forgot_password': 'نسيت كلمة المرور؟',
      'dont_have_account': 'ليس لديك حساب؟',
      'already_have_account': 'لديك حساب بالفعل؟',
      'sign_up': 'إنشاء حساب',
      'sign_in': 'تسجيل الدخول',
      'logout': 'تسجيل الخروج',
      'home': 'الرئيسية',
      'profile': 'الملف الشخصي',
      'settings': 'الإعدادات',
      'cancel': 'إلغاء',
      'confirm': 'تأكيد',
      'save': 'حفظ',
      'delete': 'حذف',
      'edit': 'تعديل',
      'loading': 'جاري التحميل...',
      'error': 'خطأ',
      'success': 'نجاح',
      'retry': 'إعادة المحاولة',
      'no_internet': 'لا يوجد اتصال بالإنترنت',
      'something_went_wrong': 'حدث خطأ ما',
      // Validation messages
      'email_required': 'البريد الإلكتروني مطلوب',
      'email_invalid': 'يرجى إدخال بريد إلكتروني صحيح',
      'password_required': 'كلمة المرور مطلوبة',
      'password_min_length': 'يجب أن تكون كلمة المرور 8 أحرف على الأقل',
      'passwords_not_match': 'كلمات المرور غير متطابقة',
    },
  };

  String get appName => _localizedValues[locale.languageCode]!['app_name']!;
  String get login => _localizedValues[locale.languageCode]!['login']!;
  String get register => _localizedValues[locale.languageCode]!['register']!;
  String get email => _localizedValues[locale.languageCode]!['email']!;
  String get password => _localizedValues[locale.languageCode]!['password']!;
  String get confirmPassword =>
      _localizedValues[locale.languageCode]!['confirm_password']!;
  String get forgotPassword =>
      _localizedValues[locale.languageCode]!['forgot_password']!;
  String get dontHaveAccount =>
      _localizedValues[locale.languageCode]!['dont_have_account']!;
  String get alreadyHaveAccount =>
      _localizedValues[locale.languageCode]!['already_have_account']!;
  String get signUp => _localizedValues[locale.languageCode]!['sign_up']!;
  String get signIn => _localizedValues[locale.languageCode]!['sign_in']!;
  String get logout => _localizedValues[locale.languageCode]!['logout']!;
  String get home => _localizedValues[locale.languageCode]!['home']!;
  String get profile => _localizedValues[locale.languageCode]!['profile']!;
  String get settings => _localizedValues[locale.languageCode]!['settings']!;
  String get cancel => _localizedValues[locale.languageCode]!['cancel']!;
  String get confirm => _localizedValues[locale.languageCode]!['confirm']!;
  String get save => _localizedValues[locale.languageCode]!['save']!;
  String get delete => _localizedValues[locale.languageCode]!['delete']!;
  String get edit => _localizedValues[locale.languageCode]!['edit']!;
  String get loading => _localizedValues[locale.languageCode]!['loading']!;
  String get error => _localizedValues[locale.languageCode]!['error']!;
  String get success => _localizedValues[locale.languageCode]!['success']!;
  String get retry => _localizedValues[locale.languageCode]!['retry']!;
  String get noInternet =>
      _localizedValues[locale.languageCode]!['no_internet']!;
  String get somethingWentWrong =>
      _localizedValues[locale.languageCode]!['something_went_wrong']!;

  // Validation
  String get emailRequired =>
      _localizedValues[locale.languageCode]!['email_required']!;
  String get emailInvalid =>
      _localizedValues[locale.languageCode]!['email_invalid']!;
  String get passwordRequired =>
      _localizedValues[locale.languageCode]!['password_required']!;
  String get passwordMinLength =>
      _localizedValues[locale.languageCode]!['password_min_length']!;
  String get passwordsNotMatch =>
      _localizedValues[locale.languageCode]!['passwords_not_match']!;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

/// Extension for easy access
extension AppLocalizationsExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
