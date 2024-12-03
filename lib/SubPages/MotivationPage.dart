import 'package:calm_aura/Common/color.dart';
import 'package:calm_aura/Services/NotificationService.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'dart:math';

class MotivationPage extends StatelessWidget {
  MotivationPage({super.key}) {
    // Initialize timezone data
    tz.initializeTimeZones();
    NotificationService.initialize(); // Initialize notifications
  }

  final List<Map<String, String>> quotes = [
    {
      "quote": "Believe you can and you're halfway there.",
      "author": "Theodore Roosevelt",
    },
    {
      "quote":
          "Success is not final, failure is not fatal: It is the courage to continue that counts.",
      "author": "Winston Churchill",
    },
    {
      "quote": "Don’t watch the clock; do what it does. Keep going.",
      "author": "Sam Levenson",
    },
    {
      "quote": "The only way to do great work is to love what you do.",
      "author": "Steve Jobs",
    },
    {
      "quote": "Dream big and dare to fail.",
      "author": "Norman Vaughan",
    },
    {
      "quote": "It always seems impossible until it’s done.",
      "author": "Nelson Mandela",
    },
    {
      "quote": "Your limitation—it's only your imagination.",
      "author": "",
    },
    {
      "quote": "Push yourself, because no one else is going to do it for you.",
      "author": "",
    },
    {
      "quote": "Great things never come from comfort zones.",
      "author": "",
    },
    {
      "quote": "Don’t stop when you’re tired. Stop when you’re done.",
      "author": "",
    },
    {
      "quote":
          "Success usually comes to those who are too busy to be looking for it.",
      "author": "Henry David Thoreau",
    },
    {
      "quote":
          "The harder you work for something, the greater you’ll feel when you achieve it.",
      "author": "",
    },
    {
      "quote": "Dream it. Wish it. Do it.",
      "author": "",
    },
    {
      "quote":
          "Success is not how high you have climbed, but how you make a positive difference to the world.",
      "author": "Roy T. Bennett",
    },
    {
      "quote":
          "The future belongs to those who believe in the beauty of their dreams.",
      "author": "Eleanor Roosevelt",
    },
    {
      "quote":
          "What lies behind us and what lies before us are tiny matters compared to what lies within us.",
      "author": "Ralph Waldo Emerson",
    },
    {
      "quote": "Act as if what you do makes a difference. It does.",
      "author": "William James",
    },
    {
      "quote":
          "You are never too old to set another goal or to dream a new dream.",
      "author": "C.S. Lewis",
    },
    {
      "quote": "You miss 100% of the shots you don’t take.",
      "author": "Wayne Gretzky",
    },
    {
      "quote":
          "If you want something you’ve never had, you must be willing to do something you’ve never done.",
      "author": "Thomas Jefferson",
    },
    {
      "quote":
          "Hardships often prepare ordinary people for an extraordinary destiny.",
      "author": "C.S. Lewis",
    },
    {
      "quote": "The way to get started is to quit talking and begin doing.",
      "author": "Walt Disney",
    },
    {
      "quote":
          "Believe in yourself and all that you are. Know that there is something inside you that is greater than any obstacle.",
      "author": "Christian D. Larson",
    },
    {
      "quote":
          "Success is not the key to happiness. Happiness is the key to success. If you love what you are doing, you will be successful.",
      "author": "Albert Schweitzer",
    },
    {
      "quote": "If you can dream it, you can achieve it.",
      "author": "Zig Ziglar",
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Schedule notifications at specified times
    scheduleDailyNotifications();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          'Motivational Quotes',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Coloors.purple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: quotes.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                elevation: 8.0,
                shadowColor: Colors.grey.withOpacity(0.5),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.format_quote,
                        color: Coloors.purple,
                        size: 30.0,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        quotes[index]['quote']!,
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8.0),
                      const Divider(
                        color: Coloors.purple,
                        thickness: 1.5,
                      ),
                      Text(
                        '- ${quotes[index]['author']}',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Coloors.blue,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void scheduleDailyNotifications() {
    final Random random = Random();

    // Generate a random quote index
    int quoteIndex = random.nextInt(quotes.length);
    String quote = quotes[quoteIndex]['quote']!;
    String author = quotes[quoteIndex]['author']!;

    // Schedule notifications for three times a day
    NotificationService.scheduleQuoteNotification(quote, author,
        tz.TZDateTime.now(tz.local).add(const Duration(hours: 9))); // 9:00 AM
    NotificationService.scheduleQuoteNotification(
        quote,
        author,
        tz.TZDateTime.now(tz.local)
            .add(const Duration(hours: 12, minutes: 39))); // 12:30 PM
    NotificationService.scheduleQuoteNotification(quote, author,
        tz.TZDateTime.now(tz.local).add(const Duration(hours: 21))); // 9:00 PM
  }
}
