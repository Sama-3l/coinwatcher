// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:coinwatcher/business_logic/blocs/passwordVisibility/password_visibility_bloc.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PasswordTextField extends StatefulWidget {
  final void Function(bool isValid) onPasswordValidityChanged;
  TextEditingController password;

  PasswordTextField(
      {required this.onPasswordValidityChanged, required this.password});

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField>
    with TickerProviderStateMixin {
  late final _passwordController = widget.password;
  final _focusNode = FocusNode();
  late AnimationController _animationController;
  late Animation<double> _animation;
  LightMode theme = LightMode();
  FontFamily font = FontFamily();

  bool show = false;
  bool _isPasswordVisible = false;
  bool _isPasswordValid = false;

  List<String> conditions = [
    "At least 1 uppercase letter",
    "At least 1 lowercase letter",
    "At least 1 numeric digit",
    "At least 1 special character",
    "Be at least 8 characters long",
  ];
  List<bool> conditionsMet = [
    false,
    false,
    false,
    false,
    false,
  ];

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
      show = true;
    } else {
      _hidePasswordConditions();
      _animationController.reverse();
      show = false;
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

      conditionsMet[0] = value.contains(RegExp(r'[A-Z]'));
      conditionsMet[1] = value.contains(RegExp(r'[a-z]'));
      conditionsMet[2] = value.contains(RegExp(r'[0-9]'));
      conditionsMet[3] = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      conditionsMet[4] = value.length >= 8;

      widget.onPasswordValidityChanged.call(_isPasswordValid);
    });
  }

  void _togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    BlocProvider.of<PasswordVisibilityBloc>(context)
        .add(VisibilityChangedEvent());
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextField(
            controller: _passwordController,
            focusNode: _focusNode,
            obscureText: !_isPasswordVisible,
            onChanged: _checkPasswordValidity,
            style: font.getPoppinsTextStyle(
                color: theme.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.41),
            decoration: InputDecoration(
              hintText: "Password",
              border: InputBorder.none,
              hintStyle: font.getPoppinsTextStyle(
                  color: theme.textHint,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.41),
              fillColor: Colors.transparent,
              filled: true,
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: theme.textHint,
                ),
                onPressed: _togglePasswordVisibility,
              ),
            ),
          ),
        ),
        show
            ? Padding(
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
                              color: theme.mainBackground,
                              border: Border.all(color: Color(0xFF858585)),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Text(
                                      "Password must contain:",
                                      style: font.getPoppinsTextStyle(
                                          color: theme.textPrimary,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: -0.41),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: List.generate(conditions.length,
                                        (index) {
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Text(
                                                "${conditionsMet[index] ? '✓' : '❌'}",
                                                style: font.getPoppinsTextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: -0.41,
                                                    color: conditionsMet[index]
                                                        ? Colors.green
                                                        : theme.error)),
                                          ),
                                          Text("${conditions[index]}",
                                              style: font.getPoppinsTextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: -0.41,
                                                  color: conditionsMet[index]
                                                      ? Colors.green
                                                      : theme.error)),
                                        ],
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            : SizedBox(
                height: 29,
              )
      ],
    );
  }

  late String password = _passwordController.text;
}
