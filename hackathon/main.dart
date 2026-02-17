import 'package:flutter/material.dart';

// --------------------------------------
// Main App Entry Point
// --------------------------------------
void main() {
  runApp(const PersonalityAssessmentApp());
}

class PersonalityAssessmentApp extends StatelessWidget {
  const PersonalityAssessmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Autonomous Assessment',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardColor: const Color(0xFF1E1E1E),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple.shade400,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
        ),
      ),
      home: const AssessmentScreen(),
    );
  }
}


// --------------------------------------
// Question Data Structure
// --------------------------------------

/// Represents a single question in the assessment.
class Question {
  final String id;
  final String text;
  final String trait;
  final bool reverse;

  Question(this.id, this.text, this.trait, {this.reverse = false});
}

// --------------------------------------
// Question Banks (Copied from the original script)
// --------------------------------------

// Holland Codes (RIASEC)
final List<Question> riasecQuestions = [
  // Realistic
  Question("R1", "Build or repair a physical object?", "R"),
  Question("R2", "Use tools or equipment to assemble things?", "R"),
  Question("R3", "Work outdoors in varying conditions?", "R"),
  Question("R4", "Inspect a machine to find what's wrong?", "R"),
  Question("R5", "Operate or maintain technical hardware?", "R"),
  Question("R6", "Install or configure devices following a manual?", "R"),
  // Investigative
  Question("I1", "Analyze data to find patterns?", "I"),
  Question("I2", "Design an experiment to test a hypothesis?", "I"),
  Question("I3", "Read scientific articles to solve a problem?", "I"),
  Question("I4", "Work alone on a complex problem for hours?", "I"),
  Question("I5", "Compare two explanations and test which fits evidence?", "I"),
  Question("I6", "Evaluate if results are statistically meaningful?", "I"),
  // Artistic
  Question("A1", "Create original designs, visuals, or music?", "A"),
  Question("A2", "Write stories, scripts, or creative content?", "A"),
  Question("A3", "Express ideas through drawing or multimedia?", "A"),
  Question("A4", "Try unconventional approaches to solve problems?", "A"),
  Question("A5", "Curate aesthetics: layout, typography, color?", "A"),
  Question("A6", "Combine unrelated ideas into something new?", "A"),
  // Social
  Question("S1", "Mentor a peer on a skill they're learning?", "S"),
  Question("S2", "Facilitate group discussions so all voices are heard?", "S"),
  Question("S3", "Volunteer for a community or school support task?", "S"),
  Question("S4", "Teach a concept using examples the person relates to?", "S"),
  Question("S5", "Resolve misunderstandings between classmates?", "S"),
  Question("S6", "Provide encouragement and practical help to others?", "S"),
  // Enterprising
  Question("E1", "Pitch an idea to convince others to support it?", "E"),
  Question("E2", "Lead a team to meet a deadline?", "E"),
  Question("E3", "Network with new people to explore opportunities?", "E"),
  Question("E4", "Negotiate roles to match people’s strengths?", "E"),
  Question("E5", "Organize an event with sponsors and promotion?", "E"),
  Question("E6", "Take calculated risks to achieve an ambitious goal?", "E"),
  // Conventional
  Question("C1", "Keep records well-organized and up to date?", "C"),
  Question("C2", "Follow detailed procedures accurately?", "C"),
  Question("C3", "Create a neat system for tracking tasks?", "C"),
  Question("C4", "Check for errors and correct inconsistencies?", "C"),
  Question("C5", "Use spreadsheets to manage data and lists?", "C"),
  Question("C6", "Prefer clear instructions and defined roles?", "C"),
];

