import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/presentation/journeys/donation_history/bloc/donation_history_bloc.dart';
import 'package:idonatio/presentation/journeys/donation_history/bloc/donation_history_search_bloc.dart';
import 'package:idonatio/presentation/journeys/donation_history/cubit/donation_aggregation_cubit.dart';
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
  String searchValue = '';
  late TextEditingController _searchController;

  final _scrollController = ScrollController();
  final _searchScrollController = ScrollController();
  late Timer searchOnStoppedTyping;
  static const duration = Duration(milliseconds: 800);
  String highlightSearch = '';
  _onChangeHandler(value) {
    const duration = Duration(
        milliseconds:
            800); // set the duration that you want call search() after that.
    setState(
      () => searchOnStoppedTyping.cancel(),
    );
    setState(() => searchOnStoppedTyping = Timer(
        duration,
        () => context
            .read<DonationHistorySearchBloc>()
            .add(DonationHistorySearched(searchString: value))));
  }

  @override
  void initState() {
    _searchController = TextEditingController();
    searchOnStoppedTyping = Timer(duration, () {});
    _scrollController.addListener(_onScroll);
    _searchScrollController.addListener(_onSearchScroll);
    super.initState();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<DonationHistoryBloc>().add(const DonationHistoryFetched());
    } else {
      return;
    }
  }

  void _onSearchScroll() {
    if (_isSearchBottom) {
      context.read<DonationHistorySearchBloc>().add(
          DonationHistorySearched(searchString: _searchController.value.text));
    } else {
      return;
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll);
  }

  bool get _isSearchBottom {
    if (!_searchScrollController.hasClients) return false;
    final maxScroll = _searchScrollController.position.maxScrollExtent;
    final currentScroll = _searchScrollController.offset;
    return currentScroll >= (maxScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchScrollController
      ..removeListener(_onSearchScroll)
      ..dispose();

    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: gradientBoxDecoration(),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isStartSearch == true
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width * .6,
                              child: TextField(
                                controller: _searchController,
                                onChanged: (value) {
                                  _onChangeHandler(value);
                                },
                              ))
                          : const SizedBox.shrink(),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isStartSearch = !isStartSearch;
                            _searchController.clear();

                            log(isStartSearch.toString());
                          });
                          context
                              .read<DonationHistoryBloc>()
                              .add(const DonationHistoryRefreshed());
                          context
                              .read<DonationHistorySearchBloc>()
                              .add(DonationHistorySearchRefreshed());
                        },
                        icon: const Icon(Icons.search,
                            size: 32, color: AppColor.text80Primary),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              isStartSearch == false
                  ? Padding(
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
                            height: 16,
                          ),
                          BlocBuilder<DonationAggregationCubit,
                              DonationAggregationState>(
                            builder: (context, state) {
                              if (state is DonationAggregationSuccess) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Total donations made: ${state.donationAggrateModel.data.total}"),
                                    const SizedBox(height: 8),
                                    Text(
                                        "Averrage donations made: ${state.donationAggrateModel.data.average}"),
                                    const SizedBox(height: 8),
                                    BlocBuilder<DonationHistoryBloc,
                                        DonationHistoryState>(
                                      builder: (context, state) {
                                        switch (state.status) {
                                          case DonationHistoryStatus.success:
                                            return Text(
                                                'Your donation count: ${state.donationCount}');
                                          default:
                                            return const Text(
                                                'loading dontion count');
                                        }
                                      },
                                    ),
                                  ],
                                );
                              }
                              return const Center(child: PrimaryAppLoader());
                            },
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
                    )
                  : const SizedBox.shrink(),
              isStartSearch == false
                  ? DonationHistoryListWidget(
                      scrollController: _scrollController)
                  : DonationHistorySearchListWidget(
                      seachScrollController: _searchScrollController,
                      highlightString: _searchController.value.text,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class DonationHistorySearchListWidget extends StatelessWidget {
  const DonationHistorySearchListWidget({
    Key? key,
    required this.seachScrollController,
    required this.highlightString,
  }) : super(key: key);
  final ScrollController seachScrollController;
  final String highlightString;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DonationHistorySearchBloc, DonationHistorySearchState>(
      builder: (context, state) {
        switch (state.status) {
          case DonationHistorySearchedStatus.loading:
            return const Center(
              child: PrimaryAppLoader(),
            );
          case DonationHistorySearchedStatus.failue:
            return Padding(
              padding: const EdgeInsets.all(16),
              child: AppErrorDialogWidget(
                message: state.message,
                title: 'Error searhing for donee',
              ),
            );
          case DonationHistorySearchedStatus.success:
            return state.donationHistory.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'No results found.',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColor.text80Primary),
                        ),
                        Text('Please try a different search term.'),
                      ],
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height * .7,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListView.builder(
                      controller: seachScrollController,
                      itemBuilder: (context, index) {
                        return index == state.donationHistory.length
                            ? const Center(child: PrimaryAppLoader())
                            : DonationHistorySearchListCardItem(
                                donationData: state.donationHistory[index],
                                key: Key(state.donationHistory[index].id),
                                highlightString: highlightString,
                              );
                      },
                      itemCount: state.hasReachedMax == true
                          ? state.donationHistory.length
                          : state.donationHistory.length + 1,
                    ),
                  );
          default:
            return Container(
              padding: const EdgeInsets.all(16),
              child: const Text('Search by donee name'),
            );
        }
      },
    );
  }
}

class DonationHistoryListWidget extends StatelessWidget {
  const DonationHistoryListWidget({
    Key? key,
    required ScrollController scrollController,
  })  : _scrollController = scrollController,
        super(key: key);

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DonationHistoryBloc, DonationHistoryState>(
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
                  height: MediaQuery.of(context).size.height * .5,
                  decoration: whiteContainerBackGround(),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context
                          .read<DonationHistoryBloc>()
                          .add(const DonationHistoryRefreshed());
                      context
                          .read<DonationAggregationCubit>()
                          .getDonationAggregate();
                    },
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return index == state.donationHistory.length
                            ? const Center(child: PrimaryAppLoader())
                            : DonationHistoryByIdListCardItem(
                                firstThisMonthKey: Key(state.donationHistory
                                    .where((element) =>
                                        element.monthRanking == 'this-month')
                                    .first
                                    .id),
                                earlierMonthKey: state.donationHistory
                                        .where((element) =>
                                            element.monthRanking == 'earlier')
                                        .isNotEmpty
                                    ? Key(state.donationHistory
                                        .where((element) =>
                                            element.monthRanking == 'earlier')
                                        .first
                                        .id)
                                    : Key(state.donationHistory
                                        .where((element) =>
                                            element.monthRanking ==
                                            'this-month')
                                        .first
                                        .id),
                                key: Key(state.donationHistory[index].id),
                                donationData: state.donationHistory[index],
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
    });
  }
}
