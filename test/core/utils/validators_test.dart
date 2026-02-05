import 'package:flutter_test/flutter_test.dart';

import 'package:mobile_template/core/utils/validators.dart';

void main() {
  group('Validators', () {
    group('email', () {
      test('should return error message for empty email', () {
        expect(Validators.email(''), isNotNull);
        expect(Validators.email(null), isNotNull);
      });

      test('should return error message for invalid email format', () {
        expect(Validators.email('invalid'), isNotNull);
        expect(Validators.email('invalid@'), isNotNull);
        expect(Validators.email('@domain.com'), isNotNull);
        expect(Validators.email('user@.com'), isNotNull);
      });

      test('should return null for valid email', () {
        expect(Validators.email('test@example.com'), isNull);
        expect(Validators.email('user.name@domain.co.uk'), isNull);
        expect(Validators.email('user+tag@example.com'), isNull);
      });
    });

    group('password', () {
      test('should return error message for empty password', () {
        expect(Validators.password(''), isNotNull);
        expect(Validators.password(null), isNotNull);
      });

      test('should return error message for short password', () {
        expect(Validators.password('12345'), isNotNull);
        expect(Validators.password('abc'), isNotNull);
      });

      test('should return null for valid password', () {
        expect(Validators.password('password123'), isNull);
        expect(Validators.password('12345678'), isNull);
        expect(Validators.password('secureP@ssw0rd'), isNull);
      });
    });

    group('required', () {
      test('should return error message for empty value', () {
        expect(Validators.required(''), isNotNull);
        expect(Validators.required(null), isNotNull);
        expect(Validators.required('   '), isNotNull);
      });

      test('should return null for non-empty value', () {
        expect(Validators.required('value'), isNull);
        expect(Validators.required('  value  '), isNull);
      });
    });

    group('phone', () {
      test('should return error message for invalid phone', () {
        expect(Validators.phone(''), isNotNull);
        expect(Validators.phone('abc'), isNotNull);
        expect(Validators.phone('123'), isNotNull);
      });

      test('should return null for valid phone', () {
        expect(Validators.phone('1234567890'), isNull);
        expect(Validators.phone('+1234567890123'), isNull);
      });
    });

    group('confirmPassword', () {
      test('should return error message when passwords do not match', () {
        expect(
          Validators.confirmPassword('different', 'password123'),
          isNotNull,
        );
        expect(
          Validators.confirmPassword('password', 'password123'),
          isNotNull,
        );
      });

      test('should return null when passwords match', () {
        expect(
          Validators.confirmPassword('password123', 'password123'),
          isNull,
        );
      });
    });

    group('strongPassword', () {
      test('should return error for password without uppercase', () {
        expect(Validators.strongPassword('password1!'), isNotNull);
      });

      test('should return error for password without lowercase', () {
        expect(Validators.strongPassword('PASSWORD1!'), isNotNull);
      });

      test('should return error for password without number', () {
        expect(Validators.strongPassword('Password!'), isNotNull);
      });

      test('should return error for password without special char', () {
        expect(Validators.strongPassword('Password1'), isNotNull);
      });

      test('should return null for valid strong password', () {
        expect(Validators.strongPassword('Password1!'), isNull);
      });
    });
  });
}
