import 'package:flutter/material.dart';
import 'package:idonatio/presentation/journeys/new_donation/donee_confirmatoin.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/labels/base_label_text.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';

class AddDoneeByIdScreen extends StatelessWidget {
  const AddDoneeByIdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: AppColor.appBackground,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Level2Headline(text: 'Add donee by ID'),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Enter the ID code shared by your donee below.',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(
              height: 16,
            ),
            const BaseLabelText(text: 'Donee ID'),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.tag),
                hintText: '425A70',
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () => Navigator.push(context,
                        AppRouter.routeToPage(const DoneeConfirmationScreen())),
                    child: Row(
                      children: [
                        Text(
                          'continue'.toUpperCase(),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Icon(Icons.arrow_right_alt_outlined)
                      ],
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
