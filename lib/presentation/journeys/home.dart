import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/di/get_it.dart';
import 'package:idonatio/enums.dart';
import 'package:idonatio/presentation/bloc/app_session_manager_bloc.dart';
import 'package:idonatio/presentation/bloc/server_timer_bloc.dart';
import 'package:idonatio/presentation/journeys/auth_guard.dart';
import 'package:idonatio/presentation/journeys/donation_history/history_screen.dart';
import 'package:idonatio/presentation/journeys/manage_account/cubit/logout_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/make_donation.dart';
import 'package:idonatio/presentation/journeys/saved_donees/saved_donee_screen.dart';
import 'package:idonatio/presentation/journeys/user/cubit/user_cubit.dart';
import 'package:idonatio/presentation/router/app_router.dart';

import '../widgets/buttons/logout_button_widget.dart';
import 'manage_account/manage_account_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    this.pageIndex = 0,
  }) : super(key: key);
  final int pageIndex;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  static final List<Widget> _homeScreens = <Widget>[
    const MakeDonationScreen(),
    const DonationHistoryScreen(),
    const SavedDoneeScreen(),
    const ManageAccountScreen(),
  ];
  late PageController pageController =
      PageController(initialPage: widget.pageIndex);
  late int pageIndex;

  @override
  void initState() {
    super.initState();
    pageIndex = widget.pageIndex;

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    pageController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  // ignore: unnecessary_overrides
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    final serverTimerState = context.watch<ServerTimerBloc>().state;
    final appTimerState = context.watch<AppSessionManagerBloc>().state;
    final logoutState = context.watch<LogoutCubit>().state;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: const [LogoutButton()],
      ),
      body: Center(
        child: BlocListener<AppSessionManagerBloc, AppSessionManagerState>(
          listener: (context, state) {
            {
              if (state is AppSessionManagerCompleted &&
                  serverTimerState is ServerTimerRunInProgress) {
                showAppSessionDialog(context);
              }
            }
          },
          child: BlocListener<ServerTimerBloc, ServerTimerState>(
            listener: (context, state) {
              if (logoutState is LogoutSuccessful) {
                return;
              } else {
                if (state is ServerTimerRunComplete &&
                    appTimerState is AppSessionManagerInProgress) {
                  showServerSessionDailog(context);
                }
              }
            },
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  pageIndex = index;
                });
              },
              children: _homeScreens,
            ),
          ),
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
    );
  }

  Future<dynamic> showServerSessionDailog(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (builder) => AlertDialog(
              title: const Text('Server Session Expired!!!'),
              content:
                  const Text('Server Session Expired!!. Please sign in again!'),
              actions: [
                TextButton(
                    onPressed: () {
                      _sessionLogout(context);
                    },
                    child: Text('ok'.toUpperCase()))
              ],
            ));
  }

  Future<dynamic> showAppSessionDialog(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (builder) => AlertDialog(
        title: const Text('App Session Expired!!!'),
        content: const Text(
            'App Expired due to long inactivity. Please sign in again!'),
        actions: [
          TextButton(
              onPressed: () {
                _sessionLogout(context);
              },
              child: Text('ok'.toUpperCase()))
        ],
      ),
    );
  }

  void _sessionLogout(BuildContext context) {
    context.read<AppSessionManagerBloc>().add(AppSessionStoped());
    context.read<ServerTimerBloc>().add(ServerTimerStop());
    context
        .read<UserCubit>()
        .setUserState(getItInstance(), AuthStatus.unauthenticated);
    Navigator.pushAndRemoveUntil(
        context, AppRouter.routeToPage(const AuthGaurd()), (route) => false);
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
