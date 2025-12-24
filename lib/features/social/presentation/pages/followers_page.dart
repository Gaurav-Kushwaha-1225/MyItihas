import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myitihas/core/di/injection_container.dart';
import 'package:myitihas/features/social/domain/repositories/user_repository.dart';
import 'package:myitihas/features/social/domain/entities/user.dart';
import 'package:myitihas/features/social/presentation/widgets/svg_avatar.dart';
import 'package:myitihas/config/routes.dart';

/// Page that displays the list of followers for a user
class FollowersPage extends StatefulWidget {
  final String userId;

  const FollowersPage({super.key, required this.userId});

  @override
  State<FollowersPage> createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  final UserRepository _userRepository = getIt<UserRepository>();
  List<User> _followers = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadFollowers();
  }

  Future<void> _loadFollowers() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await _userRepository.getFollowers(widget.userId);

    result.fold(
      (failure) {
        if (mounted) {
          setState(() {
            _errorMessage = failure.message;
            _isLoading = false;
          });
        }
      },
      (followers) {
        if (mounted) {
          setState(() {
            _followers = followers;
            _isLoading = false;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Followers'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Something went wrong',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                _errorMessage ?? 'Unable to load followers',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _loadFollowers,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    if (_followers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 64,
              color: Theme.of(
                context,
              ).colorScheme.onSurfaceVariant.withOpacity(0.4),
            ),
            const SizedBox(height: 16),
            Text(
              'No followers yet',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: Text(
                'When someone follows this user, they will appear here',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurfaceVariant.withOpacity(0.7),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _followers.length,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemBuilder: (context, index) {
        final user = _followers[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: SvgAvatar(
              imageUrl: user.avatarUrl,
              radius: 28,
              fallbackText: user.displayName,
            ),
            title: Text(
              user.displayName,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            subtitle: user.username.isNotEmpty
                ? Text(
                    '@${user.username}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  )
                : null,
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              ProfileRoute(userId: user.id).push(context);
            },
          ),
        );
      },
    );
  }
}
