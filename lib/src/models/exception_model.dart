part of 'models.dart';

/// Exception model for internet related exceptions
class CustomException implements Exception {
  /// A custom exception class that takes a message and a prefix.
  ///
  /// The [_message] parameter is the error message.
  /// The [_prefix] parameter is the prefix for the error message.
  CustomException(
    this._message,
    this._prefix,
  );

  final String? _message;
  final String _prefix;

  /// A getter that returns the error message.
  ///
  /// If the private `_message` field is `null`, it returns a default message
  /// "Something went wrong!".
  ///
  /// Returns:
  ///   A `String` representing the error message.
  String get message => _message ?? "Something went wrong!";

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

/// Exception thrown when an error occurs while fetching data.
///
/// This exception is a subclass of [CustomException] and is used to indicate
/// that there was an issue retrieving data from a source, such as a network
/// request or a database query.
class FetchDataException extends CustomException {
  /// Exception thrown when there is an issue fetching data, typically due to
  /// network connectivity problems.
  ///
  /// The [message] parameter allows for a custom error message to be provided.
  /// If no message is provided, a default message of 'Please check your internet
  /// and try again later.' will be used.
  ///
  /// Example usage:
  /// ```dart
  /// throw FetchDataException();
  /// throw FetchDataException('Custom error message');
  /// ```
  ///
  /// [message]: The error message to be displayed.
  FetchDataException(
      [String message = 'Please check your internet and try again later.'])
      : super(message, '');
}

/// Exception thrown when a bad request is made.
///
/// This exception is typically used to indicate that the request made by the
/// client is invalid or cannot be processed by the server.
///
/// [message] is an optional parameter that provides additional information
/// about the error.
///
/// This exception is typically used to indicate that the server cannot or will not process the request
/// due to something that is perceived to be a client error (e.g., malformed request syntax, invalid request
/// message framing, or deceptive request routing).
/// Exception thrown when a bad request is made.
///
/// This exception is typically used to indicate that the request made by the
/// client is invalid or cannot be processed by the server.
///
/// [message] is an optional parameter that provides additional information
/// about the error.
///
/// This exception is typically used to indicate that the server cannot or will not process the request
/// due to something that is perceived to be a client error (e.g., malformed request syntax, invalid request
/// message framing, or deceptive request routing).
class BadRequestException extends CustomException {
  /// Creates a [BadRequestException] with an optional error [message].
  BadRequestException([String? message]) : super(message, 'Invalid Request: ');
}

/// Exception thrown when an unauthorized request is made.
///
/// This exception is typically used to indicate that the request made by the
/// client is not authorized or lacks valid authentication credentials.
///
/// [message] is an optional parameter that provides additional information
/// about the error.
class UnauthorisedException extends CustomException {
  /// Creates an [UnauthorisedException] with an optional error [message].
  UnauthorisedException([String? message]) : super(message, 'Unauthorised: ');
}

/// Exception thrown when a request times out.
///
/// This exception is typically used to indicate that the request took too long
/// to complete, usually due to network issues or server delays.
///
/// [message] is an optional parameter that provides additional information
/// about the error.
class TimeOutExceptionC extends CustomException {
  /// Creates a [TimeOutExceptionC] with an optional error [message].
  TimeOutExceptionC(
      [String message =
          'Something went wrong, please check your internet and try again later.'])
      : super(message, '');
}
