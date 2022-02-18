import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/presentation/journeys/saved_donees/cubit/get_saved_donees_cubit.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/donee_list_tile_widget.dart';

import '../../reusables.dart';

class SavedDoneeScreen extends StatefulWidget {
  const SavedDoneeScreen({Key? key}) : super(key: key);

  @override
  State<SavedDoneeScreen> createState() => _SavedDoneeScreenState();
}

class _SavedDoneeScreenState extends State<SavedDoneeScreen> {
  @override
  void initState() {
    context.read<GetSavedDoneesCubit>().getSavedDonee();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved donees'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
            child: BlocBuilder<GetSavedDoneesCubit, GetSavedDoneesState>(
          builder: (context, state) {
            if (state is GetSavedDoneesSuccess &&
                state.savedDoneesResponseModel.data!.isNotEmpty) {
              return Container(
                width: MediaQuery.of(context).size.width,
                decoration: whiteContainerBackGround(),
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  ...state.savedDoneesResponseModel.data!.map(
                    (e) => DoneeListTile(
                      key: Key('${e.id}'),
                      address: e.organization == null
                          ? e.addressLine1
                          : e.organization?.addressLine1,
                      doneeCode: '${e.doneeCode}',
                      name: e.organization == null
                          ? '${e.firstName} ${e.lastName}'
                          : e.organization?.name,
                    ),
                  ),
                ]),
              );
            }
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'A list of your recent donees will appear here once you make a donation or add a donee to your list.',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(),
                ),
              ),
            );
          },
        )),
        decoration: const BoxDecoration(
          gradient: AppColor.appBackground,
        ),
      ),
    );
  }
}
