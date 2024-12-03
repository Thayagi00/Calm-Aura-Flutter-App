import 'package:flutter/material.dart';

class PalyMusic extends StatefulWidget {
  const PalyMusic({super.key});

  @override
  State<PalyMusic> createState() => _PalyMusicState();
}

class _PalyMusicState extends State<PalyMusic> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SoundCard(
              title: 'Painting Forest',
              description: '',
              duration: '25 Min',
              imageAsset: 'assets/painting_forest.jpg',
            ),
          ],
        ),
      ),
    );
  }
}

class _SoundCard extends StatelessWidget {
  final String title;
  final String description;
  final String duration;
  final String imageAsset;

  _SoundCard({
    required this.title,
    required this.description,
    required this.duration,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to sound player screen
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                imageAsset,
                width: 80.0,
                height: 80.0,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  Spacer(),
                  Text(
                    duration,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Color(0xFF449D44),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
