
class Validator {
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'من فضلك أدخل الاسم';
    }

    if (value.trim().length < 3) {
      return 'الاسم يجب أن يكون 3 أحرف على الأقل';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'من فضلك أدخل البريد الإلكتروني';
    }

    final emailRegex = RegExp(
      r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return 'البريد الإلكتروني غير صحيح';
    }

    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'من فضلك أدخل رقم الهاتف';
    }

    final phoneRegex = RegExp(r'^(010|011|012|015)\d{8}$');

    if (!phoneRegex.hasMatch(value.trim())) {
      return 'رقم الهاتف غير صحيح';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'من فضلك أدخل كلمة المرور';
    }

    if (value.length < 8) {
      return 'كلمة المرور يجب أن تكون 8 أحرف على الأقل';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'يجب أن تحتوي على حرف Capital';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'يجب أن تحتوي على حرف Small';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'يجب أن تحتوي على رقم';
    }

    return null;
  }
}
