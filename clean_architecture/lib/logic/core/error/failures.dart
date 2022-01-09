abstract class Failure {
  @override
  String toString();
}

class ServerFailure extends Failure {
  @override
  String toString() {
    return "Server Error";
  }
}

class CacheFailure extends Failure {
  @override
  String toString() {
    return "Local Storage Failure.";
  }
}
