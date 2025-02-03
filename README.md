# General Repository Package

## Overview
The `general_repository` package provides a flexible and robust repository layer for handling HTTP requests in Dart and Flutter applications. It includes support for authentication, token refresh, logging, and various HTTP methods.

## Features
- Authentication support with token refresh
- GET, POST, PUT, PATCH, DELETE, and Multipart requests
- Customizable request headers
- Logging for debugging purposes
- Error handling with exceptions

## Installation
Add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  general_repository:
    path: '../general_repository'
```

Then, run:

```sh
flutter pub get
```

## Usage
### Initialization
Create an instance of `GeneralRepository` by passing the required parameters:

```dart
import 'package:general_repository/general_repository.dart';

final repository = GeneralRepository(
  currentUserToken: 'your_access_token',
  refreshToken: 'your_refresh_token',
  updateTokens: (newAccessToken, newRefreshToken) {
    // Update tokens in storage
  },
  clearUser: () {
    // Clear user session
  },
);
```

### Making API Calls
#### GET Request
```dart
final response = await repository.get(handle: '/endpoint');
print(response);
```

#### POST Request
```dart
final response = await repository.post(
  handle: '/endpoint',
  body: {'key': 'value'},
);
print(response);
```

#### PUT Request
```dart
final response = await repository.put(
  handle: '/endpoint',
  body: {'key': 'updated_value'},
);
print(response);
```

#### PATCH Request
```dart
final response = await repository.patch(
  handle: '/endpoint',
  body: {'key': 'partial_update'},
);
print(response);
```

#### DELETE Request
```dart
final response = await repository.delete(handle: '/endpoint');
print(response);
```

### Handling Multipart Requests
```dart
final response = await repository.multipartPost(
  handle: '/upload',
  fields: {'description': 'file upload'},
  files: [
    MultipartFile(
      fieldName: 'file',
      filePath: '/path/to/file.jpg',
      fileName: 'file.jpg',
    ),
  ],
);
print(response);
```

### Token Refresh Mechanism
If an API call returns a `401 Unauthorized` error, the repository automatically attempts to refresh the token and retries the request. If refreshing fails, the `clearUser` callback is triggered to log out the user.

### Exception Handling
The repository throws exceptions for network errors, timeouts, and failed responses:
```dart
try {
  final response = await repository.get(handle: '/secure-endpoint');
  print(response);
} catch (e) {
  print('Error: $e');
}
```

## Error Handling
- `FetchDataException`: Thrown for network errors.
- `TimeOutExceptionC`: Thrown for request timeouts.
- API-specific errors are thrown based on response status codes.

## Conclusion
The `general_repository` package simplifies API handling in Flutter applications by providing built-in authentication, token refresh, logging, and error handling. It is customizable and can be integrated seamlessly into any project.