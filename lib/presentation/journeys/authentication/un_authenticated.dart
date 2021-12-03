import 'package:flutter/material.dart';
import 'package:idonatio/common/assest.dart';
import 'package:idonatio/common/route_list.dart';
import 'package:idonatio/common/words.dart';

class UnAuthenticated extends StatelessWidget {
  const UnAuthenticated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData screenData = MediaQuery.of(context);
    double screenWidth = screenData.size.width;
    return Scaffold(
      body: SafeArea  (
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 3 / 4,
              child: Stack(
                children: [
                  Container(
                    constraints: const BoxConstraints.expand(),
                    color: Colors.black,
                    child: Image.asset(
                      AppAssest.unAuthenticatedBanner,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        transform: GradientRotation(237.52),
                        begin: Alignment.topLeft,
                        colors: [
                          Colors.white,
                          Color.fromRGBO(255, 255, 255, 0),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth * .6,
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(AppAssest.logo),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                            'Connecting cheerful givers to the people and organisations they care about...')
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, RouteList.register),
                  child: Text(TranslationConstants.register.toUpperCase()),
                ),
                const SizedBox(
                  height: 16,
                ),
                OutlinedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, RouteList.login),
                  child: Text(TranslationConstants.signin.toUpperCase()),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
