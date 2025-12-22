import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myitihas/core/di/injection_container.dart';
import 'package:myitihas/services/profile_service.dart';
import 'package:myitihas/features/social/presentation/widgets/svg_avatar.dart';
import 'package:myitihas/config/routes.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final TextEditingController _searchController = TextEditingController();
  final ProfileService _profileService = getIt<ProfileService>();
  Timer? _debounceTimer;
  
  List<Map<String, dynamic>> _profiles = [];
  bool _isLoading = true;
  String? _errorMessage;
  final int _limit = 20;
  int _offset = 0;

  @override
  void initState() {
    super.initState();
    _loadProfiles();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    // Cancel previous timer
    _debounceTimer?.cancel();
    
    // Start new timer (400ms debounce)
    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      final query = _searchController.text.trim();
      
      if (query.isEmpty) {
        // Load all profiles when search is empty
        _loadProfiles();
      } else {
        // Search profiles when query is non-empty
        _searchProfiles(query);
      }
    });
  }

  Future<void> _loadProfiles() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final profiles = await _profileService.fetchPublicProfiles(
        limit: _limit,
        offset: _offset,
      );
      
      setState(() {
        _profiles = profiles;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load profiles: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _searchProfiles(String query) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final profiles = await _profileService.searchProfiles(query);
      
      setState(() {
        _profiles = profiles;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to search profiles: $e';
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          // Search text field at the top
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search stories, users, or topics...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          // Clearing will trigger the listener which will reload all profiles
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
            ),
          ),
          // Placeholder list below
          Expanded(
            child: _buildPlaceholderContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderContent() {
    if (_isLoading) {
      // Loading state
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_errorMessage != null) {
      // Error state
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: Theme.of(context).colorScheme.error.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Error',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadProfiles,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_profiles.isEmpty) {
      // Empty state
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 80,
              color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'No profiles found',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      );
    }

    // Display profiles list
    return ListView.builder(
      itemCount: _profiles.length,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, index) {
        final profile = _profiles[index];
        final userId = profile['id'] as String;
        final displayName = profile['full_name'] as String? ?? 'Unknown';
        final username = profile['username'] as String? ?? '';
        final avatarUrl = profile['avatar_url'] as String?;

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: SvgAvatar(
              imageUrl: avatarUrl ?? '',
              radius: 28,
              fallbackText: displayName,
            ),
            title: Text(
              displayName,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            subtitle: username.isNotEmpty
                ? Text(
                    '@$username',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  )
                : null,
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigate to other user's profile
              ProfileRoute(userId: userId).push(context);
            },
          ),
        );
      },
    );
  }
}
