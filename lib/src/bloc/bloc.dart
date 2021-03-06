import 'dart:async';
import 'validators.dart';
import 'package:rxdart/rxdart.dart';

//class car extends vehicle with Drivable, Parkable {}
// This subclass car extends the base class with some mixins
//so our Validators ar emixins and if we sya
// class bloc with validators, that won't work
// option one is to make the Validators as if they are the base class => class Bloc extends Validators
// option two is to extend the ultimate base base class of Object with the Validator mixin

class Bloc extends Object with Validators {
// two stream controllers, password and pasword
// marc the field as privat so that it is hidden from other files in the project
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  // onInput -> map. this converts the html event input into a string. so define the input value as type <String>

  // define a getter, which is a shortcut for deep drilling into
  // bloc.emailController.sink.add

  // these are getters
  // retireve data from the stream
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<bool> get submitValid =>
      Rx.combineLatest2(email, password, (e, p) => true);

  // add/change data, from the sink, to the stream
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get chanegePassword => _password.sink.add;

  submit() {
    final validEmail = _email.value;
    final validPassword = _password.value;

    print('Email is $validEmail');
    print('Password is $validatePassword');
  }

  // close the sinks when done
  // dispose() {
  //   _email.close();
  //   _password.close();
  // }
}

//make a global instance of our Bloc class to use everywhere, if scoped version is needed then create an instance in the hierarchy where it is needed,
// see provider.dart
// final bloc = Bloc();
