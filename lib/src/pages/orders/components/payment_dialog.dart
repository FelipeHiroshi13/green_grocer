import 'package:flutter/material.dart';
import 'package:greengrocer/src/services/utils_services.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../models/order_model.dart';

class PaymentDialog extends StatelessWidget {
  final OrderModel order;

  PaymentDialog({Key? key, required this.order}) : super(key: key);

  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Pagamento com Pix',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                //QR Code
                QrImage(
                  data: "00020126400014br.gov.bcb.pix0111040991231030203Pix52040000530398654040.015802BR5920FELIPE HIROSHI BARON6012CAMPO GRANDE62290525Eqdmgrl8hyObzKq27otjkHSN36304493C",
                  version: QrVersions.auto,
                  size: 200.0,
                ),

                //Vencimento
                Text(
                  'Vencimento: ${utilsServices.formatDateTime(order.overdueDateTime)}',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),

                //Total
                Text(
                  'Total: ${utilsServices.priceToCurrency(order.total)}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Botão copia e cola
                OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        side: const BorderSide(
                          width: 2,
                          color: Colors.green,
                        )),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.copy,
                      size: 15,
                    ),
                    label: const Text(
                      'Copiar código Pix',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ))
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
