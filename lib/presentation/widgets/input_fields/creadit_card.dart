import 'package:flutter/material.dart';

class CreaditCard extends StatelessWidget {
  const CreaditCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.payment,
            ),
            hintText: 'Card number',
            labelText: 'Card number',
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          children: [
            Flexible(
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Expiry',
                  labelText: 'Expiry',
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Flexible(
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'CVC',
                  labelText: 'CVC',
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Flexible(
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Postcode',
                  labelText: 'Postcode',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
