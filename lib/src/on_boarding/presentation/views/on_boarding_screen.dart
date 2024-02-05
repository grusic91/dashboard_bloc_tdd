import 'package:dashboard_bloc_tdd/core/common/views/loading_view.dart';
import 'package:dashboard_bloc_tdd/core/common/widgets/gradient_background.dart';
import 'package:dashboard_bloc_tdd/core/res/colors.dart';
import 'package:dashboard_bloc_tdd/core/res/media_res.dart';
import 'package:dashboard_bloc_tdd/src/on_boarding/domain/entities/page_content.dart';
import 'package:dashboard_bloc_tdd/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:dashboard_bloc_tdd/src/on_boarding/presentation/widgets/on_boarding_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  static const routeNmae = '/';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
    context.read<OnBoardingCubit>().checkIfUserIsFirstTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        image: MediaRes.onBoardingBackground,
        child: BlocConsumer<OnBoardingCubit, OnBoardingState>(
          listener: (BuildContext context, Object? state) {
            if (state is OnBoardingStatus && !state.isFisFirstTimer) {
              Navigator.pushReplacementNamed(context, '/home');
            } else if (state is UserCached) {
              // user cached success
            }
          },
          builder: (BuildContext context, state) {
            if (state is CheckingIfUserIsFistTimer ||
                state is CachingFirstTimer) {
              // return loading screen
              return const LoadingView();
            }

            return Stack(
              children: [
                PageView(
                  controller: pageController,
                  children: const [
                    OnBoardingBody(pageContent: PageContent.first()),
                    OnBoardingBody(pageContent: PageContent.second()),
                    OnBoardingBody(pageContent: PageContent.third()),
                  ],
                ),
                Align(
                  alignment: const Alignment(0, .04),
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    onDotClicked: (index) {
                      pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    effect: const WormEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 40,
                      activeDotColor: Colours.primaryColour,
                      dotColor: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
