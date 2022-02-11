import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/presentation/journeys/new_donation/make_donation.dart';
import 'package:idonatio/presentation/journeys/user/cubit/user_cubit.dart';

import '../../di/get_it.dart';
import '../../enums.dart';
import '../router/app_router.dart';
import 'auth_guard.dart';
import 'manage_account/cubit/logout_cubit.dart';
import 'manage_account/manage_account_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static final List<Widget> _homeScreens = <Widget>[
    const MakeDonationScreen(),
    Center(
      child: BlocConsumer<LogoutCubit, LogoutState>(
        listener: (context, state) {
          if (state is LogoutSuccessful) {
            context
                .read<UserCubit>()
                .setUserState(getItInstance(), AuthStatus.unauthenticated);
            Navigator.pushAndRemoveUntil(context,
                AppRouter.routeToPage(const AuthGaurd()), (route) => false);
          }
        },
        builder: (context, state) {
          if (state is LogoutLoading) {
            return const CircularProgressIndicator();
          } else {
            return ElevatedButton(
                onPressed: () {
                  log('hey');
                  context.read<LogoutCubit>().logoutUser();
                },
                child: const Text('Loggout'));
          }
        },
      ),
    ),
    const Text('05 – Saved donees'),
    const ManageAccountScreen(),
  ];
  int pageIndex = 0;
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
    
        body: Center(
          child: PageView(
            children: _homeScreens,
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                pageIndex = index;
              });
            },
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: MediaQuery.of(context).size.height * .1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IdonationButtomNavItem(
                icon: Icons.add_circle_outline_rounded,
                pageIndex: 0,
                text: 'new',
                pageController: pageController,
                navItemColor: pageIndex == 0
                    ? Theme.of(context).primaryColorDark
                    : Theme.of(context).primaryColor,
              ),
              IdonationButtomNavItem(
                icon: Icons.history,
                pageController: pageController,
                text: 'History',
                pageIndex: 1,
                navItemColor: pageIndex == 1
                    ? Theme.of(context).primaryColorDark
                    : Theme.of(context).primaryColor,
              ),
              IdonationButtomNavItem(
                icon: Icons.favorite_border,
                pageIndex: 2,
                pageController: pageController,
                text: 'Donees',
                navItemColor: pageIndex == 2
                    ? Theme.of(context).primaryColorDark
                    : Theme.of(context).primaryColor,
              ),
              IdonationButtomNavItem(
                icon: Icons.manage_accounts_outlined,
                pageIndex: 3,
                pageController: pageController,
                text: 'Account',
                navItemColor: pageIndex == 3
                    ? Theme.of(context).primaryColorDark
                    : Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IdonationButtomNavItem extends StatelessWidget {
  const IdonationButtomNavItem({
    Key? key,
    required this.icon,
    required this.pageIndex,
    required this.pageController,
    required this.navItemColor,
    required this.text,
  }) : super(key: key);
  final IconData icon;
  final int pageIndex;
  final Color navItemColor;
  final PageController pageController;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          pageController.animateToPage(pageIndex,
              curve: Curves.ease, duration: const Duration(milliseconds: 300));
        },
        child: Container(
          color: navItemColor,
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
