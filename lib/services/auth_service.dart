import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

/// Backend service for authentication and user management
/// This service handles all Supabase database operations
///
/// Required Supabase table structure (table name: 'users'):
/// - id (uuid, primary key, auto-generated)
/// - email (text, unique, not null)
/// - name (text, not null)
/// - password (text, not null) - Note: In production, this should be hashed
/// - avatar_link (text, nullable, defaults to empty string)
class AuthService {
  final SupabaseClient _supabase;

  AuthService(this._supabase);

  /// Sign up a new user
  /// Returns the created user ID on success, throws exception on failure
  Future<String> signUp(UserModel user) async {
    try {
      // Insert user into the users table
      final response = await _supabase
          .from('users')
          .insert(user.toJson())
          .select()
          .single();

      // Return the user ID (assuming the table has an id field)
      return response['id'].toString();
    } catch (e) {
      throw Exception('Failed to sign up: ${e.toString()}');
    }
  }

  /// Check if email already exists
  /// Returns true if email exists, false otherwise
  Future<bool> emailExists(String email) async {
    try {
      final response = await _supabase
          .from('users')
          .select('email')
          .eq('email', email)
          .maybeSingle();

      return response != null;
    } catch (e) {
      throw Exception('Failed to check email: ${e.toString()}');
    }
  }

  /// Get user by email
  /// Returns UserModel if found, null otherwise
  Future<UserModel?> getUserByEmail(String email) async {
    try {
      final response = await _supabase
          .from('users')
          .select()
          .eq('email', email)
          .maybeSingle();

      if (response == null) return null;
      return UserModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to get user: ${e.toString()}');
    }
  }
}

