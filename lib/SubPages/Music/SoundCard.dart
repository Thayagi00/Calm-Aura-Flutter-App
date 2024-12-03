import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class SoundCard extends StatefulWidget {
  final String title;
  final String description;
  final String duration;
  final String imageAsset;
  final String audioAsset;
  final bool isPlaying;
  final Function(String) onPlayPause;

  const SoundCard({
    Key? key,
    required this.title,
    required this.description,
    required this.duration,
    required this.imageAsset,
    required this.audioAsset,
    required this.isPlaying,
    required this.onPlayPause,
  }) : super(key: key);

  @override
  _SoundCardState createState() => _SoundCardState();
}

class _SoundCardState extends State<SoundCard> {
  final _isPlayingNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _isPlayingNotifier.value = widget.isPlaying;
  }

  @override
  void dispose() {
    _isPlayingNotifier.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    _isPlayingNotifier.value = !_isPlayingNotifier.value;
    widget.onPlayPause(widget.audioAsset);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePlayPause,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                widget.imageAsset,
                width: 90.0,
                height: 90.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    widget.description,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    widget.duration,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Color(0xFF449D44),
                    ),
                  ),
                ],
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _isPlayingNotifier,
              builder: (context, isPlaying, child) {
                return IconButton(
                  icon: Icon(
                    isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_filled,
                    color: Colors.deepPurpleAccent,
                    size: 40,
                  ),
                  onPressed: _togglePlayPause,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
