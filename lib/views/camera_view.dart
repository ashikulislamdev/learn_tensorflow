import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_tensorflow/controllers/scan_controller.dart';

class CameraView extends StatelessWidget {
  const CameraView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ScanController>(
        init: ScanController(),
        builder: (controller) {
          return controller.isCameraInitialized.value
              ? Stack(
                  children: [
                    CameraPreview(controller.cameraController),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 2 - 8,
                      right: MediaQuery.of(context).size.width / 2 - 8,
                      child: Container(
                        padding: const EdgeInsetsDirectional.all(2),
                        decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.green),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          controller.label,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 24),
                        ),
                      ),
                    )
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
