import 'package:flutter/material.dart';

// ---------- THEME COLORS ----------
const Color bg = Color(0xFF0B0F1E);
const Color cardColor = Color(0xFF161B33);
const Color borderColor = Color(0xFF272D52);
const Color muted = Color(0xFF9AA0C3);
const Color violet = Color(0xFF6C63FF);
const Color cyan = Color(0xFF22D3EE);
const Color pink = Color(0xFFEC4899);
const Color green = Color(0xFF4ADE80);
const Color amber = Color(0xFFFBBF24);

Color alpha(Color c, double o) => c.withAlpha((o * 255).round());

BoxDecoration panel() => BoxDecoration(
      color: cardColor,
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: borderColor),
    );

void main() => runApp(const WebApp());

class WebApp extends StatelessWidget {
  const WebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: violet,
        scaffoldBackgroundColor: bg,
      ),
      home: const HomePage(),
    );
  }
}

class Feature {
  final IconData icon;
  final String title;
  final String text;
  final Color color;
  const Feature(this.icon, this.title, this.text, this.color);
}

const List<Feature> features = [
  Feature(Icons.devices_rounded, 'Responsive',
      'The layout adapts to phones, tablets and desktops.', cyan),
  Feature(Icons.code_rounded, 'One codebase',
      'The same Dart code runs on mobile, web and desktop.', violet),
  Feature(Icons.bolt_rounded, 'Hot reload',
      'See changes in Chrome in about a second while coding.', amber),
  Feature(Icons.rocket_launch_rounded, 'Production build',
      'flutter build web creates optimised files in build/web.', green),
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void showWelcome(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.waving_hand_rounded, color: amber, size: 36),
        title: const Text('Welcome!'),
        content: const Text(
            'This Flutter web app changes its layout when you resize the browser window.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ---- Step 4: Scaffold + AppBar ----
      appBar: AppBar(
        title: const Text('Flutter Web Application'),
        backgroundColor: cardColor,
      ),
      // ---- Step 5: LayoutBuilder (responsive) ----
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double width = constraints.maxWidth;
          final bool mobile = width < 600; // breakpoint
          final String layoutName =
              mobile ? 'Mobile Web Layout' : 'Desktop Web Layout';

          return SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Padding(
                  padding: EdgeInsets.all(mobile ? 16 : 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      layoutBadge(layoutName, width, mobile),
                      const SizedBox(height: 18),
                      hero(context, mobile),
                      const SizedBox(height: 22),
                      statsRow(width, layoutName, mobile),
                      const SizedBox(height: 22),
                      const Text('Why Flutter for the web?',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 14),
                      featureGrid(width, mobile),
                      const SizedBox(height: 24),
                      Center(
                        child: Text(
                          'Resize the browser window to see the layout change at 600 px.',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: muted),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Shows which layout is active
  Widget layoutBadge(String name, double width, bool mobile) {
    final Color color = mobile ? pink : green;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: alpha(color, 0.15),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: alpha(color, 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(mobile ? Icons.smartphone_rounded : Icons.desktop_windows_rounded,
              color: color, size: 20),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              '$name  •  ${width.round()} px wide',
              style: TextStyle(color: color, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget hero(BuildContext context, bool mobile) {
    final Widget texts = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Build once.\nRun on the web.',
          style: TextStyle(
            fontSize: mobile ? 30 : 44,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'A responsive Flutter application built for the browser.',
          style: TextStyle(
              fontSize: mobile ? 15 : 17, color: alpha(Colors.white, 0.9)),
        ),
        const SizedBox(height: 22),
        // ---- Step 4: ElevatedButton "Welcome" ----
        ElevatedButton.icon(
          onPressed: () => showWelcome(context),
          icon: const Icon(Icons.arrow_forward_rounded),
          label: const Text('Welcome'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF3B2FBF),
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );

    final Widget art = Container(
      width: mobile ? double.infinity : 260,
      height: mobile ? 120 : 200,
      decoration: BoxDecoration(
        color: alpha(Colors.white, 0.18),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Icon(Icons.public_rounded,
          size: mobile ? 64 : 96, color: Colors.white),
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(mobile ? 22 : 36),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [violet, Color(0xFF8E54E9), cyan],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: mobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [texts, const SizedBox(height: 22), art],
            )
          : Row(
              children: [
                Expanded(child: texts),
                const SizedBox(width: 24),
                art,
              ],
            ),
    );
  }

  Widget statsRow(double width, String layoutName, bool mobile) {
    final int columns = columnsFor(width);
    final List<Widget> cards = [
      statCard(Icons.straighten_rounded, '${width.round()} px', 'Window width',
          cyan),
      statCard(Icons.dashboard_customize_rounded,
          mobile ? 'Mobile' : 'Desktop', 'Active layout', pink),
      statCard(Icons.view_column_rounded, '$columns', 'Feature columns', green),
    ];

    if (mobile) {
      return Column(
        children: [
          for (final c in cards) ...[c, const SizedBox(height: 12)],
        ],
      );
    }
    return Row(
      children: [
        for (int i = 0; i < cards.length; i++) ...[
          Expanded(child: cards[i]),
          if (i < cards.length - 1) const SizedBox(width: 16),
        ],
      ],
    );
  }

  Widget statCard(IconData icon, String value, String label, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: panel(),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: alpha(color, 0.18),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w800)),
                Text(label,
                    style: const TextStyle(color: muted, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int columnsFor(double width) {
    if (width < 600) return 1;
    if (width < 1000) return 2;
    return 4;
  }

  Widget featureGrid(double width, bool mobile) {
    final int columns = columnsFor(width);
    const double spacing = 16;
    final double padding = mobile ? 16 : 28;
    final double available =
        (width > 1200 ? 1200 : width) - padding * 2;
    final double itemWidth = (available - spacing * (columns - 1)) / columns;

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: [
        for (final f in features)
          SizedBox(
            width: itemWidth,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: panel(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: alpha(f.color, 0.18),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(f.icon, color: f.color, size: 26),
                  ),
                  const SizedBox(height: 14),
                  Text(f.title,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(f.text, style: const TextStyle(color: muted)),
                ],
              ),
            ),
          ),
      ],
    );
  }
}