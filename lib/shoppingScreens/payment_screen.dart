import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3F74FF),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Payment',
          style: GoogleFonts.archivoBlack(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF3F74FF),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Summary',
                    style: GoogleFonts.archivoBlack(
                      fontSize: 20,
                      color: const Color(0xFF3F74FF),
                    ),
                  ),
                  const SizedBox(height: 16),
                  paymentItemRow(title: 'Subtotal', value: 'TBC'),
                  paymentItemRow(title: 'Service Fee', value: 'TBC'),
                  paymentItemRow(title: 'Tax (6%)', value: 'TBC'),
                  const Divider(height: 32, thickness: 1),
                  paymentItemRow(
                    title: 'Total',
                    value: 'TBC',
                    isBold: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () {
                    // TODO: Add payment flow
                  },
                  child: Text(
                    'Pay Now',
                    style: GoogleFonts.archivoBlack(
                      fontSize: 18,
                      color: const Color(0xFF3F74FF),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget paymentItemRow({
    required String title,
    required String value,
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.archivoBlack(
              fontSize: 16,
              color: Colors.grey[800],
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.archivoBlack(
              fontSize: 16,
              color: Colors.grey[900],
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
