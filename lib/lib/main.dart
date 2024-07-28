import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flash Learn',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/register': (context) => RegistrationScreen(),
        '/login': (context) => LoginScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/forgotPassword': (context) => ForgotPasswordScreen(),
        '/mathQuestions': (context) => QuestionScreen(subject: 'Mathematics'),
        '/physicsQuestions': (context) => QuestionScreen(subject: 'Physics'),
        '/chemistryQuestions': (context) =>
            QuestionScreen(subject: 'Chemistry'),
      },
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/register');
          },
          child: Text('Register'),
        ),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    final String username = arguments['username'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Flash Learn'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(username)),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Class',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ClassScreen(className: 'Class 10')));
              },
              child: Text('Class 10'),
            ),
            // Add buttons for other classes here
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ClassScreen(className: 'Class 12')));
              },
              child: Text('Class 12'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ClassScreen(className: 'Class 11')));
              },
              child: Text('Class 11'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ClassScreen(className: 'Class 9')));
              },
              child: Text('Class 9'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ClassScreen(className: 'Class 8')));
              },
              child: Text('Class 8'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ClassScreen(className: 'Class 7')));
              },
              child: Text('Class 7'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ClassScreen(className: 'Class 6')));
              },
              child: Text('Class 6'),
            ),
          ],
        ),
      ),
    );
  }
}

class ClassScreen extends StatelessWidget {
  final String className;

  ClassScreen({required this.className});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$className Subjects'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$className Subjects',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/mathQuestions');
              },
              child: Text('Mathematics'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/physicsQuestions');
              },
              child: Text('Physics'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/chemistryQuestions');
              },
              child: Text('Chemistry'),
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionScreen extends StatefulWidget {
  final String subject;

  QuestionScreen({required this.subject});

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int _selectedOption = -1;
  bool _answered = false;
  bool _isCorrect = false;
  final Random _random = Random();

  final Map<String, List<Map<String, dynamic>>> _questions = {
    'Mathematics': [
      {
        'question': 'What is 2 + 2?',
        'options': ['3', '4', '5'],
        'correctOption': 1,
      },
      {
        'question': 'What is 3 * 3?',
        'options': ['6', '9', '12'],
        'correctOption': 1,
      },
    ],
    'Physics': [
      {
        'question': 'What is the speed of light?',
        'options': ['3 x 10^8 m/s', '3 x 10^7 m/s', '3 x 10^6 m/s'],
        'correctOption': 0,
      },
      {
        'question': 'What is the unit of force?',
        'options': ['Newton', 'Joule', 'Watt'],
        'correctOption': 0,
      },
    ],
    'Chemistry': [
      {
        'question': 'What is the chemical formula for water?',
        'options': ['H2O', 'CO2', 'NaCl'],
        'correctOption': 0,
      },
      {
        'question': 'What is the chemical formula for table salt?',
        'options': ['NaCl', 'H2O', 'CO2'],
        'correctOption': 0,
      },
    ],
  };

  Map<String, dynamic> _currentQuestion = {};

  @override
  void initState() {
    super.initState();
    _loadNewQuestion();
  }

  void _loadNewQuestion() {
    final questions = _questions[widget.subject]!;
    _currentQuestion = questions[_random.nextInt(questions.length)];
    _selectedOption = -1;
    _answered = false;
  }

  void _checkAnswer() {
    setState(() {
      _answered = true;
      _isCorrect = _selectedOption == _currentQuestion['correctOption'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.subject} Questions'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _loadNewQuestion();
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _currentQuestion['question'],
              style: TextStyle(fontSize: 18),
            ),
            ...List.generate(
              _currentQuestion['options'].length,
              (index) => ListTile(
                title: Text(_currentQuestion['options'][index]),
                leading: Radio(
                  value: index,
                  groupValue: _selectedOption,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedOption = value!;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _checkAnswer,
                child: Text('Submit Answer'),
              ),
            ),
            if (_answered)
              Center(
                child: Text(
                  _isCorrect ? 'Answer is correct!' : 'Answer is wrong!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _isCorrect ? Colors.green : Colors.red,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _savedUsername = '';
  String _savedPassword = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map? arguments = ModalRoute.of(context)?.settings.arguments as Map?;
    if (arguments != null) {
      _savedUsername = arguments['username'];
      _savedPassword = arguments['password'];
    }
  }

  void _login() {
    if (_usernameController.text == _savedUsername &&
        _passwordController.text == _savedPassword) {
      Navigator.pushReplacementNamed(context, '/dashboard',
          arguments: {'username': _usernameController.text});
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Invalid username or password'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _forgotPassword() {
    Navigator.pushNamed(context, '/forgotPassword', arguments: {
      'username': _savedUsername,
      'password': _savedPassword,
      'updatePassword': (String newPassword) {
        setState(() {
          _savedPassword = newPassword;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: _login,
                  child: Text('Login'),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.help_outline),
                  onPressed: _forgotPassword,
                ),
                TextButton(
                  onPressed: _forgotPassword,
                  child: Text('Forgot Password'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  void _register() {
    final username = _usernameController.text;
    final password = _passwordController.text;

    Navigator.pushReplacementNamed(context, '/login', arguments: {
      'username': username,
      'password': password,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _contactController,
              decoration: InputDecoration(labelText: 'Contact Number'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: _register,
                  child: Text('Register'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  // ignore: unused_field
  late String _username;
  // ignore: unused_field
  late String _password;
  late void Function(String) _updatePassword;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    _username = arguments['username'];
    _password = arguments['password'];
    _updatePassword = arguments['updatePassword'];
  }

  void _resetPassword() {
    if (_newPasswordController.text == _confirmPasswordController.text) {
      _updatePassword(_newPasswordController.text);
      Navigator.pop(context);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Passwords do not match'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(labelText: 'New Password'),
              obscureText: true,
            ),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: _resetPassword,
                  child: Text('Reset Password'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
