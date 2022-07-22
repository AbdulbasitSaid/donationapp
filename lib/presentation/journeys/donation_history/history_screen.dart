import 'dart:async';
import 'dart:developer';

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
  String searchValue = '';
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
        context
            .read<DonationHistoryBloc>()
            .add(const DonationHistoryRefreshed());
      } else {
        context.read<DonationHistoryBloc>().add(DonationHistorySearched(
              searchQuery: value,
            ));
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
    super.initState();
  }

  void _onScroll() {
    if (_isBottom) {
      log(_searchController.text);
      isStartSearch == true
          ? context
              .read<DonationHistoryBloc>()
              .add(DonationHistorySearched(searchQuery: _searchController.text))
          : context
              .read<DonationHistoryBloc>()
              .add(const DonationHistoryFetched());
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

  @override
  void dispose() {
    _searchController.dispose();

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
          child: Stack(
            children: [
              Column(
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
                                  width: MediaQuery.of(context).size.width * .8,
                                  child: TextField(
                                    controller: _searchController,
                                    onChanged: (value) {
                                      _onChangeHandler(value);
                                    },
                                  ))
                              : const SizedBox.shrink(),
                          IconButton(
                            onPressed: () {
                              context
                                  .read<DonationHistoryBloc>()
                                  .add(const DonationHistoryRefreshed());

                              setState(() {
                                isStartSearch = !isStartSearch;
                              });
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
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                    MediaQuery.of(context).size.height * .55,
                                decoration: whiteContainerBackGround(),
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    context
                                        .read<DonationHistoryBloc>()
                                        .add(const DonationHistoryRefreshed());
                                  },
                                  child: ListView.builder(
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return index ==
                                              state.donationHistory.length
                                          ? const Center(
                                              child: PrimaryAppLoader())
                                          : DonationHistoryListCardItem(
                                              key: Key(state
                                                  .donationHistory[index].id),
                                              donationData:
                                                  state.donationHistory[index],
                                              searchTerm:
                                                  _searchController.text,
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
            ],
          ),
        ),
      ),
    );
  }
}
