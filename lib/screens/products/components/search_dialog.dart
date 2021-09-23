import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 2,
          left: 4,
          right: 4,
          child: Card(
            child: TextFormField(
              autofocus: true,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                prefixIcon: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back),
                  color: Colors.grey[700],
                ),
              ),
              onFieldSubmitted: (text) {
                Navigator.of(context).pop(text);
              },
            ),
          ),
        ),
      ],
    );
  }
}
