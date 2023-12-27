import 'package:flutter/material.dart';
import 'package:mine_app/src/base/enums/snack_bar_type.dart';
import 'package:mine_app/src/core/theme/ui_helpers/ui_helpers.dart';

class BoxSnackBar extends StatelessWidget {
  final String message;
  final SnackBarType type;

  const BoxSnackBar({
    super.key,
    required this.message,
    required this.type,
  });

  const BoxSnackBar.success({
    super.key,
    required this.message,
    this.type = SnackBarType.success,
  });

  const BoxSnackBar.info({
    super.key,
    required this.message,
    this.type = SnackBarType.info,
  });

  const BoxSnackBar.error({
    super.key,
    required this.message,
    this.type = SnackBarType.error,
  });

  const BoxSnackBar.conexaoError({
    super.key,
    this.message = "Verifique a conexão com a rede",
    this.type = SnackBarType.error,
  });

  const BoxSnackBar.warning({
    super.key,
    required this.message,
    this.type = SnackBarType.warning,
  });

  @override
  SnackBar build(BuildContext context) {
    return SnackBar(
      duration: _getDuration(),
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.all(0),
      margin: EdgeInsets.all(10.0.r),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0.r)),
      backgroundColor: _getBackgroundColor(),
      action: SnackBarAction(
        label: "x",
        textColor: colorOnError.withOpacity(0.7),
        onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(reason: SnackBarClosedReason.hide),
      ),
      content: IntrinsicHeight(
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(10.0.r)),
                  color: _getColor(),
                ),
              ),
            ),
            Flexible(
                flex: 2,
                child: SizedBox(
                  width: 15.0.r,
                ),
            ),
            Flexible(
              flex: 2,
              child: Icon(_getIcon(), color: _getColor()),
            ),
            Flexible(
                flex: 2,
                child: SizedBox(
                  width: 15.0.r,
                ),
            ),
            Flexible(
              flex: 30,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.0.r),
                child: UIText.snackbarMessage(message, maxLines: 5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SnackBar getSnackBar(BuildContext context) => build(context);

  Color _getColor() {
    switch (type) {
      case SnackBarType.success:
        return colorSuccess;
      case SnackBarType.info:
        return colorSecondary;
      case SnackBarType.warning:
        return colorError;
      case SnackBarType.error:
        return colorError;
    }
  }

  Duration _getDuration() {
    switch (type) {
      case SnackBarType.success:
        return const Duration(seconds: 2);
      case SnackBarType.info:
        return const Duration(seconds: 5);
      case SnackBarType.warning:
        return const Duration(seconds: 5);
      case SnackBarType.error:
        return const Duration(seconds: 10);
    }
  }

  Color _getBackgroundColor() {
    switch (type) {
      case SnackBarType.success:
        return colorSuccessBackground;
      case SnackBarType.info:
        return colorWarningBackground;
      case SnackBarType.warning:
        return colorWarningBackground;
      case SnackBarType.error:
        return colorErrorBackground;
    }
  }

  IconData _getIcon() {
    switch (type) {
      case SnackBarType.success:
        return Icons.check_circle;
      case SnackBarType.info:
        return Icons.info;
      case SnackBarType.warning:
        return Icons.error;
      case SnackBarType.error:
        return Icons.cancel;
    }
  }
}

void showSnackBar(BuildContext context, BoxSnackBar boxSnackBar) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(boxSnackBar.getSnackBar(context));
}
