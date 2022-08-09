import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

@immutable
class AppEvent {
  const AppEvent();
}

@immutable
class AdClickedEvent extends AppEvent {}

@immutable
class AdCreatedEvent extends AppEvent {}

@immutable
class AdWatchedEvent extends AppEvent {}

@immutable
class AdWatchingEvent extends AppEvent {}

@immutable
class LoginEvent extends AppEvent {}

@immutable
class LoginSuccessfulEvent extends AppEvent {
  UserCredential credential;
  LoginSuccessfulEvent({required this.credential});
}

@immutable
class LoginFailedEvent extends AppEvent {}

@immutable
class SignOutEvent extends AppEvent {}
