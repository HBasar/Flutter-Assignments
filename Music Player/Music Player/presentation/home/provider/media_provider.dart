
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
// Ensure these paths are correct!
import 'package:new_learn/data/model/song_model.dart';
import 'package:new_learn/domain/entities/song.dart';

class MediaProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<Song> _playlist = SongModel.getSampleSongs();

  int _currentIndex = 0;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  List<Song> get playlist => _playlist;
  Song? get currentSong => _playlist.isNotEmpty ? _playlist[_currentIndex] : null;
  bool get isPlaying => _isPlaying;
  Duration get duration => _duration;
  Duration get position => _position;
  int get currentIndex => _currentIndex;

  MediaProvider() {
    _initAudioPlayer();
  }

  void _initAudioPlayer() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _duration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      _position = newPosition;
      notifyListeners();
    });

    _audioPlayer.onPlayerStateChanged.listen((state) {
      _isPlaying = (state == PlayerState.playing);
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      playNext();
    });
  }

  Future<void> playPause() async {
    if (currentSong == null) return;

    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
      } else {
        // Source must be set before or during play
        await _audioPlayer.play(UrlSource(currentSong!.url));
      }
    } catch (e) {
      debugPrint("Error playing audio: $e");
    }
  }

  Future<void> playSongAtIndex(int index) async {
    if (index >= 0 && index < _playlist.length) {
      _currentIndex = index;
      try {
        await _audioPlayer.play(UrlSource(_playlist[_currentIndex].url));
        notifyListeners();
      } catch (e) {
        debugPrint("Error: $e");
      }
    }
  }

  Future<void> playNext() async {
    if (_playlist.isEmpty) return;
    _currentIndex = (_currentIndex + 1) % _playlist.length;
    await playSongAtIndex(_currentIndex);
  }

  Future<void> playPrevious() async {
    if (_playlist.isEmpty) return;
    _currentIndex = (_currentIndex - 1 + _playlist.length) % _playlist.length;
    await playSongAtIndex(_currentIndex);
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}