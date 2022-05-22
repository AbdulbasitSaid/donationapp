import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:idonatio/presentation/journeys/home.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/getdoneebycode_cubit.dart';
import 'package:idonatio/presentation/journeys/user/cubit/user_cubit.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/widgets/loaders/primary_app_loader_widget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'donation_details.dart';

class ScanForDoneeScreen extends StatefulWidget {
  const ScanForDoneeScreen({Key? key}) : super(key: key);

  @override
  _ScanForDoneeScreenState createState() => _ScanForDoneeScreenState();
}

class _ScanForDoneeScreenState extends State<ScanForDoneeScreen> {

  late MobileScannerController mobileScannerController;
  @override
  void initState() {
    mobileScannerController = MobileScannerController();
  
    super.initState();
  }

  @override
  void dispose() {
    mobileScannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<UserCubit>().state;
    final getDoneeState = context.watch<GetdoneebycodeCubit>().state;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              BlocConsumer<GetdoneebycodeCubit, GetdoneebycodeState>(
                listener: (context, state) {
                  if (state is GetdoneebycodeSuccess &&
                      userState is Authenticated) {
                    final user = userState.userData.user.donor;
                    Navigator.push(
                      context,
                      AppRouter.routeToPage(DonationDetialsScreen(
                        isEnableGiftAid: user.giftAidEnabled,
                        isDonateAnonymously: user.giftAidEnabled,
                      )),
                      // (route) => true,
                    );
                  }
                  if (state is GetdoneebycodeFailed) {
                    mobileScannerController.events!.cancel();

                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (builder) => AlertDialog(
                              content: Text(state.errorMessage),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          AppRouter.routeToPage(
                                              const HomeScreen()),
                                          (route) => false);
                                    },
                                    child: Text(
                                      'retry'.toUpperCase(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ))
                              ],
                            ));
                  }
                },
                builder: (context, state) {
                  log(mobileScannerController.events!.isPaused.toString());

                  return MobileScanner(
                      allowDuplicates: false,
                      controller: mobileScannerController,
                      onDetect: (barcode, args) {
                        if (barcode.rawValue == null) {
                          debugPrint('Failed to scan Barcode');
                          Fluttertoast.showToast(msg: 'Failed to scan Barcode');
                        } else {
                          final String code = barcode.rawValue!;
                          Fluttertoast.showToast(msg: 'Barcode found! $code');
                          context
                              .read<GetdoneebycodeCubit>()
                              .getDoneeByCode(code);
                        }
                      });
                },
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.white,
                        )),
                    Row(
                      children: [
                        IconButton(
                          color: Colors.white,
                          icon: ValueListenableBuilder(
                            valueListenable: mobileScannerController.torchState,
                            builder: (context, state, child) {
                              switch (state as TorchState) {
                                case TorchState.off:
                                  return const Icon(Icons.flash_off,
                                      color: Colors.white);
                                case TorchState.on:
                                  if (getDoneeState is GetdoneebycodeLoading) {
                                    mobileScannerController.toggleTorch();
                                  }
                                  return const Icon(Icons.flash_on,
                                      color: Colors.yellow);
                              }
                            },
                          ),
                          iconSize: 32.0,
                          onPressed: () =>
                              mobileScannerController.toggleTorch(),
                        ),
                        IconButton(
                          color: Colors.white,
                          icon: ValueListenableBuilder(
                            valueListenable:
                                mobileScannerController.cameraFacingState,
                            builder: (context, state, child) {
                              switch (state as CameraFacing) {
                                case CameraFacing.front:
                                  return const Icon(Icons.camera_front);
                                case CameraFacing.back:
                                  return const Icon(Icons.camera_rear);
                              }
                            },
                          ),
                          iconSize: 32.0,
                          onPressed: () =>
                              mobileScannerController.switchCamera(),
                        ),
                      ],
                    )

                    //
                  ],
                ),
              ),
              Positioned(
                  top: MediaQuery.of(context).size.height * .2,
                  left: 0,
                  right: 0,
                  child: BlocBuilder<GetdoneebycodeCubit, GetdoneebycodeState>(
                    builder: (context, state) {
                      if (state is GetdoneebycodeLoading) {
                        if (mobileScannerController.torchEnabled == true) {
                          mobileScannerController.toggleTorch();
                        }

                        return SizedBox(
                            height: MediaQuery.of(context).size.height * .5,
                            width: MediaQuery.of(context).size.height * .7,
                            child: const Center(child: PrimaryAppLoader()));
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
