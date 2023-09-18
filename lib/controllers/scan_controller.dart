import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanController extends GetxController {
  @override
  void onInit() {
    initializeCamera();
    super.onInit();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  late CameraController cameraController;
  late List<CameraDescription> cameras; //

  var isCameraInitialized = false.obs;

  //initialize our camera
  initializeCamera() async {
    //check the user give the permission for camera or not
    if (await Permission.camera.request().isGranted) {
      cameras = await availableCameras(); // all available cameras

      cameraController = CameraController(cameras[0],
          ResolutionPreset.max); //cameras[0] means back camera and 1 means font
      await cameraController.initialize();

      isCameraInitialized(true);

      update();
    } else {
      print("Permission denide");
    }
  }
}
