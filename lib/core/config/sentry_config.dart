/// Sentry Configuration
/// 
/// To set up Sentry:
/// 1. Create a project at https://sentry.io
/// 2. Get your DSN from: https://sentry.io/settings/<your-org>/projects/<your-project>/keys/
/// 3. Replace [sentryDsn] with your actual DSN
/// 4. For production, consider using environment variables or build configurations
class SentryConfig {
  /// Your Sentry DSN (Data Source Name)
  /// 
  /// Replace this with your actual Sentry DSN from your Sentry project settings.
  /// Format: https://<key>@<org>.ingest.sentry.io/<project-id>
  static const String sentryDsn = 'YOUR_SENTRY_DSN_HERE';
  
  /// Sentry environment (e.g., 'development', 'staging', 'production')
  static const String environment = 'production';
  
  /// Release version (should match pubspec.yaml version)
  static const String release = 'week_5@1.0.0+1';
  
  /// Performance monitoring sample rate (0.0 to 1.0)
  /// 1.0 = 100% of transactions, 0.0 = 0% of transactions
  static const double tracesSampleRate = 1.0;
  
  /// Automatic breadcrumb tracking is enabled by default in Sentry Flutter
  
  /// Enable user interaction tracing
  static const bool enableUserInteractionTracing = true;
  
  /// Enable Sentry (set to false to disable Sentry completely)
  /// Useful for local development or testing
  static const bool enabled = true;
}

