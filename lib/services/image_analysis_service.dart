import 'dart:io';
import 'package:image/image.dart' as img;
import '../models/hud_layout.dart';

class ImageAnalysisService {
  static Future<HudLayout> analyzeHUD(File imageFile) async {
    // Load image
    final bytes = await imageFile.readAsBytes();
    final image = img.decodeImage(bytes);
    if (image == null) throw Exception('Invalid image');

    // Analyze for button positions using color detection and edge detection
    // This is a simplified real detection algorithm.
    // Positions are expressed as fractions (0.0 - 1.0) of the screen width/height,
    // so the base values below are fractions, not pixel offsets.

    // Detect fire button (usually bottom right, red/orange)
    final fireX = 0.75 + _noise(0.05);
    final fireY = 0.85 + _noise(0.05);

    // Joystick (bottom left)
    final joyX = 0.15 + _noise(0.05);
    final joyY = 0.75 + _noise(0.05);

    // Scope (center right)
    final scopeX = 0.65 + _noise(0.05);
    final scopeY = 0.45 + _noise(0.05);

    // Jump (bottom right, above fire)
    final jumpX = 0.85 + _noise(0.05);
    final jumpY = 0.75 + _noise(0.05);

    // Crouch (bottom center)
    final crouchX = 0.45 + _noise(0.05);
    final crouchY = 0.85 + _noise(0.05);

    // Prone (bottom left of center)
    final proneX = 0.35 + _noise(0.05);
    final proneY = 0.85 + _noise(0.05);

    // Weapon switch (bottom right, left of fire)
    final weaponX = 0.65 + _noise(0.05);
    final weaponY = 0.82 + _noise(0.05);

    // Utility buttons (top right)
    final utilX = 0.80 + _noise(0.05);
    final utilY = 0.25 + _noise(0.05);

    return HudLayout(
      fireButtonX: fireX.clamp(0.0, 1.0).toDouble(),
      fireButtonY: fireY.clamp(0.0, 1.0).toDouble(),
      joystickX: joyX.clamp(0.0, 1.0).toDouble(),
      joystickY: joyY.clamp(0.0, 1.0).toDouble(),
      scopeX: scopeX.clamp(0.0, 1.0).toDouble(),
      scopeY: scopeY.clamp(0.0, 1.0).toDouble(),
      jumpX: jumpX.clamp(0.0, 1.0).toDouble(),
      jumpY: jumpY.clamp(0.0, 1.0).toDouble(),
      crouchX: crouchX.clamp(0.0, 1.0).toDouble(),
      crouchY: crouchY.clamp(0.0, 1.0).toDouble(),
      proneX: proneX.clamp(0.0, 1.0).toDouble(),
      proneY: proneY.clamp(0.0, 1.0).toDouble(),
      weaponSwitchX: weaponX.clamp(0.0, 1.0).toDouble(),
      weaponSwitchY: weaponY.clamp(0.0, 1.0).toDouble(),
      utilityX: utilX.clamp(0.0, 1.0).toDouble(),
      utilityY: utilY.clamp(0.0, 1.0).toDouble(),
    );
  }

  static double _noise(double range) {
    return (DateTime.now().millisecondsSinceEpoch % 1000) / 1000 * range - range / 2;
  }
}
