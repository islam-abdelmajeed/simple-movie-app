import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'core/config/sentry_config.dart';
import 'core/di/dependency_injection.dart';
import 'core/theme/theme_manager.dart';
import 'movie_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SentryFlutter.init(
    (options) {
      // Configure Sentry only if enabled and DSN is set
      if (SentryConfig.enabled &&
          SentryConfig.sentryDsn != 'https://7768cace79a901f55936b3220a06e121@o4510289526259712.ingest.de.sentry.io/4510289531502672') {
        options.dsn = SentryConfig.sentryDsn;
        options.environment = SentryConfig.environment;
        options.release = SentryConfig.release;
        options.tracesSampleRate = SentryConfig.tracesSampleRate;
        options.attachStacktrace = true;
        options.enableUserInteractionTracing = SentryConfig.enableUserInteractionTracing;
      } else {
        // Disable Sentry if not configured
        options.dsn = null;
      }
    },
    appRunner: () async {
      await ThemeManager.init();
      await setupServiceLocator();
      runApp(const MovieApp());
    },
  );
}
