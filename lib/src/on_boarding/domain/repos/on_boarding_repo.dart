/// abstract class, which acts as an interface for the data layer.
/// It abstracts the data source and contains methods that are relevant to
/// the onboarding feature of the application.
library;

import 'package:dashboard_bloc_tdd/core/utils/typdefs.dart';

abstract class OnBoardingRepo {
  const OnBoardingRepo();

  /// With this we check if we are going to show the onboarding
  /// or this is not users first time and
  /// user will be pushed on login/home screen
  /// A method to cache the information that the user has seen the onboarding.
  ResultFuture<void> cacheFirstTiemr();

  // A method to check whether the user is opening the app for the first time.
  ResultFuture<bool> checkIfUserIsFirstTimer();
}
