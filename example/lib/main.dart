import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:general_repository/general_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_endpoints.dart';

void main() {
  runApp(const MyApp());
}

/// A stateless widget that represents the main application.
///
/// This widget serves as the entry point for the Flutter application.
/// It extends [StatelessWidget] and overrides the [build] method to
/// provide the widget tree for the application.
class MyApp extends StatelessWidget {
  /// Creates an instance of [MyApp].
  ///
  /// The [key] parameter is optional and can be used to uniquely identify the widget in the widget tree.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'General Repository Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

/// A [StatefulWidget] that represents the home page of the application.
///
/// This widget is the main entry point of the app's user interface and
/// manages the state of the home page.
class MyHomePage extends StatefulWidget {
  /// Creates a [MyHomePage] widget.
  ///
  /// The [key] parameter is used to uniquely identify this widget in the widget tree.
  ///
  /// ```dart
  /// const MyHomePage({super.key});
  /// ```
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

/// The state class for the `MyHomePage` widget.
///
/// This class is responsible for managing the state of the `MyHomePage`
/// widget, including any stateful logic and UI updates.
class MyHomePageState extends State<MyHomePage> {
  /// A late-initialized instance of [GeneralRepository].
  ///
  /// This repository is used to manage and access general data
  /// throughout the application. It must be initialized before
  /// it can be used.
  late GeneralRepository repository;

  @override
  void initState() {
    super.initState();
    _initializeRepository();
  }

  Future<void> _initializeRepository() async {
    final prefs = await SharedPreferences.getInstance();
    final currentUserToken =
        prefs.getString('currentUserToken') ?? 'your_access_token';
    final refreshToken =
        prefs.getString('refreshToken') ?? 'your_refresh_token';

    repository = GeneralRepository(
      currentUserToken: currentUserToken,
      refreshToken: refreshToken,
      updateTokens: (newAccessToken, newRefreshToken) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('currentUserToken', newAccessToken);
        await prefs.setString('refreshToken', newRefreshToken);
      },
      clearUser: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('currentUserToken');
        await prefs.remove('refreshToken');
      },
    );
  }

  Future<void> _makeGetApiCall() async {
    try {
      final response = await repository.get(handle: ApiEndpoints.getEndpoint);
      log(response);
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<void> _makePostApiCall() async {
    try {
      final response = await repository.post(
        handle: ApiEndpoints.postEndpoint,
        body: {'key': 'value'},
      );
      log(response);
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<void> _makePutApiCall() async {
    try {
      final response = await repository.put(
        handle: ApiEndpoints.putEndpoint,
        body: {'key': 'updated_value'},
      );
      log(response);
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<void> _makeDeleteApiCall() async {
    try {
      final response =
          await repository.delete(handle: ApiEndpoints.deleteEndpoint);
      log(response);
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<void> _makePatchApiCall() async {
    try {
      final response = await repository.patch(
        handle: ApiEndpoints.patchEndpoint,
        body: {'key': 'patched_value'},
      );
      log(response);
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<void> _makeMultipartPostApiCall() async {
    try {
      final response = await repository.multipartPost(
        handle: ApiEndpoints.multipartPostEndpoint,
        fields: {'field': 'value'},
        files: [
          {
            'fieldName': 'file',
            'filePath': 'path/to/file',
            'fileName': 'file_name',
          },
        ],
      );
      log(response);
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<void> _logout() async {
    repository.clearUser();
    log('User logged out');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('General Repository Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _makeGetApiCall,
              child: const Text('Make GET API Call'),
            ),
            ElevatedButton(
              onPressed: _makePostApiCall,
              child: const Text('Make POST API Call'),
            ),
            ElevatedButton(
              onPressed: _makePutApiCall,
              child: const Text('Make PUT API Call'),
            ),
            ElevatedButton(
              onPressed: _makeDeleteApiCall,
              child: const Text('Make DELETE API Call'),
            ),
            ElevatedButton(
              onPressed: _makePatchApiCall,
              child: const Text('Make PATCH API Call'),
            ),
            ElevatedButton(
              onPressed: _makeMultipartPostApiCall,
              child: const Text('Make Multipart POST API Call'),
            ),
            ElevatedButton(
              onPressed: _logout,
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
