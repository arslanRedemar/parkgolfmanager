abstract class Failure {
  final String message;
  final StackTrace? stackTrace;

  Failure(this.message, [this.stackTrace]);

  @override
  String toString() => '$runtimeType: $message';
}

// ✅ DB 작업 실패
class DatabaseFailure extends Failure {
  DatabaseFailure(String message, [StackTrace? stackTrace])
    : super(message, stackTrace);
}

// ✅ 네트워크 실패 (향후 확장용)
class NetworkFailure extends Failure {
  NetworkFailure(String message, [StackTrace? stackTrace])
    : super(message, stackTrace);
}

// ✅ 인증 실패 (예: 로그인)
class AuthFailure extends Failure {
  AuthFailure(String message, [StackTrace? stackTrace])
    : super(message, stackTrace);
}

// ✅ 기타 예외
class UnknownFailure extends Failure {
  UnknownFailure(String message, [StackTrace? stackTrace])
    : super(message, stackTrace);
}
