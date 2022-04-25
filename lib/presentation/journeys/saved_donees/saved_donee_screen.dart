import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:idonatio/presentation/journeys/saved_donees/cubit/get_saved_donees_cubit.dart';
import 'package:idonatio/presentation/journeys/saved_donees/cubit/recentdonees_cubit.dart';
import 'package:idonatio/presentation/journeys/saved_donees/save_donee_add_by_id_screen.dart';
import 'package:idonatio/presentation/journeys/saved_donees/save_donee_add_by_qr_code_screen.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/themes/app_color.dart';

import '../../reusables.dart';
import '../../widgets/input_fields/saved_donee_list_item_widget.dart';
import '../../widgets/labels/level_2_heading.dart';
import '../../widgets/labels/level_6_headline.dart';

class SavedDoneeScreen extends StatefulWidget {
  const SavedDoneeScreen({
    Key? key,
    this.showBackButton = false,
  }) : super(key: key);

  @override
  State<SavedDoneeScreen> createState() => _SavedDoneeScreenState();
  final bool showBackButton;
}

class _SavedDoneeScreenState extends State<SavedDoneeScreen> {
  bool isStartSearch = false;
  late Timer searchOnStoppedTyping;
  static const duration = Duration(milliseconds: 800);
  bool isScrolling = false;
  late TextEditingController _searchController;
  String highlightString = '';
  _onChangeHandler(value) {
    const duration = Duration(
        milliseconds:
            800); // set the duration that you want call search() after that.
    setState(() => searchOnStoppedTyping.cancel());
    search(String value) {
      highlightString = value;
      if (value.isEmpty) {
        context.read<GetSavedDoneesCubit>().getSavedDonee();
      } else {
        context
            .read<GetSavedDoneesCubit>()
            .seachSavedDonee(_searchController.text);
      }
    }

    setState(
        () => searchOnStoppedTyping = Timer(duration, () => search(value)));
  }

  @override
  void initState() {
    _searchController = TextEditingController();
    searchOnStoppedTyping = Timer(duration, () {});

    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: widget.showBackButton,
          actions: [
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) =>
                    SimpleDialog(title: const Text('Add donee'), children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  AppRouter.routeToPage(
                                      const SaveDoneeAddDoneeByIdScreen()));
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.add_circle_outline_rounded),
                                const SizedBox(
                                  width: 24,
                                ),
                                Text(
                                  'Add by ID',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                )
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  AppRouter.routeToPage(
                                      const SaveDoneeAddByQrCodeScreen()));
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.qr_code_2),
                                const SizedBox(
                                  width: 24,
                                ),
                                Text(
                                  'Scan QR Code',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                )
                              ],
                            )),
                      ),
                    ]));
          },
          child: const Icon(Icons.add),
        ),
        body: Container(
          decoration: gradientBoxDecoration(),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                isStartSearch
                    ? Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: const Color(0xff425A70).withOpacity(.25),
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                              spreadRadius: -2),
                          BoxShadow(
                              color: const Color(0xff425A70).withOpacity(.25),
                              offset: const Offset(0, 0),
                              blurRadius: 1,
                              spreadRadius: 0),
                        ]),
                        child: TextFormField(
                          onChanged: _onChangeHandler,
                          autofocus: true,
                          controller: _searchController,
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Search',
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                            prefix: IconButton(
                              padding: const EdgeInsets.all(0),
                              icon: const Icon(
                                FeatherIcons.x,
                                color: AppColor.baseText80Primary,
                              ),
                              onPressed: () {
                                setState(() {
                                  context
                                      .read<GetSavedDoneesCubit>()
                                      .getSavedDonee();
                                  isStartSearch = !isStartSearch;
                                });
                              },
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                !isStartSearch
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                              padding: EdgeInsets.all(16),
                              child: Level2Headline(
                                text: 'Saved doneess',
                              )),
                          const Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                """A list of organisation or individual recipients you’ve saved to this app. Add a new donee or select one to view more details.""",
                              )),
                          const SizedBox(
                            height: 16,
                          ),
                          BlocConsumer<GetSavedDoneesCubit,
                              GetSavedDoneesState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              if (state is RecentdoneesLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (state is GetSavedDoneesSuccess &&
                                  state.savedDoneesResponseModel.data != null) {
                                final recentlySaved = state
                                    .savedDoneesResponseModel.data!
                                    .where((e) =>
                                        e.createdAt!.month ==
                                        DateTime.now().month)
                                    .take(5)
                                    .toList();
                                return recentlySaved.isNotEmpty
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Level6Headline(
                                                text: 'Added recently'),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(16),
                                            decoration:
                                                whiteContainerBackGround(),
                                            child: Column(children: [
                                              if (recentlySaved.isNotEmpty)
                                                ...recentlySaved.map((e) =>
                                                    SavedDoneeListItemWidget(
                                                      donee: e,
                                                      highlightString:
                                                          highlightString,
                                                    ))
                                            ]),
                                          ),
                                        ],
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                                'Get started by adding a donee.'),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              'A list of donees you have saved will appear here once you add a donee.',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            ),
                                          ],
                                        ),
                                      );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          BlocConsumer<GetSavedDoneesCubit,
                              GetSavedDoneesState>(
                            listener: (context, state) {
                              // TODO: implement listener
                            },
                            builder: (context, state) {
                              if (state is GetSavedDoneesLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (state is GetSavedDoneesSuccess &&
                                  state.savedDoneesResponseModel.data!
                                      .isNotEmpty &&
                                  state.savedDoneesResponseModel.data != null) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Level6Headline(text: 'All donees'),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: whiteContainerBackGround(),
                                      child: Column(children: [
                                        ...state.savedDoneesResponseModel.data!
                                            .map(
                                                (e) => SavedDoneeListItemWidget(
                                                      donee: e,
                                                      highlightString:
                                                          highlightString,
                                                    ))
                                      ]),
                                    ),
                                  ],
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ],
                      )
                    : BlocConsumer<GetSavedDoneesCubit, GetSavedDoneesState>(
                        listener: (context, state) {
                          // TODO: implement listener
                        },
                        builder: (context, state) {
                          if (state is GetSavedDoneesLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state is GetSavedDoneesSuccess &&
                              state.savedDoneesResponseModel.data!.isNotEmpty &&
                              state.savedDoneesResponseModel.data != null) {
                            return Container(
                              padding: const EdgeInsets.all(16),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(.8)),
                              child: Column(
                                children: [
                                  ...state.savedDoneesResponseModel.data!
                                      .map((e) => SavedDoneeListItemWidget(
                                            donee: e,
                                            highlightString: highlightString,
                                          ))
                                ],
                              ),
                            );
                          }
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('No results found.'),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Please try a different search term.',
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      )
                                    ]),
                              )
                            ]),
                          );
                        },
                      ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
        ),
      ),
    );
  }
}
