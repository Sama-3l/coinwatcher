import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PasswordTextField extends StatefulWidget {
  final void Function(bool isValid) onPasswordValidityChanged;

  PasswordTextField({required this.onPasswordValidityChanged});

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField>
    with TickerProviderStateMixin {
  final _passwordController = TextEditingController();
  final _focusNode = FocusNode();
  late AnimationController _animationController;
  late Animation<double> _animation;

  bool _isPasswordVisible = false;
  bool _isPasswordValid = false;
  bool _hasUpperCase = false;
  bool _hasLowerCase = false;
  bool _hasNumeric = false;
  bool _hasSpecialChar = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _focusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      _showPasswordConditions();
      _animationController.forward();
    } else {
      _hidePasswordConditions();
      _animationController.reverse();
    }
  }

  void _checkPasswordValidity(String value) {
    setState(() {
      // Check if the password meets all the conditions
      _isPasswordValid = value.length >= 8 &&
          value.contains(RegExp(r'[A-Z]')) &&
          value.contains(RegExp(r'[a-z]')) &&
          value.contains(RegExp(r'[0-9]')) &&
          value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

      _hasUpperCase = value.contains(RegExp(r'[A-Z]'));
      _hasLowerCase = value.contains(RegExp(r'[a-z]'));
      _hasNumeric = value.contains(RegExp(r'[0-9]'));
      _hasSpecialChar = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

      widget.onPasswordValidityChanged?.call(_isPasswordValid);
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _showPasswordConditions() {
    if (!_isPasswordValid) {
      _checkPasswordValidity(_passwordController.text);
    }
  }

  void _hidePasswordConditions() {
    // Hide the password conditions
    setState(() {
      _isPasswordValid =
          true; // Set to true so that it won't show the error state immediately after losing focus
    });
  }

  void _showPasswordValidationToast() {
    String message = _isPasswordValid
        ? "Password is valid."
        : "Password must contain:\n\n" +
            "${_hasUpperCase ? '✓' : '-'} at least 1 uppercase letter\n" +
            "${_hasLowerCase ? '✓' : '-'} at least 1 lowercase letter\n" +
            "${_hasNumeric ? '✓' : '-'} at least 1 numeric digit\n" +
            "${_hasSpecialChar ? '✓' : '-'} at least 1 special character\n" +
            "${_passwordController.text.length >= 8 ? '✓' : '-'} be at least 8 characters long";

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: _isPasswordValid ? Colors.green : Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 0.776 * width,
          height: 0.06 * height,
          child: TextFormField(
            controller: _passwordController,
            focusNode: _focusNode,
            obscureText: !_isPasswordVisible,
            onChanged: _checkPasswordValidity,
            decoration: InputDecoration(
              hintText: "Enter your password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.0),
                borderSide: BorderSide(color: Colors.black),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: _togglePasswordVisibility,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Align(
            alignment: Alignment.center,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -45 * (1 - _animation.value)),
                  child: Opacity(
                    opacity: _animation.value,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Color(0xFF858585)),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Password must contain:",
                            style: TextStyle(color: Color(0xFF858585)),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "${_hasUpperCase ? '✓' : '-'} at least 1 uppercase letter\n"
                            "${_hasLowerCase ? '✓' : '-'} at least 1 lowercase letter\n"
                            "${_hasNumeric ? '✓' : '-'} at least 1 numeric digit\n"
                            "${_hasSpecialChar ? '✓' : '-'} at least 1 special character\n"
                            "${_passwordController.text.length >= 8 ? '✓' : '-'} be at least 8 characters long",
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  late String password = _passwordController.text;
}

class ConditionWidget extends _PasswordTextFieldState {
  ConditionWidget(password) {}
}
