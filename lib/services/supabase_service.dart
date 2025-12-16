import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_service.dart';

/// Service to initialize and manage Supabase client
/// This is the main entry point for backend services
class SupabaseService {
  static SupabaseClient? _client;
  static AuthService? _authService;

  /// Initialize Supabase with your project URL and anon key
  /// Call this in main() before runApp()
  static Future<void> initialize({
    required String url,
    required String anonKey,
  }) async {
    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
    );
    _client = Supabase.instance.client;
    _authService = AuthService(_client!);
  }

  /// Get the Supabase client instance
  static SupabaseClient get client {
    if (_client == null) {
      throw Exception(
          'Supabase not initialized. Call SupabaseService.initialize() first.');
    }
    return _client!;
  }

  /// Get the AuthService instance
  static AuthService get authService {
    if (_authService == null) {
      throw Exception(
          'Supabase not initialized. Call SupabaseService.initialize() first.');
    }
    return _authService!;
  }
}

