import 'package:dashboard_bloc_tdd/src/auth/domain/usecases/forgot_password.dart';
import 'package:dashboard_bloc_tdd/src/auth/domain/usecases/sign_in.dart';
import 'package:dashboard_bloc_tdd/src/auth/domain/usecases/sign_up.dart';
import 'package:dashboard_bloc_tdd/src/auth/domain/usecases/update_user.dart';
import 'package:dashboard_bloc_tdd/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSignIn extends Mock implements SignIn {}

class MockSignUp extends Mock implements SignUp {}

class MockForgotPassword extends Mock implements ForgotPassword {}

class MockUpdateUser extends Mock implements UpdateUser {}

void main() {
  late SignIn signIn;
  late SignUp signUp;
  late ForgotPassword forgotPassword;
  late UpdateUser updateUser;
  late AuthBloc authBloc;

  setUp(() {
    signIn = MockSignIn();
    signUp = MockSignUp();
    forgotPassword = MockForgotPassword();
    updateUser = MockUpdateUser();
    authBloc = AuthBloc(
      signIn: signIn,
      signUp: signUp,
      forgotPassword: forgotPassword,
      updateUser: updateUser,
    );
  });

  // after each individal test tear down the block, so the state of the block
  // does not leak into the next test
  tearDown(() => authBloc.close());
}