// Big Five Personality Traits
final List<Question> bigFiveQuestions = [
  // Openness
  Question("O1", "I enjoy exploring new ideas and perspectives.", "O"),
  Question("O2", "I like creative tasks without one correct answer.", "O"),
  Question("O3", "I seek out art, design, or cultural experiences.", "O"),
  Question("O4", "I adapt quickly when plans change.", "O"),
  Question("O5", "I avoid unfamiliar experiences.", "O", reverse: true),
  Question("O6", "I dislike abstract or theoretical topics.", "O", reverse: true),
  Question("O7", "I prefer step-by-step routines over variety.", "O", reverse: true),
  Question("O8", "I feel uneasy trying novel approaches.", "O", reverse: true),
  // Conscientiousness
  Question("Ctn1", "I plan my work and stick to schedules.", "Ct"),
  Question("Ctn2", "I double-check my work for accuracy.", "Ct"),
  Question("Ctn3", "I finish tasks even when tedious.", "Ct"),
  Question("Ctn4", "I set goals and track progress carefully.", "Ct"),
  Question("Ctn5", "I often procrastinate until the last minute.", "Ct", reverse: true),
  Question("Ctn6", "I forget to follow through on commitments.", "Ct", reverse: true),
  Question("Ctn7", "I get distracted easily when working.", "Ct", reverse: true),
  Question("Ctn8", "I start tasks but rarely finish them.", "Ct", reverse: true),
  // Extraversion
  Question("Ex1", "I feel energized in group activities.", "Ex"),
  Question("Ex2", "I enjoy initiating conversations with new people.", "Ex"),
  Question("Ex3", "I prefer collaborative work to solitary tasks.", "Ex"),
  Question("Ex4", "I like to take the lead in group settings.", "Ex"),
  Question("Ex5", "I avoid social events if I can.", "Ex", reverse: true),
  Question("Ex6", "I feel drained after social interactions.", "Ex", reverse: true),
  Question("Ex7", "I prefer to observe rather than participate.", "Ex", reverse: true),
  Question("Ex8", "I dislike speaking up in groups.", "Ex", reverse: true),
  // Agreeableness
  Question("Ag1", "I try to understand others’ viewpoints.", "Ag"),
  Question("Ag2", "I willingly help without expecting rewards.", "Ag"),
  Question("Ag3", "I value cooperation over competition.", "Ag"),
  Question("Ag4", "I am patient with people learning something new.", "Ag"),
  Question("Ag5", "I can be blunt even if it hurts feelings.", "Ag", reverse: true),
  Question("Ag6", "I often prioritize my goals over group needs.", "Ag", reverse: true),
  Question("Ag7", "I get irritated by others’ mistakes.", "Ag", reverse: true),
  Question("Ag8", "I find it hard to compromise.", "Ag", reverse: true),
  // Neuroticism
  Question("N1", "I feel anxious when facing uncertainty.", "N"),
  Question("N2", "I worry about making mistakes.", "N"),
  Question("N3", "I get stressed by time pressure.", "N"),
  Question("N4", "I ruminate about past errors.", "N"),
  Question("N5", "I stay calm in high-pressure situations.", "N", reverse: true),
  Question("N6", "I recover quickly after setbacks.", "N", reverse: true),
  Question("N7", "I remain steady when plans fall apart.", "N", reverse: true),
  Question("N8", "I handle criticism without feeling upset.", "N", reverse: true),
];

// Multiple Intelligences (MI)
final List<Question> miQuestions = [
  Question("MI-L1", "I enjoy explaining ideas in clear words.", "Linguistic"),
  Question("MI-L2", "I like reading/writing more than working with objects.", "Linguistic"),
  Question("MI-Log1", "I break complex problems into steps.", "Logical"),
  Question("MI-Log2", "I enjoy logic puzzles or coded patterns.", "Logical"),
  Question("MI-S1", "I think in pictures or mental maps.", "Spatial"),
  Question("MI-S2", "I can visualize how parts fit in 3D.", "Spatial"),
  Question("MI-M1", "I notice rhythms or patterns in sounds.", "Musical"),
  Question("MI-M2", "I remember information better with melodies.", "Musical"),
  Question("MI-B1", "I learn best by doing, not by reading.", "Bodily"),
  Question("MI-B2", "I prefer active, hands-on projects.", "Bodily"),
  Question("MI-Inter1", "I sense group dynamics and adjust my approach.", "Interpersonal"),
  Question("MI-Inter2", "I can read others’ emotions accurately.", "Interpersonal"),
  Question("MI-Intra1", "I reflect on my strengths and limits.", "Intrapersonal"),
  Question("MI-Intra2", "I set personal goals and self-monitor.", "Intrapersonal"),
  Question("MI-Nat1", "I enjoy learning about nature/ecosystems.", "Naturalistic"),
  Question("MI-Nat2", "I prefer outdoor, real-world observations.", "Naturalistic"),
];

