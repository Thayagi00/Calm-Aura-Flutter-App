import 'package:calm_aura/Common/color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';

class MoodTrackerPage extends StatefulWidget {
  @override
  _MoodTrackerPageState createState() => _MoodTrackerPageState();
}

class _MoodTrackerPageState extends State<MoodTrackerPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  String _selectedMood = "😊";
  final Map<DateTime, String> _moodMap = {};
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _subscribeToMoods();
  }

  void _subscribeToMoods() {
    _firestore.collection('moods').snapshots().listen((snapshot) {
      for (var doc in snapshot.docs) {
        final data = doc.data();
        if (data.containsKey('date') && data.containsKey('mood')) {
          final date = DateTime.parse(data['date']);
          setState(() {
            _moodMap[date] = data['mood'];
          });
        }
      }
    });
  }

  Future<void> _saveMoodToFirebase(DateTime date, String mood) async {
    try {
      final dateStr = date.toIso8601String();
      await _firestore
          .collection('moods')
          .doc(dateStr)
          .set({'date': dateStr, 'mood': mood});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mood saved for ${DateFormat.yMMMd().format(date)}'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save mood. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showMoodPopup(DateTime date) {
    final mood = _moodMap[date] ?? "No mood recorded";
    final formattedDate = DateFormat.yMMMd().format(date);
    final formattedTime = DateFormat.jm().format(date);

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 16,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple.shade100, Colors.blue.shade100],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Mood for $formattedDate',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple.shade900,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  mood,
                  style: TextStyle(fontSize: 50),
                ),
                SizedBox(height: 10),
                Text(
                  'Recorded at: $formattedTime',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 10),
                Text(
                  _getMoodMessage(mood),
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Close',
                    style: TextStyle(color: Colors.purple.shade900),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getMoodMessage(String mood) {
    switch (mood) {
      case "😊":
        return "Great! Keep smiling!";
      case "😐":
        return "It's okay to feel neutral.";
      case "😞":
        return "Take a moment to reflect.";
      case "😡":
        return "Breathe, it's okay to be angry.";
      case "😢":
        return "Remember, it's alright to feel sad.";
      default:
        return "Take care of your feelings!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text(
          'Mood Tracker',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Coloors.purple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 36),
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _selectedDay,
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _selectedMood = _moodMap[selectedDay] ?? "😊"; // Default mood
                });
                if (!isSameDay(selectedDay, DateTime.now())) {
                  _showMoodPopup(selectedDay);
                }
              },
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              calendarStyle: CalendarStyle(
                markersMaxCount: 1,
                todayDecoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  shape: BoxShape.circle,
                ),
              ),
              eventLoader: (day) {
                return _moodMap.containsKey(day)
                    ? [
                        Text(
                          _moodMap[day]!,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )
                      ]
                    : [];
              },
            ),
            SizedBox(height: 20),
            Text(
              'How\'s your day today?',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _moodButton("😊", Colors.green),
                  _moodButton("😐", Colors.yellow),
                  _moodButton("😞", Colors.orange),
                  _moodButton("😡", Colors.redAccent),
                  _moodButton("😢", Colors.blue),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isSameDay(_selectedDay, DateTime.now())
                  ? () async {
                      setState(() {
                        _moodMap[_selectedDay] = _selectedMood;
                      });
                      await _saveMoodToFirebase(_selectedDay, _selectedMood);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Coloors.purple,
                padding: const EdgeInsets.symmetric(
                    horizontal: 130.0, vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                textStyle: const TextStyle(fontSize: 18.0),
              ),
              child: Text(
                'Save Mood',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Mood button widget
  Widget _moodButton(String emoji, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMood = emoji;
        });
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _selectedMood == emoji ? color : Colors.grey[200],
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          emoji,
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
