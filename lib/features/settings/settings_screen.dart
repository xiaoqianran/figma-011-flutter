import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:figma_011/core/services/app_state.dart';
import 'package:figma_011/core/theme/app_colors.dart';
import 'package:figma_011/core/theme/app_text_styles.dart';
import 'package:figma_011/shared/widgets/settings_toggle_row.dart';

/// App settings — Menu Setting item.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _pushNotification = AppState.instance.pushNotification;
  late bool _emailNotification = AppState.instance.emailNotification;
  late bool _locationServices = AppState.instance.locationServices;
  late String _language = AppState.instance.language;

  void _saveSettings({String? newLanguage}) {
    if (newLanguage != null) {
      _language = newLanguage;
    }
    AppState.instance.updateSettings(
      push: _pushNotification,
      email: _emailNotification,
      location: _locationServices,
      newLanguage: newLanguage,
    );
  }

  Future<void> _showLanguagePicker() async {
    final selected = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        backgroundColor: AppColors.black2,
        title: Text(
          'Select Language',
          style: AppTextStyles.dmSans(
            fontSize: 16,
            height: 26,
            color: AppColors.white,
          ),
        ),
        children: [
          for (final option in const ['English', 'Bengali', 'Hindi'])
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, option),
              child: Text(
                option,
                style: AppTextStyles.dmSans(
                  fontSize: 14,
                  height: 24,
                  color: _language == option
                      ? AppColors.primary
                      : AppColors.white,
                ),
              ),
            ),
        ],
      ),
    );

    if (selected != null && selected != _language) {
      setState(() => _saveSettings(newLanguage: selected));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black1,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _SettingsAppBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                children: [
                  Text(
                    'General',
                    style: AppTextStyles.merriweatherBold(
                      fontSize: 20,
                      height: 30,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SettingsToggleRow(
                    label: 'Push Notification',
                    value: _pushNotification,
                    onChanged: (value) {
                      setState(() {
                        _pushNotification = value;
                        _saveSettings();
                      });
                    },
                  ),
                  SettingsToggleRow(
                    label: 'Email Notification',
                    value: _emailNotification,
                    onChanged: (value) {
                      setState(() {
                        _emailNotification = value;
                        _saveSettings();
                      });
                    },
                  ),
                  SettingsToggleRow(
                    label: 'Location Services',
                    value: _locationServices,
                    onChanged: (value) {
                      setState(() {
                        _locationServices = value;
                        _saveSettings();
                      });
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(color: AppColors.white30),
                  ),
                  _SettingsInfoRow(
                    label: 'Language',
                    value: _language,
                    onTap: _showLanguagePicker,
                  ),
                  const _SettingsInfoRow(
                    label: 'App Version',
                    value: '1.0.0',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsAppBar extends StatelessWidget {
  const _SettingsAppBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 24, 0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.white,
                size: 24,
              ),
            ),
          ),
          Text(
            'Setting',
            style: AppTextStyles.dmSans(
              fontSize: 14,
              height: 24,
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsInfoRow extends StatelessWidget {
  const _SettingsInfoRow({
    required this.label,
    required this.value,
    this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.dmSans(
                  fontSize: 16,
                  height: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              value,
              style: AppTextStyles.dmSans(
                fontSize: 14,
                height: 24,
                color: AppColors.white60,
              ),
            ),
            if (onTap != null) ...[
              const SizedBox(width: 4),
              const Icon(
                Icons.chevron_right,
                size: 18,
                color: AppColors.white60,
              ),
            ],
          ],
        ),
      ),
    );
  }
}