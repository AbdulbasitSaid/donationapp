import 'package:flutter/material.dart';
import 'package:idonatio/common/route_list.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';

class VerifyLoginScreen extends StatelessWidget {
  const VerifyLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: AppBackgroundWidget(
          childWidget: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 4 / 1,
                  child: Text(
                    'Verify login',
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  'Enter verification code',
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'For your security, we have sent a verification message to your email address.Click the link in the message to verify your email or enter the 6-digit code we sent you below.',
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Flexible(
                        child: TextField(
                      keyboardType: TextInputType.number,
                      // maxLength: 1,
                      // maxLines: 1,
                    )),
                     SizedBox(width: 8,),
                    Flexible(
                        child: TextField(
                      keyboardType: TextInputType.number,
                    )),
                    Flexible(
                        child: TextField(
                      keyboardType: TextInputType.number,
                    )),
                    Flexible(
                        child: TextField(
                      keyboardType: TextInputType.number,
                    )),
                    Flexible(
                        child: TextField(
                      keyboardType: TextInputType.number,
                    )),
                    Flexible(
                        child: TextField(
                      keyboardType: TextInputType.number,
                    )),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  children: const [
                    Flexible(
                      child: Icon(
                        Icons.restart_alt,
                        color: AppColor.basePrimary,
                      ),
                    ),
                    Text(
                      'Resend code',
                      style: TextStyle(color: AppColor.basePrimary),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Please allow a few minutes for delivery and check the Junk / Spam folder of your email inbox before requesting a new code.',
                ),
                const SizedBox(
                  height: 32,
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, RouteList.home),
                  child: const Text('Verify Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
