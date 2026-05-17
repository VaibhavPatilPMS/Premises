import 'package:flutter/cupertino.dart';
import 'package:premises/common/widgets/widgets.dart';

class CommonErrorWidget extends StatelessWidget {
  final String? errorMessage;

  const CommonErrorWidget({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText.smallGreyG1Regular(errorMessage, isCenter: true),
      ],
    );
  }
}
