import 'package:flutter/material.dart';

void main() {
  runApp(const AnimatedSizeDemoApp());
}

class AnimatedSizeDemoApp extends StatelessWidget {
  const AnimatedSizeDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AnimatedSize Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
      ),
      home: const AnimatedSizeDemoPage(),
    );
  }
}

class AnimatedSizeDemoPage extends StatefulWidget {
  const AnimatedSizeDemoPage({super.key});

  @override
  State<AnimatedSizeDemoPage> createState() => _AnimatedSizeDemoPageState();
}

class _AnimatedSizeDemoPageState extends State<AnimatedSizeDemoPage> {
  bool profileExpanded = false;
  bool faqExpanded = false;
  bool descriptionExpanded = false;
  bool showValidationError = false;
  bool showNotification = false;
  bool productExpanded = false;
  bool settingsExpanded = false;
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AnimatedSize'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildIntroductionCard(),

          const SizedBox(height: 20),

          _buildSectionTitle('1. Expandable Profile Card'),

          _buildProfileCard(),

          const SizedBox(height: 24),

          _buildSectionTitle('2. FAQ / Accordion'),

          _buildFaqCard(),

          const SizedBox(height: 24),

          _buildSectionTitle('3. Read More'),

          _buildReadMoreCard(),

          const SizedBox(height: 24),

          _buildSectionTitle('4. Form Validation Error'),

          _buildValidationCard(),

          const SizedBox(height: 24),

          _buildSectionTitle('5. Dynamic Notification'),

          _buildNotificationCard(),

          const SizedBox(height: 24),

          _buildSectionTitle('6. Product Details'),

          _buildProductCard(),

          const SizedBox(height: 24),

          _buildSectionTitle('7. Settings Section'),

          _buildSettingsCard(),

          const SizedBox(height: 32),

