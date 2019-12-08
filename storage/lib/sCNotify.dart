class sCNotify implements Exception {
  String cause;
  sCNotify(this.cause, sCNotifyTypes type) {
    /// Checkout this page for the coloring:
    /// http://www.lihaoyi.com/post/BuildyourownCommandLinewithANSIescapecodes.html
    switch (type) {
      case sCNotifyTypes.SUCCESS:
        print("\u001b[1m\u001b[7m\u001b[32m schmuckliCloud SDK \u001b[0m\r\n\u001b[32m" + cause + "\x1B[0m");
        break;
      case sCNotifyTypes.WARNING:
        print("\u001b[1m\u001b[7m\u001b[33m schmuckliCloud SDK \u001b[0m\r\n\u001b[33m" + cause + "\x1B[0m");
        break;
      case sCNotifyTypes.ERROR:
        print("\u001b[1m\u001b[7m\u001b[31m schmuckliCloud SDK \u001b[0m\r\n\u001b[31m" + cause + "\x1B[0m");
        break;
      case sCNotifyTypes.INFO:
        print("\u001b[1m\u001b[7m\u001b[34m schmuckliCloud SDK \u001b[0m\r\n\u001b[34m" + cause + "\x1B[0m");
        break;
    }
  }
}

enum sCNotifyTypes {
  SUCCESS,
  ERROR,
  INFO,
  WARNING
}