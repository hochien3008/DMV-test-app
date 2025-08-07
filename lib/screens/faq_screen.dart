import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final List<FAQItem> _faqs = [
    FAQItem(
      question: 'What documents do I need for the DMV test?',
      answer:
          'You need a valid ID, proof of residency, and your learner\'s permit. Some states also require proof of insurance and vehicle registration.',
    ),
    FAQItem(
      question: 'How many questions are on the DMV test?',
      answer:
          'Most states have 25-50 questions on the written test. You need to answer 70-80% correctly to pass.',
    ),
    FAQItem(
      question: 'Can I retake the test if I fail?',
      answer:
          'Yes, you can retake the test. Most states allow retakes after a waiting period, usually 1-7 days.',
    ),
    FAQItem(
      question: 'What is the minimum age to get a driver\'s license?',
      answer:
          'The minimum age varies by state, typically 16-18 years old. Some states have graduated licensing programs.',
    ),
    FAQItem(
      question: 'Do I need to take a driving test?',
      answer:
          'Yes, most states require both a written test and a road test. Some states may waive the road test for certain age groups.',
    ),
    FAQItem(
      question: 'How long is my driver\'s license valid?',
      answer:
          'Driver\'s licenses are typically valid for 4-8 years, depending on your state and age.',
    ),
    FAQItem(
      question: 'What happens if I get a traffic ticket?',
      answer:
          'Traffic tickets can result in fines, points on your license, and increased insurance rates. Serious violations may lead to license suspension.',
    ),
    FAQItem(
      question: 'Can I drive in other states with my license?',
      answer:
          'Yes, all U.S. driver\'s licenses are valid in other states. International visitors may need an International Driving Permit.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DMV FAQ'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _faqs.length,
        itemBuilder: (context, index) {
          return _buildFAQItem(_faqs[index]);
        },
      ),
    );
  }

  Widget _buildFAQItem(FAQItem faq) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        title: Text(
          faq.question,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(faq.answer, style: const TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}
