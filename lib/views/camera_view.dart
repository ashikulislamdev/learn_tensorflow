import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:learn_tensorflow/controllers/scan_controller.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  FlutterTts flutterTts = FlutterTts();

  // late Timer timer;

  // @override
  // void initState() {
  //   super.initState();
  //   timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => letSpeak());
  // }

  // @override
  // void dispose() {
  //   timer.cancel();
  //   super.dispose();
  // }

  // void letSpeak(String text) async {
  //   await flutterTts.speak(text);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Detector"),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
      ),
      body: GetBuilder<ScanController>(
        init: ScanController(),
        builder: (controller) {
          return controller.isCameraInitialized.value
              ? Stack(
                  children: [
                    CameraPreview(controller.cameraController),
                    controller.label != ""
                        ? Positioned(
                            top: MediaQuery.of(context).size.height / 2,
                            right: MediaQuery.of(context).size.width / 2,
                            child: Container(
                              padding: const EdgeInsetsDirectional.all(2),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: Colors.green),
                                  borderRadius: BorderRadius.circular(8)),
                              child: GestureDetector(
                                onTap: () async {
                                  await flutterTts.speak(controller.label);
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      controller.label,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 24),
                                    ),
                                    const SizedBox(width: 4),
                                    const ImageIcon(
                                      AssetImage("assets/images/soundl.png"),
                                      size: 30,
                                      color: Colors.deepPurple,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    Positioned(
                        top: 12,
                        right: 12,
                        child: Text("${controller.persentage} %"))
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
