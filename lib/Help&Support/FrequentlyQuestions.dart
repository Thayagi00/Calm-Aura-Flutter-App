import 'package:calm_aura/Common/color.dart';
import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  final List<Map<String, String>> faqs = [
    {
      "question": "How can I contact support?",
      "answer":
          "You can contact support via the 'Contact Support' page, where you can submit your queries."
    },
    {
      "question": "How do I reset my password?",
      "answer":
          "To reset your password, go to Settings > Account > Reset Password, and follow the prompts."
    },
    {
      "question": "Is my data secure with Calm Aura?",
      "answer":
          "Yes, we ensure your data is encrypted and stored securely. Our app adheres to strict privacy policies."
    },
    {
      "question": "What platforms is Calm Aura available on?",
      "answer":
          "Calm Aura is available on both Android and iOS devices. You can download it from the respective app stores."
    },
    {
      "question": "Can I delete my account?",
      "answer":
          "Yes, you can delete your account by going to Settings > Account > Delete Account. Please note that this action is irreversible."
    },
    {
      "question": "How do I provide feedback about the app?",
      "answer":
          "You can provide feedback through the 'Feedback' section in the app settings, or you can email us directly at support@calmaura.com."
    },
    {
      "question": "Are there any subscription fees?",
      "answer":
          "Calm Aura is free to download and use. Some features may require a premium subscription for access."
    },
    {
      "question": "How can I track my mood?",
      "answer":
          "You can track your mood by navigating to the 'Mood Tracking' section in the app, where you can log your daily feelings."
    },
    // Add more questions and answers as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          "Frequently Asked Questions",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Coloors.purple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Find answers to common questions.",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ...faqs
                .map((faq) => _buildFAQTile(faq["question"]!, faq["answer"]!)),
            const SizedBox(height: 80), // Space for FAB
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 50),
        child: FloatingActionButton(
          onPressed: () {
            _showChatBotDialog(context);
          },
          backgroundColor: Coloors.purple,
          child: const Icon(Icons.support_agent, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildFAQTile(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Coloors.purple,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              answer,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  void _showChatBotDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return ChatBotDialog();
      },
    );
  }
}

class ChatBotDialog extends StatefulWidget {
  @override
  _ChatBotDialogState createState() => _ChatBotDialogState();
}

class _ChatBotDialogState extends State<ChatBotDialog> {
  final List<String> messages = [];
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        width: 300,
        height: 400,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Chat with our Support Bot',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(messages[index]),
                    tileColor:
                        index.isEven ? Colors.grey.shade100 : Colors.white,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: 'Type your message...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        setState(() {
                          messages.add("You: ${_controller.text}");
                          messages.add("Bot: Thank you for your message!");
                          _controller.clear();
                        });
                      }
                    },
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
