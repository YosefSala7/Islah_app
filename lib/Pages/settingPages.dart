// import 'package:app/core/Global State Managment/darkModeCubit.dart';
// import 'package:app/core/Global State Managment/darkModeState.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'dart:math' as math;
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:url_launcher/url_launcher.dart';

// class SettingPage extends StatelessWidget {
//   const SettingPage({super.key});

//   static const String _email = 'yosefsalah211@gmail.com';
//   static const String _linkedin = 'https://www.linkedin.com/in/youssef-salah-8ab975280/';

//   Future<void> _launchEmail() async {
//     final Uri emailUri = Uri(
//       scheme: 'mailto',
//       path: _email,
//       queryParameters: {
//         'subject': 'IslahApp - Feedback',
//         'body': 'Hi, I have a question about the app...',
//       },
//     );

//     try {
//       await launchUrl(emailUri);
//     } catch (e) {
//       print('Could not launch email: $e');
//     }
//   }

//   Future<void> _launchLinkedIn() async {
//     final Uri linkedinUri = Uri.parse(_linkedin);

//     try {
//       await launchUrl(linkedinUri, mode: LaunchMode.externalApplication);
//     } catch (e) {
//       print('Could not launch LinkedIn: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         title: Text(
//           "Settings".tr(),
//           style: theme.textTheme.bodyLarge?.copyWith(
//             fontWeight: FontWeight.bold,
//             shadows: [
//               Shadow(
//                 color: theme.colorScheme.primary.withOpacity(0.3),
//                 offset: const Offset(0, 2),
//                 blurRadius: 4,
//               ),
//             ],
//           ),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 theme.colorScheme.primary,
//                 theme.colorScheme.primary.withOpacity(0.8),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: CustomScrollView(
//         slivers: [
//           SliverToBoxAdapter(
//             child: Stack(
//               children: [
//                 Container(
//                   height: MediaQuery.of(context).size.height * 0.25,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         theme.colorScheme.primary.withOpacity(0.1),
//                         theme.scaffoldBackgroundColor,
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 120),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       // Dark Mode Card
//                       TweenAnimationBuilder<double>(
//                         duration: const Duration(milliseconds: 1000),
//                         tween: Tween(begin: 0.0, end: 1.0),
//                         builder: (context, value, child) {
//                           return Transform.scale(
//                             scale: value,
//                             child: AnimatedContainer(
//                               duration: const Duration(milliseconds: 400),
//                               margin: const EdgeInsets.only(bottom: 24),
//                               padding: const EdgeInsets.all(24),
//                               decoration: BoxDecoration(
//                                 color: theme.cardColor.withOpacity(0.95),
//                                 borderRadius: BorderRadius.circular(28),
//                                 border: Border.all(
//                                   color: theme.colorScheme.primary.withOpacity(0.2),
//                                   width: 1.5,
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: theme.colorScheme.primary.withOpacity(0.2),
//                                     blurRadius: 40,
//                                     spreadRadius: -5,
//                                     offset: const Offset(0, 20),
//                                   ),
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.1),
//                                     blurRadius: 25,
//                                     offset: const Offset(0, 10),
//                                   ),
//                                 ],
//                               ),
//                               child: Material(
//                                 color: Colors.transparent,
//                                 child: InkWell(
//                                   borderRadius: BorderRadius.circular(28),
//                                   onTap: () => context.read<DarkCubit>().onClick(),
//                                   child: Row(
//                                     children: [
//                                       Container(
//                                         padding: const EdgeInsets.all(18),
//                                         decoration: BoxDecoration(
//                                           gradient: RadialGradient(
//                                             colors: [
//                                               theme.colorScheme.primary.withOpacity(0.2),
//                                               theme.colorScheme.primary.withOpacity(0.1),
//                                             ],
//                                           ),
//                                           shape: BoxShape.circle,
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color: theme.colorScheme.primary.withOpacity(0.4),
//                                               blurRadius: 25,
//                                             ),
//                                           ],
//                                         ),
//                                         child: Icon(
//                                           Icons.dark_mode_outlined,
//                                           size: 34,
//                                           color: theme.colorScheme.primary,
//                                         ),
//                                       ),
//                                       const SizedBox(width: 24),
//                                       Expanded(
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               "Dark Mode".tr(),
//                                               style: theme.textTheme.bodyLarge?.copyWith(
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                             Text(
//                                               "Toggle dark theme".tr(),
//                                               style: theme.textTheme.bodySmall?.copyWith(
//                                                 color: theme.colorScheme.onSurface.withOpacity(0.7),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       BlocBuilder<DarkCubit, DarkModeState>(
//                                         builder: (context, state) {
//                                           return AnimatedSwitcher(
//                                             duration: const Duration(milliseconds: 350),
//                                             child: Switch(
//                                               key: ValueKey(state.isDark),
//                                               value: state.isDark,
//                                               onChanged: (_) => context.read<DarkCubit>().onClick(),
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                       // Contact Card
//                       Hero(
//                         tag: 'contact-hero',
//                         child: AnimatedContainer(
//                           duration: const Duration(milliseconds: 400),
//                           margin: const EdgeInsets.only(bottom: 20),
//                           padding: const EdgeInsets.all(24),
//                           decoration: BoxDecoration(
//                             color: theme.cardColor.withOpacity(0.95),
//                             borderRadius: BorderRadius.circular(28),
//                             border: Border.all(
//                               color: theme.colorScheme.secondary.withOpacity(0.2),
//                               width: 1.5,
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: theme.colorScheme.primary.withOpacity(0.15),
//                                 blurRadius: 35,
//                                 offset: const Offset(0, 15),
//                               ),
//                             ],
//                           ),
//                           child: Material(
//                             color: Colors.transparent,
//                             child: InkWell(
//                               borderRadius: BorderRadius.circular(28),
//                               onTap: _launchEmail,
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     padding: const EdgeInsets.all(18),
//                                     decoration: BoxDecoration(
//                                       gradient: LinearGradient(
//                                         colors: [
//                                           theme.colorScheme.secondary.withOpacity(0.2),
//                                           theme.colorScheme.secondary.withOpacity(0.1),
//                                         ],
//                                       ),
//                                       shape: BoxShape.circle,
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: theme.colorScheme.secondary.withOpacity(0.3),
//                                           blurRadius: 20,
//                                         ),
//                                       ],
//                                     ),
//                                     child: Icon(
//                                       Icons.email_outlined,
//                                       size: 34,
//                                       color: theme.colorScheme.secondary,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 24),
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "Contact Us".tr(),
//                                           style: theme.textTheme.bodyLarge?.copyWith(
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         Text(
//                                           "Send us a message".tr(),
//                                           style: theme.textTheme.bodySmall?.copyWith(
//                                             color: theme.colorScheme.onSurface.withOpacity(0.7),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   AnimatedContainer(
//                                     duration: const Duration(milliseconds: 250),
//                                     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
//                                     decoration: BoxDecoration(
//                                       gradient: LinearGradient(
//                                         colors: [
//                                           theme.colorScheme.primary,
//                                           theme.colorScheme.primary.withOpacity(0.85),
//                                         ],
//                                       ),
//                                       borderRadius: BorderRadius.circular(25),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: theme.colorScheme.primary.withOpacity(0.4),
//                                           blurRadius: 15,
//                                           offset: const Offset(0, 6),
//                                         ),
//                                       ],
//                                     ),
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Icon(Icons.send, size: 20, color: Colors.white),
//                                         const SizedBox(width: 8),
//                                         Text(
//                                           "Send".tr(),
//                                           style: const TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 14,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       // LinkedIn Card
//                       Hero(
//                         tag: 'linkedin-hero',
//                         child: AnimatedContainer(
//                           duration: const Duration(milliseconds: 400),
//                           margin: const EdgeInsets.only(bottom: 24),
//                           padding: const EdgeInsets.all(24),
//                           decoration: BoxDecoration(
//                             color: theme.cardColor.withOpacity(0.95),
//                             borderRadius: BorderRadius.circular(28),
//                             border: Border.all(
//                               color: theme.colorScheme.primary.withOpacity(0.2),
//                               width: 1.5,
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: theme.colorScheme.primary.withOpacity(0.15),
//                                 blurRadius: 35,
//                                 offset: const Offset(0, 15),
//                               ),
//                             ],
//                           ),
//                           child: Material(
//                             color: Colors.transparent,
//                             child: InkWell(
//                               borderRadius: BorderRadius.circular(28),
//                               onTap: _launchLinkedIn,
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     padding: const EdgeInsets.all(18),
//                                     decoration: BoxDecoration(
//                                       gradient: LinearGradient(
//                                         colors: [
//                                           theme.colorScheme.tertiary?.withOpacity(0.2) ?? Colors.blue.withOpacity(0.2),
//                                           theme.colorScheme.tertiary?.withOpacity(0.1) ?? Colors.blue.withOpacity(0.1),
//                                         ],
//                                       ),
//                                       shape: BoxShape.circle,
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: theme.colorScheme.tertiary?.withOpacity(0.3) ?? Colors.blue.withOpacity(0.3),
//                                           blurRadius: 20,
//                                         ),
//                                       ],
//                                     ),
//                                     child: Icon(
//                                       Icons.people_outline,
//                                       size: 34,
//                                       color: theme.colorScheme.tertiary ?? Colors.blue,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 24),
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "LinkedIn".tr(),
//                                           style: theme.textTheme.bodyLarge?.copyWith(
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         Text(
//                                           "Follow us on LinkedIn".tr(),
//                                           style: theme.textTheme.bodySmall?.copyWith(
//                                             color: theme.colorScheme.onSurface.withOpacity(0.7),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   AnimatedContainer(
//                                     duration: const Duration(milliseconds: 250),
//                                     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
//                                     decoration: BoxDecoration(
//                                       gradient: LinearGradient(
//                                         colors: [
//                                           Colors.transparent,
//                                           Colors.transparent,
//                                         ],
//                                       ),
//                                       borderRadius: BorderRadius.circular(25),
//                                       border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.white.withOpacity(0.2),
//                                           blurRadius: 10,
//                                         ),
//                                       ],
//                                     ),
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Icon(Icons.open_in_new, size: 20, color: Colors.white.withOpacity(0.8)),
//                                         const SizedBox(width: 8),
//                                         Text(
//                                           "Visit".tr(),
//                                           style: TextStyle(
//                                             color: Colors.white.withOpacity(0.9),
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 14,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       // Info Card
//                       TweenAnimationBuilder<double>(
//                         duration: const Duration(milliseconds: 1200),
//                         tween: Tween(begin: 0.0, end: 1.0),
//                         builder: (context, value, child) {
//                           return Opacity(
//                             opacity: value,
//                             child: Transform.translate(
//                               offset: Offset(0, 20 * (1 - value)),
//                               child: AnimatedContainer(
//                                 duration: const Duration(milliseconds: 400),
//                                 padding: const EdgeInsets.all(32),
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       theme.cardColor.withOpacity(0.9),
//                                       theme.cardColor.withOpacity(0.8),
//                                     ],
//                                   ),
//                                   borderRadius: BorderRadius.circular(28),
//                                   border: Border.all(
//                                     color: theme.colorScheme.primary.withOpacity(0.1),
//                                     width: 1,
//                                   ),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: theme.colorScheme.primary.withOpacity(0.1),
//                                       blurRadius: 30,
//                                       offset: const Offset(0, 15),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     AnimatedBuilder(
//                                       animation: AlwaysStoppedAnimation(value),
//                                       builder: (context, child) {
//                                         return Transform.scale(
//                                         scale: 0.8 + 0.2 * (math.sin(value * 2 * math.pi) * 0.5 + 0.5),
//                                           child: Icon(
//                                             Icons.favorite,
//                                             size: 64,
//                                             color: theme.colorScheme.primary.withOpacity(0.4),
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                     const SizedBox(height: 24),
//                                     Text(
//                                       "App Version 1.0.0".tr(),
//                                       style: theme.textTheme.bodyMedium?.copyWith(
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 18,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 8),
//                                     Text(
//                                       "Made with ❤️ in Egypt".tr(),
//                                       style: theme.textTheme.bodySmall,
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                       const SizedBox(height: 40),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
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
      print('Could not launch email: $e');
    }
  }

  Future<void> _launchLinkedIn() async {
    final Uri linkedinUri = Uri.parse(_linkedin);

    try {
      await launchUrl(linkedinUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      print('Could not launch LinkedIn: $e');
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
                theme.colorScheme.primary.withOpacity(0.9),
                theme.colorScheme.primary.withOpacity(0.6),
              ],
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        theme.colorScheme.primary.withOpacity(0.08),
                        theme.scaffoldBackgroundColor,
                      ],
                    ),
                  ),
                ),
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
          color: theme.colorScheme.primary.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.15),
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
                  color: theme.colorScheme.primary.withOpacity(0.1),
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
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
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
          color: theme.colorScheme.secondary.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.1),
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
                  color: theme.colorScheme.secondary.withOpacity(0.1),
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
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
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
          color: theme.colorScheme.primary.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.1),
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
                  color: theme.colorScheme.primary.withOpacity(0.1),
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
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
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
                  color: theme.colorScheme.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: theme.colorScheme.secondary.withOpacity(0.3),
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
          color: theme.colorScheme.primary.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.08),
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
            color: theme.colorScheme.primary.withOpacity(0.3),
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
