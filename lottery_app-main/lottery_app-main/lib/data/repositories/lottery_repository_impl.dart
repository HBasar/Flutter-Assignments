import 'dart:math';

class LotteryRepositoryImpl {
  final Random _random = Random();

  int generateLotteryNumber() {
    return _random.nextInt(10) + 1;
  }
}
