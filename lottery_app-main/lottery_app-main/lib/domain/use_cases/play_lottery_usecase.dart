import '../entities/lottery_result.dart';
import '../../data/repositories/lottery_repository_impl.dart';

class PlayLotteryUseCase {
  final LotteryRepositoryImpl _repository;

  PlayLotteryUseCase(this._repository);

  LotteryResult execute({required int userNumber, String? userName}) {
    if (userNumber < 1 || userNumber > 10) {
      throw Exception('Number must be between 1 and 10');
    }

    final int winningNumber = _repository.generateLotteryNumber();

    final bool isWinner = userNumber == winningNumber;

    return LotteryResult(
      userNumber: userNumber,
      winningNumber: winningNumber,
      isWinner: isWinner,
      userName: userName,
    );
  }

  bool isValidNumber(int number) {
    return number >= 1 && number <= 10;
  }
}
