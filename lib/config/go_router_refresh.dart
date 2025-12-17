import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:myitihas/services/supabase_service.dart';

/// ChangeNotifier that bridges Supabase auth state changes to GoRouter refresh
///
/// This class listens to Supabase authentication state changes and notifies
/// GoRouter to rebuild its redirect logic whenever auth state changes.
/// Used as the refreshListenable in GoRouter configuration.
class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<AuthState> _subscription;

  GoRouterRefreshStream() {
    _subscription = SupabaseService.onAuthStateChange.listen((_) {
      // Notify GoRouter to recompute redirect logic
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
