import 'package:flutter/material.dart';

enum GiftAidOptions {
  enabled,
  notEnabled,
}

class EnableGiftAidOption extends StatefulWidget {
  const EnableGiftAidOption({Key? key}) : super(key: key);

  @override
  State<EnableGiftAidOption> createState() => _EnableGiftAidOptionState();
}

class _EnableGiftAidOptionState extends State<EnableGiftAidOption> {
  GiftAidOptions? _aidOptions = GiftAidOptions.enabled;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            ListTile(
              title: const Text(
                  'Yes, I’d like to enable GiftAid on eligible donations.*'),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  '*By enabling GiftAid on my donations, I confirm that I am a UK taxpayer and understand that if I pay less Income Tax and/or Capital Gains Tax in the current tax year than the amount of Gift Aid claimed on all my donations it is my responsibility to pay any difference.',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 12,
                      ),
                ),
              ),
              leading: Radio<GiftAidOptions>(
                groupValue: _aidOptions,
                value: GiftAidOptions.enabled,
                onChanged: (GiftAidOptions? value) {
                  setState(() {
                    _aidOptions = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('No, thank you.'),
              leading: Radio<GiftAidOptions>(
                groupValue: _aidOptions,
                value: GiftAidOptions.notEnabled,
                onChanged: (GiftAidOptions? value) {
                  setState(() {
                    _aidOptions = value;
                  });
                },
              ),
            )
          ],
        ));
  }
}
