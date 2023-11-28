enum ErrorType { data, domain, presentation, network, flutter }

enum ErrorTypeDetail { unauthorized }

class ErrorModel {
  final ErrorType type;
  final ErrorTypeDetail? typeDetail;
  final String? debugTitle;
  final String? debugText;
  final String shownTitle;
  final String shownText;
  final Object error;
  final StackTrace? stackTrace;
  final DateTime occurredAt;
  final void Function()? userRecoveryOption;
  final bool sendError;
  final bool isFatal;

  ErrorModel({
    required this.type,
    this.typeDetail,
    this.debugTitle,
    this.debugText,
    this.shownTitle = 'Error',
    this.shownText = 'An error occurred, please try again.',
    this.error = 'Unknown Error',
    this.stackTrace,
    DateTime? occurredAt,
    this.userRecoveryOption,
    this.sendError = true,
    this.isFatal = false,
  }) : occurredAt = occurredAt ?? DateTime.now();

  Map<String, Object> toJson() {
    final Map<String, Object> data = {
      'type': type.name,
      'shown_title': shownTitle,
      'shown_text': shownText,
      'error': error.toString(),
      'occurred_at': occurredAt.toIso8601String(),
      'send_error': sendError,
      'is_fatal': isFatal,
    };

    if (debugTitle != null) data['debug_title'] = debugTitle!;
    if (debugText != null) data['debug_text'] = debugText!;
    if (stackTrace != null) data['stack_trace'] = stackTrace.toString();
    if (userRecoveryOption != null) data['user_recovery_option'] = true;

    return data;
  }
}
