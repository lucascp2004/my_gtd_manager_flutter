import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';

class NotesWidget extends StatelessWidget {
  const NotesWidget({
    super.key,
    this.borderside,
    this.readOnly,
    required this.notesInput,
  });
  final BorderSide? borderside;
  final bool? readOnly;
  final TextEditingController notesInput;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.notes, textAlign: TextAlign.center),
        const SizedBox(width: 3),
        Flexible(
          child: TextField(
            readOnly: (readOnly == null) ? false : readOnly!,
            maxLength: 900,
            controller: notesInput,
            maxLines: 3,
            decoration: InputDecoration(
              // Removes the underline
              border: OutlineInputBorder(
                // Defines the style of the border
                borderSide: (borderside == null)
                    ? const BorderSide(
                        color: Colors.grey, // Border color
                        width: 1.0, // Border width
                      )
                    : borderside!,
                // You can also customize the border radius
                borderRadius: BorderRadius.circular(
                  5.0,
                ), // Border corner radius
              ),
              // Sets a filled background
              filled: true,
              // Sets the fill color to white
              fillColor: Colors.white,
              // Optionally, you can add padding inside the TextField
              // by using contentPadding
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 10.0,
              ),
            ),
            // To further customize the appearance, such as the cursor color, you can add:
            cursorColor: Colors.black, // or any color you prefer
          ),
        ),
      ],
    );
  }
}
