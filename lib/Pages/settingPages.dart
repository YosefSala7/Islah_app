import 'package:app/core/Global State Managment/darkModeCubit.dart';
import 'package:app/core/Global State Managment/darkModeState.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  static const String _email = 'yosefsalah211@gmail.com';
  static const String _linkedin =
      'https://www.linkedin.com/in/youssef-salah-8ab975280/';

  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: _email,
      queryParameters: {
        'subject': 'IslahApp - Feedback',
        'body': 'Hi, I have a question about the app...',
      },
    );

    try {
      await launchUrl(emailUri);
    } catch (e) {
      return;
    }
  }

  Future<void> _launchLinkedIn() async {
    final Uri linkedinUri = Uri.parse(_linkedin);

    try {
      await launchUrl(linkedinUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Settings".tr(),
          style: theme.textTheme.bodyLarge!.copyWith(
            fontFamily: "ReemKufi",
            fontWeight: FontWeight.normal,
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colorScheme.primary.withAlpha(229),
                theme.colorScheme.primary.withAlpha(153),
              ],
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 120,
                    left: 24,
                    right: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildDarkModeCard(context, theme),
                      const SizedBox(height: 20),
                      _buildContactCard(context, theme),
                      const SizedBox(height: 20),
                      _buildLinkedInCard(context, theme),
                      const SizedBox(height: 20),
                      _buildInfoCard(context, theme),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDarkModeCard(BuildContext context, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: theme.colorScheme.primary.withAlpha(51),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withAlpha(38),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () => context.read<DarkCubit>().onClick(),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withAlpha(26),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.dark_mode_outlined,
                  size: 28,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dark Mode".tr(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "Toggle dark theme".tr(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withAlpha(153),
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<DarkCubit, DarkModeState>(
                builder: (context, state) {
                  return Switch(
                    value: state.isDark,
                    onChanged: (_) => context.read<DarkCubit>().onClick(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard(BuildContext context, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: theme.colorScheme.secondary.withAlpha(51),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withAlpha(26),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: _launchEmail,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary.withAlpha(26),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.email_outlined,
                  size: 28,
                  color: theme.colorScheme.secondary,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Contact Us".tr(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "Send us a message".tr(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withAlpha(153),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.send, size: 18, color: Colors.white),
                    const SizedBox(width: 6),
                    Text(
                      "Send".tr(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLinkedInCard(BuildContext context, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: theme.colorScheme.primary.withAlpha(51),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withAlpha(26),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: _launchLinkedIn,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withAlpha(26),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.people_outline,
                  size: 28,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "LinkedIn".tr(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "Follow us on LinkedIn".tr(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withAlpha(153),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary.withAlpha(26),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: theme.colorScheme.secondary.withAlpha(77),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.open_in_new,
                      size: 18,
                      color: theme.colorScheme.secondary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "Visit".tr(),
                      style: TextStyle(
                        color: theme.colorScheme.secondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: theme.colorScheme.primary.withAlpha(26),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withAlpha(20),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.info,
            size: 56,
            color: theme.colorScheme.primary.withAlpha(77),
          ),
          const SizedBox(height: 20),
          Text(
            "App Version 1.0.0".tr(),
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Made with ❤️ in Egypt".tr(),
            style: theme.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Commented old code with replacements
// import 'package:app/core/Global State Managment/darkModeCubit.dart';
// ... (rest commented with all withOpacity changed to withAlpha with int values, but omitted for brevity as it's inactive)

