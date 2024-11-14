import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class KeyboardActionsUtils {
  static KeyboardActionsConfig getKeyboardActionsConfig(FocusNode focusNode, TextInputType keyboardType) {
    if (keyboardType == TextInputType.number || keyboardType == TextInputType.numberWithOptions()) {
      return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        keyboardBarColor: const Color(0xFFCAD1D9), // Apple keyboard color
        actions: [
          KeyboardActionsItem(
            focusNode: focusNode,
            toolbarButtons: [
              (node) {
                return GestureDetector(
                  onTap: () => node.unfocus(),
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    child: const Text(
                      'Done', // You can replace this with localized text if needed
                      style: TextStyle(
                        color: Color(0xFF0978ED), // Done button color
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }
            ],
          ),
        ],
      );
    } else {
      return KeyboardActionsConfig(actions: []); // No action for other keyboards
    }
  }
}
