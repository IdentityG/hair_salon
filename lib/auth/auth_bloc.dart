import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignupEvent extends AuthEvent {
  final String name;
  final String email;
  final String phone;
  final String password;

  const SignupEvent({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, phone, password];
}

class ForgotPasswordEvent extends AuthEvent {
  final String email;

  const ForgotPasswordEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

class ResendOtpEvent extends AuthEvent {
  final String emailOrPhone;

  const ResendOtpEvent({required this.emailOrPhone});

  @override
  List<Object?> get props => [emailOrPhone];
}

class VerifyOtpEvent extends AuthEvent {
  final String otp;
  final String emailOrPhone;

  const VerifyOtpEvent({required this.otp, required this.emailOrPhone});

  @override
  List<Object?> get props => [otp, emailOrPhone];
}

class ResetPasswordEvent extends AuthEvent {
  final String password;

  const ResetPasswordEvent({required this.password});

  @override
  List<Object?> get props => [password];
}

class LogoutEvent extends AuthEvent {}

// States
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}

class OtpSent extends AuthState {
  final String email;

  const OtpSent({required this.email});

  @override
  List<Object?> get props => [email];
}

class OtpVerified extends AuthState {}

class PasswordReset extends AuthState {}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<SignupEvent>(_onSignup);
    on<ForgotPasswordEvent>(_onForgotPassword);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<ResetPasswordEvent>(_onResetPassword);
    on<LogoutEvent>(_onLogout);
    on<ResendOtpEvent>(_onResendOtp);
  }

  // In a real app, these would call authentication services
  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // For demo purposes, we'll just check if the email contains '@'
      // and password is at least 6 characters
      if (!event.email.contains('@')) {
        emit(const AuthError(message: 'Invalid email format'));
        return;
      }
      
      if (event.password.length < 6) {
        emit(const AuthError(message: 'Password must be at least 6 characters'));
        return;
      }
      
      // Success
      emit(AuthAuthenticated());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onSignup(SignupEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Basic validation
      if (event.name.isEmpty) {
        emit(const AuthError(message: 'Name cannot be empty'));
        return;
      }
      
      if (!event.email.contains('@')) {
        emit(const AuthError(message: 'Invalid email format'));
        return;
      }
      
      if (event.phone.length < 10) {
        emit(const AuthError(message: 'Invalid phone number'));
        return;
      }
      
      if (event.password.length < 6) {
        emit(const AuthError(message: 'Password must be at least 6 characters'));
        return;
      }
      
      // Success
      emit(AuthAuthenticated());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onForgotPassword(ForgotPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      if (!event.email.contains('@') && !RegExp(r'^\d{10}$').hasMatch(event.email)) {
        emit(const AuthError(message: 'Please enter a valid email or phone number'));
        return;
      }
      
      // Success - OTP sent
      emit(OtpSent(email: event.email));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onVerifyOtp(VerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // For demo, we'll accept any 4-digit code
      if (event.otp.length != 4) {
        emit(const AuthError(message: 'Please enter a valid 4-digit code'));
        return;
      }
      
      // Success
      emit(OtpVerified());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onResetPassword(ResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      if (event.password.length < 6) {
        emit(const AuthError(message: 'Password must be at least 6 characters'));
        return;
      }
      
      // Success
      emit(PasswordReset());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onResendOtp(ResendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Success - OTP resent
      emit(OtpSent(email: event.emailOrPhone));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}