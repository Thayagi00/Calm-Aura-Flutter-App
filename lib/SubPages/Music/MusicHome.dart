import 'package:audioplayers/audioplayers.dart';
import 'package:calm_aura/Common/color.dart';
import 'package:calm_aura/SubPages/Music/SoundCard.dart';

import 'package:flutter/material.dart';

class MusicHome extends StatefulWidget {
  const MusicHome({super.key});

  @override
  State<MusicHome> createState() => _MusicHomeState();
}

class _MusicHomeState extends State<MusicHome> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlayPause(String audioAsset) async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.setSource(AssetSource(audioAsset));
      await _audioPlayer.resume();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          'Relaxing Sounds',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Coloors.purple,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSoundCard(
                title: 'Summer Sounds',
                description: 'Soothing sounds of nature',
                duration: '3 Min',
                imageAsset: 'assets/images/rain.jpg',
                audioAsset: 'assets/audio/sec.mp3',
              ),
              const SizedBox(height: 16.0),
              _buildSoundCard(
                title: 'Summer Sounds',
                description: 'Soothing sounds of nature',
                duration: '3 Min',
                imageAsset: 'assets/images/rain.jpg',
                audioAsset: 'assets/audio/first.mp3',
              ),
              // Add more sound cards as needed
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildSoundCard({
    required String title,
    required String description,
    required String duration,
    required String imageAsset,
    required String audioAsset,
  }) {
    return SoundCard(
      title: title,
      description: description,
      duration: duration,
      imageAsset: imageAsset,
      audioAsset: audioAsset,
      isPlaying: _isPlaying,
      onPlayPause: _togglePlayPause,
    );
  }

  Widget _buildBottomBar() {
    return BottomAppBar(
      color: Coloors.blue,
      child: Container(
        height: 70.0,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Now Playing: Summer Sounds',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            IconButton(
              icon: Icon(
                _isPlaying
                    ? Icons.pause_circle_filled
                    : Icons.play_circle_filled,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                _togglePlayPause('assets/audio/first.mp3');
              },
            ),
          ],
        ),
      ),
    );
  }
}
