import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myitihas/utils/theme.dart';
import 'package:myitihas/services/supabase_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Theme Section
          _buildSectionCard(
            context,
            title: '🎨 Theme',
            children: [
              BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, themeState) {
                  return _buildSwitchTile(
                    context,
                    icon: Icons.dark_mode,
                    title: 'Dark Mode',
                    value: themeState.isDark,
                    onChanged: (value) {
                      context.read<ThemeBloc>().add(ToggleTheme());
                    },
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Language Section
          _buildSectionCard(
            context,
            title: '🌐 Language',
            children: [
              _buildDropdownTile(
                context,
                icon: Icons.language,
                title: 'Select Language',
                value: _selectedLanguage,
                items: ['English', 'Hindi'],
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value!;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Quick Actions Section
          _buildSectionCard(
            context,
            title: '⚡ Quick Actions',
            children: [
              _buildListTile(
                context,
                icon: Icons.star,
                title: 'Upgrade Plan',
                onTap: () {
                  // TODO: Implement upgrade plan
                },
              ),
              _buildDivider(),
              _buildListTile(
                context,
                icon: Icons.tune,
                title: 'Customize',
                onTap: () {
                  // TODO: Implement customize
                },
              ),
              _buildDivider(),
              _buildListTile(
                context,
                icon: Icons.settings,
                title: 'Settings',
                onTap: () {
                  // TODO: Implement settings
                },
              ),
              _buildDivider(),
              _buildListTile(
                context,
                icon: Icons.notifications,
                title: 'Notifications',
                onTap: () {
                  // TODO: Implement notifications
                },
              ),
              _buildDivider(),
              _buildListTile(
                context,
                icon: Icons.security,
                title: 'Password & Security',
                onTap: () {
                  // TODO: Implement password & security
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Help & Support Section
          _buildSectionCard(
            context,
            title: '❓ Help & Support',
            children: [
              _buildListTile(
                context,
                icon: Icons.info,
                title: 'FAQ',
                onTap: () {
                  // TODO: Implement FAQ
                },
              ),
              _buildDivider(),
              _buildListTile(
                context,
                icon: Icons.email,
                title: 'Contact Us',
                onTap: () {
                  // TODO: Implement contact us
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Account Section
          _buildSectionCard(
            context,
            title: '👤 Account',
            children: [
              _buildListTile(
                context,
                icon: Icons.logout,
                title: 'Logout',
                onTap: _handleLogout,
                isDestructive: true,
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final color = isDestructive 
        ? Colors.red 
        : Theme.of(context).colorScheme.primary;
    
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: isDestructive ? Colors.red : null,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDropdownTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      trailing: DropdownButton<String>(
        value: value,
        underline: const SizedBox(),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      indent: 56,
      endIndent: 16,
    );
  }

  void _handleLogout() {
    final authService = SupabaseService.authService;

    if (authService.isAuthenticated()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Close dialog first
                Navigator.pop(context);

                // Call signOut - GoRouter redirect handles navigation
                // When session becomes null, GoRouter redirects to /login
                await authService.signOut();
              },
              child: const Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );
    }
  }
}
