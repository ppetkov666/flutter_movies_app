import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/core/providers/error_message_provider.dart';
import 'package:movies_app/domain/entities/failure.dart';

class MovieErrorModal extends StatelessWidget {
  const MovieErrorModal({super.key});

  void _closeError(BuildContext context) {
    Provider.of<ErrorMessageProvider>(context, listen: false).setModalError(null);
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ErrorMessageProvider, Failure?>(
      selector: (_, provider) => provider.modalError,
      builder: (_, error, __) {
        if (error == null) return const SizedBox.shrink();

        return Stack(
          children: [
            const ModalBarrier(dismissible: false, color: Colors.black54),
            Center(
              child: AlertDialog(
                title: const Text('Error'),
                content: Text(error.message),
                actions: [
                  TextButton(
                    onPressed: () => _closeError(context),
                    child: const Text('Close'),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
