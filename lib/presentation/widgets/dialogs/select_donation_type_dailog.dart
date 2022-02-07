import 'package:flutter/material.dart';
import 'package:idonatio/presentation/themes/app_color.dart';

class AddDonationTypeDailog extends StatelessWidget {
  const AddDonationTypeDailog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              'Add donation type',
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: AppColor.text90Primary,
                    fontSize: 16,
                  ),
            ),
            margin: const EdgeInsets.only(bottom: 16),
          ),
          const Divider(),
        ],
      ),
      actions: [
        Column(
          children: [
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: Text(
                      'Cancel'.toUpperCase(),
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
                          ),
                    )),
                TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: Text(
                      'OK'.toUpperCase(),
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
                          ),
                    )),
              ],
            )
          ],
        )
      ],
      // content: BlocBuilder<DonationProcessCubit, List<DonationTypeEntity>>(
      //   builder: (context, state) {
      //     return SizedBox(
      //       height: MediaQuery.of(context).size.height * .4,
      //       width: MediaQuery.of(context).size.height * .3,
      //       child: ListView.builder(
      //         itemBuilder: (context, index) => Container(
      //           margin: const EdgeInsets.only(
      //             bottom: 16,
      //           ),
      //           child: Row(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             children: [
      //               Column(
      //                 mainAxisAlignment: MainAxisAlignment.start,
      //                 children: [
      //                   Checkbox(
      //                       value: state[index].selected,
      //                       onChanged: (value) {
      //                         context
      //                             .read<DonationProcessCubit>()
      //                             .updateDonationTypeEntity(
      //                               state[index].copyWith(
      //                                   selected: value, fundAmount: 0),
      //                             );
      //                       }),
      //                 ],
      //               ),
      //               Flexible(
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text(
      //                       state[index].name,
      //                       style:
      //                           Theme.of(context).textTheme.bodyText1!.copyWith(
      //                                 fontSize: 16,
      //                                 color: AppColor.text80Primary,
      //                               ),
      //                     ),
      //                     const SizedBox(
      //                       height: 8,
      //                     ),
      //                     Text(
      //                       state[index].description,
      //                       style:
      //                           Theme.of(context).textTheme.bodyText1!.copyWith(
      //                                 fontSize: 12,
      //                                 color: AppColor.text70Primary,
      //                               ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //         itemCount: state.length,
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
