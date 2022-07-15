import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/presentation/journeys/donation_history/bloc/donation_history_bloc.dart';
import 'package:idonatio/presentation/journeys/home.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/dialogs/app_error_dailog.dart';
import 'package:idonatio/presentation/widgets/loaders/primary_app_loader_widget.dart';

import '../../reusables.dart';
import '../../widgets/input_fields/donation_history_list_card_item.dart';

class DonationHistoryScreen extends StatefulWidget {
  const DonationHistoryScreen({Key? key}) : super(key: key);

  @override
  State<DonationHistoryScreen> createState() => _DonationHistoryScreenState();
}

class _DonationHistoryScreenState extends State<DonationHistoryScreen> {
  bool isStartSearch = false;
  late TextEditingController _searchController;
  final _scrollController = ScrollController();

  late Timer searchOnStoppedTyping;
  static const duration = Duration(milliseconds: 800);
  String highlightSearch = '';
  _onChangeHandler(value) {
    const duration = Duration(
        milliseconds:
            800); // set the duration that you want call search() after that.
    setState(() => searchOnStoppedTyping.cancel());
    search(value) {
      highlightSearch = value;
      if (value.isEmpty) {
        context.read<DonationHistoryBloc>().add(const DonationHistoryFetched());
      } else {
        //Todo add search
        // context.read<DonationHistoryBloc>().add(value);
      }
    }

    setState(
        () => searchOnStoppedTyping = Timer(duration, () => search(value)));
  }

  @override
  void initState() {
    _searchController = TextEditingController();
    searchOnStoppedTyping = Timer(duration, () {});
    _scrollController.addListener(_onScroll);

    // context.read<DonationHistoryBloc>().add(const DonationHistoryFetched());

    super.initState();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<DonationHistoryBloc>().add(const DonationHistoryFetched());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  Future<void> _refereshHistory() async {
    context.read<DonationHistoryBloc>().add(const DonationHistoryRefreshed());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: gradientBoxDecoration(),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isStartSearch = !isStartSearch;
                            });
                          },
                          icon: const Icon(Icons.search,
                              size: 32, color: AppColor.text80Primary),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your donations',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                              'A history of donations you’ve made through this app. Select a donation to view more details.'),
                          const SizedBox(
                            height: 32,
                          ),
                          // empty list
                          BlocBuilder<DonationHistoryBloc,
                              DonationHistoryState>(
                            builder: (context, state) {
                              if (state.status ==
                                      DonationHistoryStatus.success &&
                                  state.donationHistory.isNotEmpty) {
                                return const SizedBox.shrink();
                              } else {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Get started by making a donation.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            fontSize: 14,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    const Text(
                                      'A list of your past donations will appear here once you make a donation.',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                            fixedSize: const Size(180, 48)),
                                        onPressed: () {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              AppRouter.routeToPage(
                                                  const HomeScreen(
                                                pageIndex: 0,
                                              )),
                                              (route) => false);
                                        },
                                        child: Row(
                                          children: [
                                            const Icon(Icons.add),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              'New Donation'.toUpperCase(),
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        )),
                                  ],
                                );
                              }
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
// data
                        ],
                      ),
                    ),
                    BlocBuilder<DonationHistoryBloc, DonationHistoryState>(
                        builder: (context, state) {
                      switch (state.status) {
                        case DonationHistoryStatus.failue:
                          return AppErrorDialogWidget(
                            message: state.message,
                            title: 'Error',
                          );
                        case DonationHistoryStatus.success:
                          return state.donationHistory.isNotEmpty
                              ? Container(
                                  height:
                                      MediaQuery.of(context).size.height * .6,
                                  decoration: whiteContainerBackGround(),
                                  child: RefreshIndicator(
                                    onRefresh: _refereshHistory,
                                    child: ListView.builder(
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return index >=
                                                state.donationHistory.length
                                            ? const BottomLoader()
                                            : DonationHistoryListCardItem(
                                                key: Key(state
                                                    .donationHistory[index].id),
                                                donationData: state
                                                    .donationHistory[index],
                                                searchTerm: highlightSearch,
                                              );
                                      },
                                      itemCount: state.hasReachedMax == true
                                          ? state.donationHistory.length
                                          : state.donationHistory.length + 1,
                                      controller: _scrollController,
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink();
                        default:
                          return const Center(
                            child: PrimaryAppLoader(),
                          );
                      }
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomLoader extends StatelessWidget {
  const BottomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          strokeWidth: 1.5,
          color: Color(0xff4E4CEC),
        ),
      ),
    );
  }
}