// --------------------------------------
// Profile & Scenario Definitions
// --------------------------------------

/// A class to hold the definition of a profile, its conditions, and suggested scenarios.
class Profile {
  final String name;
  final bool Function(Map<String, double>) conditions;
  final List<String> scenarios;

  Profile({required this.name, required this.conditions, required this.scenarios});
}

/// A centralized list of all possible profiles and the rules to match them.
final List<Profile> profileRules = [
  Profile(
    name: "Creative",
    conditions: (scores) => (scores["O"] ?? 0) >= 4.0 && (scores["A"] ?? 0) >= 4.0,
    scenarios: ["Draft two divergent concepts", "Collect reference campaigns"],
  ),
  Profile(
    name: "Interpersonal",
    conditions: (scores) => (scores["S"] ?? 0) >= 4.0 && (scores["Ag"] ?? 0) >= 4.0,
    scenarios: ["Facilitate mediation", "Assign focused task"],
  ),
  Profile(
    name: "Practical",
    conditions: (scores) => (scores["R"] ?? 0) >= 4.0 && (scores["Ct"] ?? 0) >= 4.0,
    scenarios: ["Stabilize core services first", "Build quick runbook from logs"],
  ),
  Profile(
    name: "Independent",
    conditions: (scores) => (scores["I"] ?? 0) >= 4.0 && (scores["O"] ?? 0) >= 3.5 && (scores["S"] ?? 0) <= 3.0,
    scenarios: ["Replicate study with improved method", "Report anomalies transparently"],
  ),
  Profile(
    name: "Business",
    conditions: (scores) => (scores["E"] ?? 0) >= 4.0 && (scores["Ex"] ?? 0) >= 3.8 && (scores["Ct"] ?? 0) >= 3.8,
    scenarios: ["Referral incentives", "Social proof campaign"],
  ),
  Profile(
    name: "Organization",
    conditions: (scores) => (scores["C"] ?? 0) >= 4.0 && (scores["Ct"] ?? 0) >= 4.0,
    scenarios: ["Add validation at ingestion", "Monitor dashboard with alerts"],
  ),
  Profile(
    name: "LowSignal", // Fallback profile
    conditions: (scores) => true, // This will always match if no others do.
    scenarios: ["Choose a prototype to test", "Analyze data for clearer patterns"],
  ),
];