          _buildConceptSummary(),
        ],
      ),
    );
  }

  Widget _buildIntroductionCard() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AnimatedSize',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              'AnimatedSize smoothly animates changes in the '
              'size of its child.',
              style: TextStyle(fontSize: 15, height: 1.5),
            ),

            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.indigo.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Core idea:\n\n'
                'Child size changes\n'
                '        ↓\n'
                'AnimatedSize detects it\n'
                '        ↓\n'
                'Flutter animates the transition',
                style: TextStyle(height: 1.5, fontFamily: 'monospace'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  // ------------------------------------------------------------
  // 1. PROFILE CARD
  // ------------------------------------------------------------

  Widget _buildProfileCard() {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            leading: const CircleAvatar(radius: 26, child: Icon(Icons.person)),
            title: const Text(
              'Nabiullah Habibi',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('Flutter Developer'),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  profileExpanded = !profileExpanded;
                });
              },
              icon: AnimatedRotation(
                duration: const Duration(milliseconds: 300),
                turns: profileExpanded ? 0.5 : 0,
                child: const Icon(Icons.keyboard_arrow_down),
              ),
            ),
          ),

          AnimatedSize(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: profileExpanded
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(),

                        const SizedBox(height: 8),

                        const Text(
                          'About',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 6),

                        const Text(
                          'Flutter developer focused on building '
                          'clean, scalable, performant and '
                          'production-ready applications.',
                          style: TextStyle(height: 1.5),
                        ),

                        const SizedBox(height: 16),

                        Row(
                          children: [
                            Expanded(
                              child: _buildProfileStat('Projects', '24'),
                            ),
                            Expanded(
                              child: _buildProfileStat('Experience', '4y'),
                            ),
                            Expanded(child: _buildProfileStat('Apps', '12')),
                          ],
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStat(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  // ------------------------------------------------------------
  // 2. FAQ / ACCORDION
  // ------------------------------------------------------------

  Widget _buildFaqCard() {
    return Card(
      elevation: 0,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                faqExpanded = !faqExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'What is AnimatedSize?',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),

                  AnimatedRotation(
                    duration: const Duration(milliseconds: 300),
                    turns: faqExpanded ? 0.5 : 0,
                    child: const Icon(Icons.keyboard_arrow_down),
                  ),
                ],
              ),
            ),
          ),

          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: faqExpanded
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: const Text(
                      'AnimatedSize is an implicit animation '
                      'widget that automatically animates the '
                      'size changes of its child. It is especially '
                      'useful for expandable content, FAQ sections, '
                      'validation messages, dynamic text, cards, '
                      'settings sections and other layouts where '
                      'the natural size of the child changes.',
                      style: TextStyle(height: 1.5, color: Colors.black87),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // 3. READ MORE
  // ------------------------------------------------------------

  Widget _buildReadMoreCard() {
    const shortText =
        'Flutter is a UI toolkit for building beautiful '
        'applications.';

    const longText =
        'Flutter is a UI toolkit for building beautiful, '
        'natively compiled applications for mobile, web, '
        'desktop and embedded platforms from a single '
        'codebase. It provides a rich widget system, '
        'powerful rendering pipeline, excellent developer '
        'tools and a productive reactive programming model.';

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: Text(
                descriptionExpanded ? longText : shortText,
                style: const TextStyle(height: 1.5),
              ),
            ),

            const SizedBox(height: 12),

            TextButton(
              onPressed: () {
                setState(() {
                  descriptionExpanded = !descriptionExpanded;
                });
              },
              child: Text(descriptionExpanded ? 'Read less' : 'Read more'),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // 4. FORM VALIDATION
  // ------------------------------------------------------------

  Widget _buildValidationCard() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Email', style: TextStyle(fontWeight: FontWeight.w600)),

            const SizedBox(height: 8),

            const TextField(
              decoration: InputDecoration(
                hintText: 'example@email.com',
                border: OutlineInputBorder(),
              ),
            ),

            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              alignment: Alignment.topCenter,
              child: showValidationError
                  ? Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.error_outline,
                            size: 18,
                            color: Colors.red,
                          ),
                          SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'Please enter a valid email address.',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),

            const SizedBox(height: 16),

            FilledButton(
              onPressed: () {
                setState(() {
                  showValidationError = !showValidationError;
                });
              },
              child: Text(
                showValidationError ? 'Hide Error' : 'Show Validation Error',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // 5. NOTIFICATION
  // ------------------------------------------------------------

  Widget _buildNotificationCard() {
    return Card(
      elevation: 0,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: const Text('Notifications'),
            subtitle: const Text('Show dynamic notification content'),
            trailing: Switch(
              value: showNotification,
              onChanged: (value) {
                setState(() {
                  showNotification = value;
                });
              },
            ),
          ),

          AnimatedSize(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: showNotification
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.orange.withValues(alpha: 0.12),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.info_outline, color: Colors.orange),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'New update available',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'A new version of the app '
                                  'contains performance improvements '
                                  'and several bug fixes.',
                                  style: TextStyle(height: 1.4),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // 6. PRODUCT DETAILS
  // ------------------------------------------------------------

  Widget _buildProductCard() {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            height: 160,
            width: double.infinity,
            alignment: Alignment.center,
            color: Colors.indigo.withValues(alpha: 0.12),
            child: const Icon(Icons.phone_android, size: 72),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Flutter Smartphone',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 4),

                const Text(
                  '\$799',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 12),

                AnimatedSize(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeInOut,
                  alignment: Alignment.topCenter,
                  child: productExpanded
                      ? const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(),

                            SizedBox(height: 8),

                            Text(
                              'Product Details',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),

                            SizedBox(height: 8),

                            Text(
                              'A powerful smartphone designed '
                              'for developers and professionals. '
                              'It includes a high-resolution display, '
                              'long battery life and fast performance.',
                              style: TextStyle(height: 1.5),
                            ),

                            SizedBox(height: 12),

                            Row(
                              children: [
                                Icon(Icons.star, size: 20),
                                SizedBox(width: 4),
                                Text('4.8 / 5'),
                              ],
                            ),

                            SizedBox(height: 12),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        productExpanded = !productExpanded;
                      });
                    },
                    child: Text(
                      productExpanded ? 'Hide Details' : 'Show Details',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // 7. SETTINGS
  // ------------------------------------------------------------

  Widget _buildSettingsCard() {
    return Card(
      elevation: 0,
      child: Column(
        children: [
          SwitchListTile(
            title: const Text('Notifications'),
            subtitle: const Text('Enable notification settings'),
            value: notificationsEnabled,
            onChanged: (value) {
              setState(() {
                notificationsEnabled = value;
              });
            },
          ),

          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: notificationsEnabled
                ? Column(
                    children: [
                      const Divider(height: 1),

                      SwitchListTile(
                        title: const Text('Sound'),
                        value: true,
                        onChanged: (_) {},
                      ),

                      SwitchListTile(
                        title: const Text('Vibration'),
                        value: true,
                        onChanged: (_) {},
                      ),

                      SwitchListTile(
                        title: const Text('Show Preview'),
                        value: true,
                        onChanged: (_) {},
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // SUMMARY
  // ------------------------------------------------------------

  Widget _buildConceptSummary() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AnimatedSize Mental Model',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            _buildSummaryRow('Child changes size', 'Detect the layout change'),

            _buildSummaryRow('AnimatedSize', 'Animates the size transition'),

            _buildSummaryRow('State', 'Controls when the content changes'),

            _buildSummaryRow('Duration', 'Controls animation speed'),

            _buildSummaryRow('Curve', 'Controls motion behavior'),

            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.green.withValues(alpha: 0.08),
              ),
              child: const Text(
                'Senior rule:\n\n'
                'Use AnimatedSize when the child naturally '
                'changes its layout size and you want the '
                'surrounding layout to transition smoothly.',
                style: TextStyle(height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black87, height: 1.4),
                children: [
                  TextSpan(
                    text: '$title: ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
