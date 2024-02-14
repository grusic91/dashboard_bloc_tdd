import 'package:dashboard_bloc_tdd/core/common/views/page_under_construction.dart';
import 'package:dashboard_bloc_tdd/core/extensions/context_extension.dart';
import 'package:dashboard_bloc_tdd/core/services/injection_container.dart';
import 'package:dashboard_bloc_tdd/src/auth/data/models/user_model.dart';
import 'package:dashboard_bloc_tdd/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:dashboard_bloc_tdd/src/auth/presentation/views/sign_in_screen.dart';
import 'package:dashboard_bloc_tdd/src/auth/presentation/views/sign_up_screen.dart';
import 'package:dashboard_bloc_tdd/src/dashboard/presentation/views/dashboard.dart';
import 'package:dashboard_bloc_tdd/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:dashboard_bloc_tdd/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:dashboard_bloc_tdd/src/on_boarding/presentation/views/on_boarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as uiauth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'router.main.dart';
