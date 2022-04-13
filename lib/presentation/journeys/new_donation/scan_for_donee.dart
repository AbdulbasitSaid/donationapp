import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/get_donation_fees_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/getdoneebycode_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/donee_confirmatoin.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/user_models/user_data_model.dart';
import '../saved_donees/cubit/get_saved_donees_cubit.dart';
import 'donation_details.dart';

class ScanForDoneeScreen extends StatefulWidget {
  const ScanForDoneeScreen({Key? key}) : super(key: key);

  @override
  _ScanForDoneeScreenState createState() => _ScanForDoneeScreenState();
}

class _ScanForDoneeScreenState extends State<ScanForDoneeScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  bool isFlashLightOn = false;
  QRViewController? qrViewController;
  @override
  void reassemble() {
    if (Platform.isAndroid) {
      qrViewController!.pauseCamera();
    } else if (Platform.isIOS) {
      qrViewController!.resumeCamera();
    }
    super.reassemble();
  }

  @override
  void dispose() {
    qrViewController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final getSavedDoneeState = context.watch<GetSavedDoneesCubit>().state;

    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: Hive.box<UserData>('user_box').listenable(),
            builder: (context, Box<UserData> box, widget) {
              final user = box.get('user_data')?.user;

              return Stack(
                children: [
                  QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                  ),
                  Positioned.fill(
                    bottom: 20,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, .7),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Text(
                          'Point your camera at a QR code',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              FeatherIcons.x,
                              color: Colors.white,
                              size: 32,
                            )),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                qrViewController?.toggleFlash();
                                setState(() {
                                  isFlashLightOn = !isFlashLightOn;
                                });
                              },
                              icon: Icon(isFlashLightOn
                                  ? FeatherIcons.zap
                                  : FeatherIcons.zapOff),
                              color: Colors.white,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                FontAwesome.question_circle_o,
                                color: Colors.white,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  BlocConsumer<GetdoneebycodeCubit, GetdoneebycodeState>(
                    listenWhen: (previous, current) =>
                        current is GetdoneebycodeSuccess,
                    listener: (context, state) {
                      if (state is GetdoneebycodeSuccess) {
                        qrViewController!.dispose();
                        context.read<GetDonationFeesCubit>().getFees();
                        if (getSavedDoneeState is GetSavedDoneesSuccess &&
                            getSavedDoneeState.savedDoneesResponseModel.data!
                                .map((e) => e.id)
                                .toList()
                                .contains(state.doneeResponseData.id)) {
                          Navigator.push(
                              context,
                              AppRouter.routeToPage(DonationDetialsScreen(
                                  isEnableGiftAid: user!.donor.giftAidEnabled,
                                  isDonateAnonymously:
                                      user.donor.donateAnonymously)));
                        } else {
                          Navigator.push(
                              context,
                              AppRouter.routeToPage(
                                  const DoneeConfirmationScreen()));
                        }
                      }
                    },
                    builder: (context, state) {
                      if (state is GetdoneebycodeFailed) {
                        return Positioned.fill(
                          top: MediaQuery.of(context).size.height * .1,
                          bottom: MediaQuery.of(context).size.height * .7,
                          left: 16,
                          right: 16,
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(state.errorMessage),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('retry'.toUpperCase()))
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  )
                ],
              );
            }),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    qrViewController = controller;
    qrViewController!.scannedDataStream.listen((scanData) {
      setState(() {
        context.read<GetdoneebycodeCubit>().getDoneeByCode(scanData.code!);
      });
    });
  }
}
