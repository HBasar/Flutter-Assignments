class LotteryResult {
  final int userNumber;

  final int winningNumber;

  final bool isWinner;

  final String? userName;

  LotteryResult({
    required this.userNumber,
    required this.winningNumber,
    required this.isWinner,
    this.userName,
  });

  String getResultMessage() {
    if (isWinner) {
      return 'You Win!';
    } else {
      return 'Better luck next time!';
    }
  }
}
