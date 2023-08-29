import 'package:flutter/material.dart';
import 'package:password_manager/screens/home.dart';
import 'package:password_manager/utils/utils.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen(this.masterPasswordHash, {super.key});

  final String masterPasswordHash;

  @override
  State<SigninScreen> createState() {
    return _SigninScreen();
  }
}

class _SigninScreen extends State<SigninScreen> {
  final _masterPassController = TextEditingController();

  final LocalAuthentication auth = LocalAuthentication();

  bool? _canCheckBiometrics;
  bool? _isSupported;

  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then(
      (bool isSupported) {
        setState(() => _isSupported = isSupported);
        _checkBiometrics();
        print('isSupported $isSupported');
      },
    );
  }

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() => _canCheckBiometrics = canCheckBiometrics);
    print('canCheckBiometrics $canCheckBiometrics');

    if (canCheckBiometrics) {
      _getAvailableBiometrics();
    }
  }

  Future<void> _getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
    print('_availableBiometrics $_availableBiometrics');
    _authenticate();
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(
        () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');

    if (authenticated) {
      gotoHomeScreen();
    }
    print('authenticated $authenticated');
  }

  void gotoHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  void onSubmit() {
    print(_masterPassController.text);

    if (_masterPassController.text.isNotEmpty) {
      final passHash = createHash(_masterPassController.text);

      if (passHash == widget.masterPasswordHash) {
        gotoHomeScreen();
      }
    }
  }

  @override
  Widget build(context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(children: [
        TextField(
          controller: _masterPassController,
          obscureText: true,
          maxLength: 50,
          decoration: const InputDecoration(
            label: Text('Master Password'),
            counter: Offstage(),
          ),
        ),
        ElevatedButton(onPressed: onSubmit, child: const Text('Submit'))
      ]),
    );
  }
}
