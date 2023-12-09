class Resource<T> {
  final ResourceStatus status;
  final T? data;
  final String? message;

  Resource(this.status, this.data, this.message);

  factory Resource.loading({T? data}) {
    return Resource(ResourceStatus.loading, data, null);
  }

  factory Resource.success(T data) {
    return Resource(ResourceStatus.success, data, null);
  }

  factory Resource.error(String message, {T? data}) {
    return Resource(ResourceStatus.error, data, message);
  }
}

enum ResourceStatus { loading, success, error }
