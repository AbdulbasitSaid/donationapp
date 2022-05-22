import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/presentation/journeys/saved_donees/add_new_donee_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../router/app_router.dart';
import '../../widgets/loaders/primary_app_loader_widget.dart';
import '../home.dart';
import '../new_donation/cubit/getdoneebycode_cubit.dart';
import '../new_donation/donation_details.dart';
import '../user/cubit/user_cubit.dart';
import 'saved_donee_details.dart';

class SaveDoneeAddByQrCodeScreen extends StatefulWidget {
  const SaveDoneeAddByQrCodeScreen({Key? key}) : super(key: key);

  @override
  _SaveDoneeAddByQrCodeScreenState createState() =>
      _SaveDoneeAddByQrCodeScreenState();
}

class _SaveDoneeAddByQrCodeScreenState
    extends State<SaveDoneeAddByQrCodeScreen> {
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
      body: SizedBox(
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
                    AppRouter.routeToPage(const AddNewDoneeScreen()),
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
                                        AppRouter.routeToPage(const HomeScreen(
                                          pageIndex: 2,
                                        )),
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
                        debugPrint('Failed to scan Qr');
                        Fluttertoast.showToast(msg: 'Failed to scan QR code');
                      } else {
                        final String code = barcode.rawValue!;
                        Fluttertoast.showToast(msg: 'found! $code');
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
                        onPressed: () => mobileScannerController.toggleTorch(),
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
                        onPressed: () => mobileScannerController.switchCamera(),
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
    );
  }
}
