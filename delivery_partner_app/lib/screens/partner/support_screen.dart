import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        appBar: AppBar(
          title: const Text('Help & Support'),
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            indicatorColor: AppColors.accent,
            labelStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w600),
            tabs: const [
              Tab(text: 'FAQs'),
              Tab(text: 'Raise Ticket'),
              Tab(text: 'Live Chat'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _FaqsTab(),
            _RaiseTicketTab(),
            _LiveChatTab(),
          ],
        ),
      ),
    );
  }
}

class _FaqsTab extends StatelessWidget {
  final faqs = const [
    {
      'q': 'How do I accept or reject an order?',
      'a':
          'When a new order comes in, you\'ll see a full-screen popup with order details and a 30-second countdown. Tap "Accept" to take the order or "Reject" to pass.'
    },
    {
      'q': 'How are earnings calculated?',
      'a':
          'Earnings include base pay per order, distance bonus, peak-hour incentives, and customer tips. Penalties for late deliveries are deducted.'
    },
    {
      'q': 'When can I withdraw my earnings?',
      'a':
          'You can withdraw available balance anytime. The amount will be transferred to your linked bank account within 24 hours.'
    },
    {
      'q': 'What documents are required?',
      'a':
          'You need a valid Aadhaar card, PAN card, driving license, and bank account details to complete your profile setup.'
    },
    {
      'q': 'How do I change my vehicle details?',
      'a':
          'Go to Profile → Vehicle Info → Edit. You may need to upload updated documents for verification.'
    },
    {
      'q': 'What happens if I reject too many orders?',
      'a':
          'Consistently rejecting orders may affect your acceptance rate and could impact your eligibility for incentives.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: faqs.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 16),
            childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            title: Text(
              faqs[index]['q']!,
              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            children: [
              Text(
                faqs[index]['a']!,
                style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textSecondary),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RaiseTicketTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Raise a Support Ticket',
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text('Describe your issue and we\'ll get back to you within 24 hours.',
              style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textSecondary)),
          const SizedBox(height: 20),
          Text('Category',
              style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(),
            items: ['Order Issue', 'Payment Issue', 'Account Issue', 'App Bug', 'Other']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (_) {},
            hint: const Text('Select category'),
          ),
          const SizedBox(height: 16),
          Text('Subject',
              style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          const TextField(decoration: InputDecoration(hintText: 'Brief subject line')),
          const SizedBox(height: 16),
          Text('Description',
              style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          const TextField(
            maxLines: 5,
            decoration: InputDecoration(hintText: 'Describe your issue in detail...'),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Ticket submitted successfully!',
                        style: GoogleFonts.dmSans()),
                    backgroundColor: AppColors.success,
                  ),
                );
              },
              child: const Text('Submit Ticket'),
            ),
          ),
        ],
      ),
    );
  }
}

class _LiveChatTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.chat_bubble_outline,
                  size: 48, color: AppColors.primary),
            ),
            const SizedBox(height: 24),
            Text('Live Chat',
                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              'Our support team is available 24/7.\nStart a conversation to get instant help.',
              style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Connecting to support agent...',
                        style: GoogleFonts.dmSans()),
                    backgroundColor: AppColors.primary,
                  ),
                );
              },
              icon: const Icon(Icons.chat),
              label: const Text('Start Chat'),
            ),
          ],
        ),
      ),
    );
  }
}
