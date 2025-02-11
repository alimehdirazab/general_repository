# General Repository Package

## Overview
The `general_repository` package provides a robust and flexible repository layer for handling HTTP requests in Dart and Flutter applications. It includes built-in authentication, automatic token refresh, detailed logging, error handling, and support for various HTTP methods.

## Features
- Authentication with token refresh mechanism
- Supports GET, POST, PUT, PATCH, DELETE, and Multipart requests
- Automatic header management (Authorization and Content-Type)
- Configurable request timeouts
- Enhanced logging for debugging purposes
- Exception handling for network errors, timeouts, and API failures
- Customizable token storage and session management

## Installation
Add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  general_repository: ^0.0.4
```

Then, run:

```sh
flutter pub get
```

## Usage

### Initialization
Create an instance of `GeneralRepository` by providing authentication parameters:

```dart
import 'package:general_repository/general_repository.dart';

final repository = GeneralRepository(
  currentUserToken: 'your_access_token',
  refreshToken: 'your_refresh_token',
  updateTokens: (newAccessToken, newRefreshToken) {
    // Store updated tokens securely
  },
  clearUser: () {
    // Handle user logout
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
If an API call returns a `401 Unauthorized` error, the repository automatically tries to refresh the token and retries the request. If refreshing fails, the `clearUser` callback is triggered to log out the user.

```dart
Future<String?> fetchNewToken() async {
  final refreshHeader = {"Authorization": "Bearer \$refreshToken"};
  final refreshUri = Uri.parse("https://api.example.com/refresh-token");

  try {
    final refreshResponse = await http.get(refreshUri, headers: refreshHeader);
    if (refreshResponse.statusCode == 200) {
      final responseJson = jsonDecode(refreshResponse.body);
      updateTokens(responseJson["accessToken"], responseJson["refresh_token"]);
      return responseJson["accessToken"];
    } else {
      clearUser();
      return null;
    }
  } catch (e) {
    throw FetchDataException("Network error while refreshing token.");
  }
}
```

### Exception Handling
The repository handles exceptions for network errors, timeouts, and failed responses.

```dart
try {
  final response = await repository.get(handle: '/secure-endpoint');
  print(response);
} catch (e) {
  print('Error: \$e');
}
```

### Logging
The repository provides detailed logs for debugging:
```dart
final response = await repository.get(handle: '/endpoint', enableLogs: true);
```

## Error Handling
- `FetchDataException`: Thrown for network errors.
- `TimeOutExceptionC`: Thrown for request timeouts.
- API-specific errors are thrown based on response status codes.

## Conclusion
The `general_repository` package simplifies API handling in Flutter applications by providing built-in authentication, token refresh, logging, and error handling. It is highly customizable and can be seamlessly integrated into any project.

