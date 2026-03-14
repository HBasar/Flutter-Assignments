

import 'package:flutter/material.dart';
import 'package:new_learn/core/constants/app_colors.dart';
import 'package:new_learn/core/constants/app_strings.dart';
import 'package:new_learn/presentation/home/provider/media_provider.dart';
import 'package:new_learn/presentation/home/widget/player_controller.dart';
import 'package:new_learn/presentation/home/widget/song_list_item.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          AppStrings.appName,
          style: TextStyle(color: AppColors.textPrimary),
        ),
        backgroundColor: AppColors.surface,
      ),
      body: Column(
        children: [
          PlayerController(),
          Expanded(
            child: Consumer<MediaProvider>(
                builder: (context, provider,child){
                  final playList = provider.playlist;
                  return ListView.builder(
                    itemCount: playList.length,
                    itemBuilder: (context,index){
                      final song = playList[index];
                      final isSelected = index == provider.currentIndex;
                      return SongListItem(
                        song: song,
                        index: index,
                        isPlaying: provider.isPlaying,
                        isSelected: isSelected,
                        onTap: (){
                          provider.playSongAtIndex(index);
                        },
                      );
                    },);
                }
            ),
          )
        ],
      ),
    );
  }
}