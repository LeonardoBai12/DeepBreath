abstract class Resource<T> {
  const Resource();
}

class Success<T> extends Resource<T> {
  final T data;
  Success(this.data);
}

class Error<T> extends Resource<T> {
  final String message;
  Error(this.message);
}

class Loading<T> extends Resource<T> {
  final bool isLoading;
  Loading(this.isLoading);
}
