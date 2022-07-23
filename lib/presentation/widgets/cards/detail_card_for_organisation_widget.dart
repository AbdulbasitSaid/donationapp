import 'package:flutter/material.dart';
import 'package:idonatio/presentation/widgets/donee_logo_widget.dart';

import '../../themes/app_color.dart';

class DetailCardForOrganisationWidget extends StatelessWidget {
  const DetailCardForOrganisationWidget({
    Key? key,
    required this.name,
    this.address,
    required this.id,
    this.imageUrl,
  }) : super(key: key);
  final String? name;
  final String? address;
  final String id;
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DoneeLogoWidget(
            imageUrl: imageUrl,
          ),
          const SizedBox(
            width: 16,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                Text(
                  '$name',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 16,
                        color: AppColor.text90Primary,
                      ),
                ),
                const SizedBox(
                  height: 8,
                ),
                // address
                Text(
                  '$address',
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 8,
                ),
                // donee id
                Text(
                  'Donee ID: $id',
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          const Icon(
            Icons.verified_outlined,
            color: AppColor.darkSecondaryGreen,
          ),
        ],
      ),
    );
  }
}

class DetailCardForIndividualWidget extends StatelessWidget {
  const DetailCardForIndividualWidget({
    Key? key,
    this.name,
    this.address,
    required this.id,
    this.imageUrl,
  }) : super(key: key);
  final String? name;
  final String? address;
  final String id;
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DoneeLogoWidget(
            imageUrl: imageUrl,
          ),
          const SizedBox(
            width: 16,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                Text(
                  '$name',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 16,
                        color: AppColor.text90Primary,
                      ),
                ),
                const SizedBox(
                  height: 8,
                ),
                // address
                Text(
                  '$address',
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 8,
                ),
                // donee id
                Text(
                  'Donee ID: $id',
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          const Icon(
            Icons.verified_outlined,
            color: AppColor.darkSecondaryGreen,
          ),
        ],
      ),
    );
  }
}
