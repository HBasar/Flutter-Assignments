import 'package:flutter/material.dart';
import 'package:lottery_app/presentation/core/gradient_scaffold.dart';
import 'package:lottery_app/presentation/provider/lotter_provider.dart';
import 'package:provider/provider.dart';
import '../core/app_colors.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LotteryProvider>();
    final result = provider.lotteryResult;

    if (result == null) {
      return const GradientScaffold(
        title: 'Result',
        body: Center(
          child: Text(
            'No lottery result found!',
            style: TextStyle(color: AppColors.white, fontSize: 18),
          ),
        ),
      );
    }

    return GradientScaffold(
      title: 'Result',
      showBackButton: false,
      gradientColors: result.isWinner ? AppColors.winGradient : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildResultIcon(result.isWinner),
                  const SizedBox(height: 24),
                  Text(
                    result.isWinner ? 'YOU WIN!' : 'BETTER LUCK NEXT TIME!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildNumberCard(result),
                  const SizedBox(height: 40),
                  ElevatedButton.icon(
                    onPressed: () {
                      provider.reset();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                        (_) => false,
                      );
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text(
                      'Try Again',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      foregroundColor: AppColors.buttonForeground,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    result.isWinner
                        ? 'Congratulations! You\'re a winner!'
                        : 'Keep trying, your luck will turn!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.whiteOpacity90,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultIcon(bool isWinner) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.whiteOpacity20,
      ),
      child: Text(isWinner ? '🎉' : '😢', style: const TextStyle(fontSize: 64)),
    );
  }

  Widget _buildNumberCard(result) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.whiteOpacity15,
        border: Border.all(color: AppColors.whiteOpacity30),
      ),
      child: Column(
        children: [
          _buildNumber(
            'Your Number',
            result.userNumber,
            AppColors.blueAccent,
            Icons.person,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Divider(color: AppColors.whiteOpacity50, thickness: 1),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'VS',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteOpacity80,
                  ),
                ),
              ),
              Expanded(
                child: Divider(color: AppColors.whiteOpacity50, thickness: 1),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildNumber(
            'Winning Number',
            result.winningNumber,
            result.isWinner ? AppColors.accentCyan : AppColors.purpleAccent,
            Icons.stars,
          ),
        ],
      ),
    );
  }

  Widget _buildNumber(String label, int number, Color color, IconData icon) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: [color, color.withOpacity(0.7)]),
          ),
          child: Center(
            child: Text(
              '$number',
              style: const TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
