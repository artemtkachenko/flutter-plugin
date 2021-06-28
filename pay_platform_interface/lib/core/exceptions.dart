import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PaymentException implements Exception {
  factory PaymentException.fromPlatformException(
    PlatformException exception,
  ) {
    switch (exception.code) {
      case 'payment-error/canceled':
        return PaymentCancelledException(
          message: exception.message ?? 'unknown',
        );

      default:
        return UnknownPaymentException(
          platformException: exception,
        );
    }
  }
}

class PaymentCancelledException implements PaymentException {
  const PaymentCancelledException({
    required this.message,
  });

  final String message;

  @override
  String toString() => 'PaymentCancelledException($message)';
}

class UnknownPaymentException extends PlatformException implements PaymentException {
  UnknownPaymentException({
    required PlatformException platformException,
  }) : super(
          code: platformException.code,
          message: platformException.message,
          details: platformException.details,
        );

  @override
  String toString() => 'UnknownPaymentException($code, $message, $details)';
}
