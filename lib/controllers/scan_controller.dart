import 'package:camera/camera.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanController extends GetxController {
  @override
  void onInit() {
    initializeCamera();
    super.onInit();
    initTflite();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  late CameraController cameraController;
  late List<CameraDescription> cameras; //

  var isCameraInitialized = false.obs;
  var cameraCount = 0;

  //initialize our camera
  initializeCamera() async {
    //check the user give the permission for camera or not
    if (await Permission.camera.request().isGranted) {
      cameras = await availableCameras(); // all available cameras

      cameraController = CameraController(cameras[0],
          ResolutionPreset.max); //cameras[0] means back camera and 1 means font

      await cameraController.initialize().then((value) {
        cameraController.startImageStream((image) {
          cameraCount++;
          if (cameraCount % 10 == 0) {
            cameraCount = 0;
            objectDetector(image);
          }
          update();
        });
      });

      isCameraInitialized(true);

      update();
    } else {
      print("Permission denide");
    }
  }

  //initialize TFLite
  initTflite() async {
    await Tflite.loadModel(
      model: "assets/models/mobilenet.tflite",
      labels: "assets/models/mobilenet.txt",
      isAsset: true,
      numThreads: 1,
      useGpuDelegate: false,
    );
  }

  //detector method
  objectDetector(CameraImage image) async {
    var detector = await Tflite.runModelOnFrame(
      bytesList: image.planes.map((e) {
        return e.bytes;
      }).toList(),
      asynch: true,
      imageHeight: image.height,
      imageWidth: image.width,
      imageMean: 127.5,
      imageStd: 127.5,
      numResults: 1,
      rotation: 90,
      threshold: 0.4,
    );
    if (detector != null) {
      print("Result is $detector");
    }
  }
}
