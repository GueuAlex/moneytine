import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class SendMail {
  final smtpServer = gmail('your-email@gmail.com', 'your-password');

  void sendAutomaticEmails({
    required List<DateTime> dates,
    required String to,
    required String subject,
    required String body,
  }) async {
    // Configure le serveur SMTP pour l'envoi des e-mails

    // Parcours chaque date dans la liste
    for (var date in dates) {
      // Vérifie si la date est future
      if (date.isAfter(DateTime.now())) {
        // Crée le message d'e-mail
        final message = Message()
          ..from = Address('your-email@gmail.com', 'Your Name')
          ..recipients.add('recipient-email@example.com')
          ..subject = 'Subject of the Email'
          ..text = 'Body of the Email';

        try {
          // Envoie l'e-mail
          final sendReport = await send(message, smtpServer);

          //print('Email sent successfully for date: $date');
          //print('Response: ${sendReport.toString()}');
        } catch (e) {
          // print('Failed to send email for date: $date');
          //print('Error: $e');
        }
      }
    }
  }
}
