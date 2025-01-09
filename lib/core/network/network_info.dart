// lib/core/network/network_info.dart

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    // Here, you can implement network connectivity check
    // For example, using the `connectivity_plus` package or other ways to check connection status.
    return true; // assuming always connected for this example
  }
}
