import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

class AuthForm extends StatefulWidget {
  Function submitfn;
  AuthForm(this.submitfn);
  // const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _passwordFocus = FocusNode();
  final _enrollFocus = FocusNode();
  final formKey = GlobalKey<FormState>();
  var _isLogin;
  var _year;
  var _branch;
  var _email;
  var _password;
  var _enroll;

  @override
  void initState() {
    _year = '';
    _branch = '';
    _isLogin = true;
    // TODO: implement initState
    super.initState();
  }

  void _saveForm() {
    var form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      widget.submitfn(
        _email,
        _password,
        _enroll,
        _branch,
        _year,
        _isLogin,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 6,
        child: Container(
          padding: EdgeInsets.all(6),
          child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Email-id'),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Provide a value';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) =>
                        FocusScope.of(context).requestFocus(_passwordFocus),
                    onSaved: (newValue) => _email = newValue,
                  ),
                  TextFormField(
                    focusNode: _passwordFocus,
                    decoration: const InputDecoration(
                      label: Text('Password'),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Provide a value';
                      }
                      if (value.length < 7) {
                        return 'Minimum lenght of password is 7';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) =>
                        FocusScope.of(context).requestFocus(_enrollFocus),
                    onSaved: (newValue) => _password = newValue,
                  ),
                  if (!_isLogin)
                    TextFormField(
                      focusNode: _enrollFocus,
                      decoration: const InputDecoration(
                        label: Text('Enroll no.'),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Provide a value';
                        }
                        if (value.length != 8) {
                          return 'Enrollment number should contain 8 digits';
                        }

                        return null;
                      },
                      onSaved: (newValue) => _enroll = newValue,
                    ),
                  if (!_isLogin)
                    DropDownFormField(
                      titleText: 'Branch',
                      hintText: 'Select your branch',
                      value: _branch,
                      onSaved: (newValue) {
                        setState(() {
                          _branch = newValue;
                        });
                      },
                      onChanged: (newValue) {
                        setState(() {
                          _branch = newValue;
                        });
                      },
                      dataSource: [
                        {
                          'display': 'P&I',
                          'value': 'P&I',
                        },
                        {
                          'display': 'Mech',
                          'value': 'Mech',
                        },
                        {
                          'display': 'Meta',
                          'value': 'Meta',
                        },
                        {
                          'display': 'EE',
                          'value': 'EE',
                        },
                        {
                          'display': 'Biotech',
                          'value': 'BioTech',
                        }
                      ],
                      textField: 'display',
                      valueField: 'value',
                    ),
                  if (!_isLogin)
                    DropDownFormField(
                      titleText: 'Year',
                      hintText: 'Select your year',
                      value: _year,
                      onSaved: (newValue) {
                        setState(() {
                          _year = newValue;
                        });
                      },
                      onChanged: (newValue) {
                        setState(() {
                          _year = newValue;
                        });
                      },
                      dataSource: [
                        {
                          'display': '1',
                          'value': '1',
                        },
                        {
                          'display': '2',
                          'value': '2',
                        },
                        {
                          'display': '3',
                          'value': '3',
                        },
                        {
                          'display': '4',
                          'value': '4',
                        },
                        {
                          'display': '5',
                          'value': '5',
                        }
                      ],
                      textField: 'display',
                      valueField: 'value',
                    ),
                  ElevatedButton(
                    onPressed: _saveForm,
                    child: _isLogin
                        ? const Text(
                            'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : const Text(
                            'Sign-up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  TextButton(
                    onPressed: (() {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    }),
                    child: _isLogin
                        ? const Text(
                            'Create new account',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : const Text(
                            'Login instead',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
