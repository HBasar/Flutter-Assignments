import 'package:flutter/material.dart';
import 'package:lottery_app/presentation/core/gradient_scaffold.dart';
import 'package:lottery_app/presentation/provider/lotter_provider.dart';
import 'package:provider/provider.dart';
import '../core/app_colors.dart';
import 'result_screen.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});
  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  int? _selectedNumber;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LotteryProvider>(context);
    return GradientScaffold(
      title: 'Choose Your Luck',
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Icon(Icons.casino, size: 80, color: AppColors.accentCyan),
              const SizedBox(height: 20),
              const Text(
                'Pick Your Lucky Number',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Choose a number between 1-10',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: AppColors.whiteOpacity80),
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: AppColors.glassGradient,
                  ),
                  border: Border.all(
                    color: AppColors.whiteOpacity30,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blackOpacity10,
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    final number = index + 1;
                    final isSelected = _selectedNumber == number;
                    return GestureDetector(
                      onTap: () {
                        setState(() => _selectedNumber = number);
                        provider.setSelectedNumber(number);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: isSelected
                              ? LinearGradient(colors: AppColors.accentGradient)
                              : LinearGradient(colors: AppColors.tileGradient),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.accentCyanLight
                                : AppColors.whiteOpacity30,
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: AppColors.cyanShadow,
                                    blurRadius: 15,
                                    spreadRadius: 2,
                                  ),
                                ]
                              : [],
                        ),
                        child: Center(
                          child: Text(
                            '$number',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? AppColors.white
                                  : AppColors.whiteOpacity90,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              if (provider.errorMessage != null)
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: AppColors.redOpacity20,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.errorRed, width: 1.5),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          provider.errorMessage!,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ElevatedButton(
                onPressed: _selectedNumber == null
                    ? null
                    : () {
                        provider.playLottery();
                        if (provider.errorMessage == null)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ResultScreen(),
                            ),
                          );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedNumber != null
                      ? AppColors.accentCyan
                      : AppColors.disabledGrey,
                  foregroundColor: AppColors.buttonForeground,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 40,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: _selectedNumber != null ? 12 : 4,
                  shadowColor: _selectedNumber != null
                      ? AppColors.cyanShadow
                      : Colors.transparent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.play_arrow,
                      size: 28,
                      color: _selectedNumber != null
                          ? AppColors.buttonForeground
                          : AppColors.disabledGreyLight,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Play Lottery!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: _selectedNumber != null
                            ? AppColors.buttonForeground
                            : AppColors.disabledGreyLight,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: Text(
                  '✨ Good luck! ✨',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.whiteOpacity80,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