// --------------------------------------
// Assessment Screen UI & Logic
// --------------------------------------

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key});

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  final PageController _pageController = PageController();
  late final List<Question> _allQuestions;
  final Map<String, int> _responses = {};
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _allQuestions = [...riasecQuestions, ...bigFiveQuestions, ...miQuestions];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleAnswer(String questionId, int value) {
    setState(() {
      _responses[questionId] = value;
      _progress = _responses.length / _allQuestions.length;
    });

    if (_responses.length == _allQuestions.length) {
      _calculateAndShowResults();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _calculateAndShowResults() {
    final uniqueTraits = _allQuestions.map((q) => q.trait).toSet();
    final scores = {for (var trait in uniqueTraits) trait: 0.0};
    final counts = {for (var trait in uniqueTraits) trait: 0};

    for (final q in _allQuestions) {
      var value = _responses[q.id]!;
      if (q.reverse) {
        value = 6 - value;
      }
      scores[q.trait] = scores[q.trait]! + value;
      counts[q.trait] = counts[q.trait]! + 1;
    }

    for (final trait in scores.keys) {
      if (counts[trait]! > 0) {
        scores[trait] = scores[trait]! / counts[trait]!;
      }
    }

    final matchedProfiles = profileRules.where((profile) => profile.conditions(scores)).toList();
    final primaryProfiles = (matchedProfiles.length > 1) 
        ? matchedProfiles.where((p) => p.name != "LowSignal").toList() 
        : matchedProfiles;

    // The results will be stored and available on the results screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => ResultsScreen(
          scores: scores,
          primaryProfiles: primaryProfiles,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Autonomous Assessment'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: LinearProgressIndicator(
            value: _progress,
            backgroundColor: Colors.grey.shade700,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple.shade300),
          ),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _allQuestions.length,
        itemBuilder: (context, index) {
          final question = _allQuestions[index];
          return QuestionCard(
            question: question,
            questionNumber: index + 1,
            totalQuestions: _allQuestions.length,
            onAnswerSelected: (value) => _handleAnswer(question.id, value),
          );
        },
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  final Question question;
  final int questionNumber;
  final int totalQuestions;
  final ValueChanged<int> onAnswerSelected;

  const QuestionCard({
    super.key,
    required this.question,
    required this.questionNumber,
    required this.totalQuestions,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Question $questionNumber of $totalQuestions',
              style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              question.text,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Text(
              "Rate on a scale of 1–5 (1 = Not at all like me, 5 = Very much like me)",
              style: TextStyle(color: Colors.grey.shade400, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: List.generate(5, (index) {
                final value = index + 1;
                return ElevatedButton(
                  onPressed: () => onAnswerSelected(value),
                  child: Text('$value'),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}


// --------------------------------------
// Results Screen UI
// --------------------------------------
class ResultsScreen extends StatelessWidget {
  final Map<String, double> scores;
  final List<Profile> primaryProfiles;

  const ResultsScreen({
    super.key,
    required this.scores,
    required this.primaryProfiles,
  });

  @override
  Widget build(BuildContext context) {
    final sortedScores = scores.entries.toList()..sort((a, b) => a.key.compareTo(b.key));
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assessment Complete'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildResultsSection(
            context,
            title: 'Primary Profile(s)',
            child: primaryProfiles.isEmpty
                ? const Text('No specific profile matched.')
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: primaryProfiles.map((profile) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profile.name,
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: Colors.deepPurple.shade200,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text('Suggested Actions:', style: TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              ...profile.scenarios.map((s) => Text('• $s')),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
          ),
          const SizedBox(height: 20),
           _buildResultsSection(
            context,
            title: 'Detailed Scores',
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: sortedScores.map((entry) {
                    return ListTile(
                      title: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.bold)),
                      trailing: Text(
                        entry.value.toStringAsFixed(2),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.deepPurple.shade200,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            label: const Text('Retake Assessment'),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const AssessmentScreen()),
              );
            },
          ),
          const SizedBox(height: 20),
          // Here you can add a button or functionality to print/share the results
          // For now, the results are simply displayed on the screen.
          Center(
            child: Text(
              'Final answers and scores are stored in this session.',
               style: TextStyle(color: Colors.grey.shade500, fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsSection(BuildContext context, {required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}





/*// --------------------------------------
// Full Autonomous Assessment (Dart Version)
// --------------------------------------

import 'dart:io';

// --------------------------------------
// Question Data Structure
// --------------------------------------

class Question {
  final String id;
  final String text;
  final String trait;
  final bool reverse;

  Question(this.id, this.text, this.trait, {this.reverse = false});
}

// --------------------------------------
// Question Banks
// --------------------------------------

// Holland Codes (RIASEC)
final List<Question> riasecQuestions = [
  // Realistic
  Question("R1", "Build or repair a physical object?", "R"),
  Question("R2", "Use tools or equipment to assemble things?", "R"),
  Question("R3", "Work outdoors in varying conditions?", "R"),
  Question("R4", "Inspect a machine to find what's wrong?", "R"),
  Question("R5", "Operate or maintain technical hardware?", "R"),
  Question("R6", "Install or configure devices following a manual?", "R"),
  // Investigative
  Question("I1", "Analyze data to find patterns?", "I"),
  Question("I2", "Design an experiment to test a hypothesis?", "I"),
  Question("I3", "Read scientific articles to solve a problem?", "I"),
  Question("I4", "Work alone on a complex problem for hours?", "I"),
  Question("I5", "Compare two explanations and test which fits evidence?", "I"),
  Question("I6", "Evaluate if results are statistically meaningful?", "I"),
  // Artistic
  Question("A1", "Create original designs, visuals, or music?", "A"),
  Question("A2", "Write stories, scripts, or creative content?", "A"),
  Question("A3", "Express ideas through drawing or multimedia?", "A"),
  Question("A4", "Try unconventional approaches to solve problems?", "A"),
  Question("A5", "Curate aesthetics: layout, typography, color?", "A"),
  Question("A6", "Combine unrelated ideas into something new?", "A"),
  // Social
  Question("S1", "Mentor a peer on a skill they're learning?", "S"),
  Question("S2", "Facilitate group discussions so all voices are heard?", "S"),
  Question("S3", "Volunteer for a community or school support task?", "S"),
  Question("S4", "Teach a concept using examples the person relates to?", "S"),
  Question("S5", "Resolve misunderstandings between classmates?", "S"),
  Question("S6", "Provide encouragement and practical help to others?", "S"),
  // Enterprising
  Question("E1", "Pitch an idea to convince others to support it?", "E"),
  Question("E2", "Lead a team to meet a deadline?", "E"),
  Question("E3", "Network with new people to explore opportunities?", "E"),
  Question("E4", "Negotiate roles to match people’s strengths?", "E"),
  Question("E5", "Organize an event with sponsors and promotion?", "E"),
  Question("E6", "Take calculated risks to achieve an ambitious goal?", "E"),
  // Conventional
  Question("C1", "Keep records well-organized and up to date?", "C"),
  Question("C2", "Follow detailed procedures accurately?", "C"),
  Question("C3", "Create a neat system for tracking tasks?", "C"),
  Question("C4", "Check for errors and correct inconsistencies?", "C"),
  Question("C5", "Use spreadsheets to manage data and lists?", "C"),
  Question("C6", "Prefer clear instructions and defined roles?", "C"),
];

// Big Five Personality Traits
final List<Question> bigFiveQuestions = [
  // Openness
  Question("O1", "I enjoy exploring new ideas and perspectives.", "O"),
  Question("O2", "I like creative tasks without one correct answer.", "O"),
  Question("O3", "I seek out art, design, or cultural experiences.", "O"),
  Question("O4", "I adapt quickly when plans change.", "O"),
  Question("O5", "I avoid unfamiliar experiences.", "O", reverse: true),
  Question("O6", "I dislike abstract or theoretical topics.", "O", reverse: true),
  Question("O7", "I prefer step-by-step routines over variety.", "O", reverse: true),
  Question("O8", "I feel uneasy trying novel approaches.", "O", reverse: true),
  // Conscientiousness
  Question("Ctn1", "I plan my work and stick to schedules.", "Ct"),
  Question("Ctn2", "I double-check my work for accuracy.", "Ct"),
  Question("Ctn3", "I finish tasks even when tedious.", "Ct"),
  Question("Ctn4", "I set goals and track progress carefully.", "Ct"),
  Question("Ctn5", "I often procrastinate until the last minute.", "Ct", reverse: true),
  Question("Ctn6", "I forget to follow through on commitments.", "Ct", reverse: true),
  Question("Ctn7", "I get distracted easily when working.", "Ct", reverse: true),
  Question("Ctn8", "I start tasks but rarely finish them.", "Ct", reverse: true),
  // Extraversion
  Question("Ex1", "I feel energized in group activities.", "Ex"),
  Question("Ex2", "I enjoy initiating conversations with new people.", "Ex"),
  Question("Ex3", "I prefer collaborative work to solitary tasks.", "Ex"),
  Question("Ex4", "I like to take the lead in group settings.", "Ex"),
  Question("Ex5", "I avoid social events if I can.", "Ex", reverse: true),
  Question("Ex6", "I feel drained after social interactions.", "Ex", reverse: true),
  Question("Ex7", "I prefer to observe rather than participate.", "Ex", reverse: true),
  Question("Ex8", "I dislike speaking up in groups.", "Ex", reverse: true),
  // Agreeableness
  Question("Ag1", "I try to understand others’ viewpoints.", "Ag"),
  Question("Ag2", "I willingly help without expecting rewards.", "Ag"),
  Question("Ag3", "I value cooperation over competition.", "Ag"),
  Question("Ag4", "I am patient with people learning something new.", "Ag"),
  Question("Ag5", "I can be blunt even if it hurts feelings.", "Ag", reverse: true),
  Question("Ag6", "I often prioritize my goals over group needs.", "Ag", reverse: true),
  Question("Ag7", "I get irritated by others’ mistakes.", "Ag", reverse: true),
  Question("Ag8", "I find it hard to compromise.", "Ag", reverse: true),
  // Neuroticism
  Question("N1", "I feel anxious when facing uncertainty.", "N"),
  Question("N2", "I worry about making mistakes.", "N"),
  Question("N3", "I get stressed by time pressure.", "N"),
  Question("N4", "I ruminate about past errors.", "N"),
  Question("N5", "I stay calm in high-pressure situations.", "N", reverse: true),
  Question("N6", "I recover quickly after setbacks.", "N", reverse: true),
  Question("N7", "I remain steady when plans fall apart.", "N", reverse: true),
  Question("N8", "I handle criticism without feeling upset.", "N", reverse: true),
];

// Multiple Intelligences (MI)
final List<Question> miQuestions = [
  Question("MI-L1", "I enjoy explaining ideas in clear words.", "Linguistic"),
  Question("MI-L2", "I like reading/writing more than working with objects.", "Linguistic"),
  Question("MI-Log1", "I break complex problems into steps.", "Logical"),
  Question("MI-Log2", "I enjoy logic puzzles or coded patterns.", "Logical"),
  Question("MI-S1", "I think in pictures or mental maps.", "Spatial"),
  Question("MI-S2", "I can visualize how parts fit in 3D.", "Spatial"),
  Question("MI-M1", "I notice rhythms or patterns in sounds.", "Musical"),
  Question("MI-M2", "I remember information better with melodies.", "Musical"),
  Question("MI-B1", "I learn best by doing, not by reading.", "Bodily"),
  Question("MI-B2", "I prefer active, hands-on projects.", "Bodily"),
  Question("MI-Inter1", "I sense group dynamics and adjust my approach.", "Interpersonal"),
  Question("MI-Inter2", "I can read others’ emotions accurately.", "Interpersonal"),
  Question("MI-Intra1", "I reflect on my strengths and limits.", "Intrapersonal"),
  Question("MI-Intra2", "I set personal goals and self-monitor.", "Intrapersonal"),
  Question("MI-Nat1", "I enjoy learning about nature/ecosystems.", "Naturalistic"),
  Question("MI-Nat2", "I prefer outdoor, real-world observations.", "Naturalistic"),
];

// --------------------------------------
// Function to Ask a Question
// --------------------------------------

int askLikertQuestion(Question q) {
  print("\n${q.text}");
  print("Rate on a scale of 1–5 (1 = Not at all like me, 5 = Very much like me)");
  while (true) {
    stdout.write("Your answer (1-5): ");
    final input = stdin.readLineSync();
    final value = int.tryParse(input ?? '');
    if (value != null && value >= 1 && value <= 5) {
      return value;
    }
    print("Invalid input. Please enter a number between 1 and 5.");
  }
}

// --------------------------------------
// Main Application Logic
// --------------------------------------
void main() {
  // Combine all questions into a single list
  final allQuestions = [...riasecQuestions, ...bigFiveQuestions, ...miQuestions];
  final responses = <String, int>{};

  print("--- Welcome to the Autonomous Assessment ---");
  print("Please answer the following questions honestly to get the best results.");

  // Ask all questions
  for (final q in allQuestions) {
    responses[q.id] = askLikertQuestion(q);
  }

  // --- Score Calculation ---

  // Dynamically create maps for scores and counts to avoid errors
  final uniqueTraits = allQuestions.map((q) => q.trait).toSet();
  final scores = {for (var trait in uniqueTraits) trait: 0.0};
  final counts = {for (var trait in uniqueTraits) trait: 0};

  // Process all responses in a single, unified loop
  for (final q in allQuestions) {
    var value = responses[q.id]!;
    
    // Apply reverse scoring universally if the question is marked as reversed
    if (q.reverse) {
      value = 6 - value;
    }
    
    scores[q.trait] = scores[q.trait]! + value;
    counts[q.trait] = counts[q.trait]! + 1;
  }

  // Calculate the average score for each trait
  for (final trait in scores.keys) {
    if (counts[trait]! > 0) {
      scores[trait] = scores[trait]! / counts[trait]!;
    }
  }

  // --- Branching Logic ---
  final branches = <String>[];
  
  // Note: These thresholds are based on your original logic.
  // They can be adjusted for different results.
  if ((scores["O"] ?? 0) >= 4.0 && (scores["A"] ?? 0) >= 4.0) {
    branches.add("Creative");
  }
  if ((scores["S"] ?? 0) >= 4.0 && (scores["Ag"] ?? 0) >= 4.0) {
    branches.add("Interpersonal");
  }
  if ((scores["R"] ?? 0) >= 4.0 && (scores["Ct"] ?? 0) >= 4.0) {
    branches.add("Practical");
  }
  if ((scores["I"] ?? 0) >= 4.0 && (scores["O"] ?? 0) >= 3.5 && (scores["S"] ?? 0) <= 3.0) {
    branches.add("Independent");
  }
  if ((scores["E"] ?? 0) >= 4.0 && (scores["Ex"] ?? 0) >= 3.8 && (scores["Ct"] ?? 0) >= 3.8) {
    branches.add("Business");
  }
  if ((scores["C"] ?? 0) >= 4.0 && (scores["Ct"] ?? 0) >= 4.0) {
    branches.add("Organization");
  }
  
  // A fallback for profiles that don't meet any strong criteria
  if (branches.isEmpty) {
    branches.add("LowSignal");
  }

  final scenarioMapping = {
    "Creative": ["Draft two divergent concepts", "Collect reference campaigns"],
    "Interpersonal": ["Facilitate mediation", "Assign focused task"],
    "Practical": ["Stabilize core services first", "Build quick runbook from logs"],
    "Independent": ["Replicate study with improved method", "Report anomalies transparently"],
    "Business": ["Referral incentives", "Social proof campaign"],
    "Organization": ["Add validation at ingestion", "Monitor dashboard with alerts"],
    "LowSignal": ["Choose a prototype to test", "Analyze data for clearer patterns"],
  };

  final mainBranch = branches.first;

  print("\n--- Assessment Complete ---");
  print("\nPrimary Profile: $mainBranch");
  print("Based on your profile, here are some suggested actions for a hypothetical scenario:");
  for (final scenario in scenarioMapping[mainBranch]!) {
    print("- $scenario");
  }

  print("\n--- DETAILED SCORES ---");
  scores.forEach((key, value) {
    print("$key: ${value.toStringAsFixed(2)}");
  });

  print("\nThese scores can now be sent to an AI for deeper analysis.");
}*/