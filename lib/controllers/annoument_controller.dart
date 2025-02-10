import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hovee_attendence/modals/addAnnounmentModel.dart';
import 'package:hovee_attendence/modals/delete_announcement_model.dart';
import 'package:hovee_attendence/modals/getAnnounmentBatchList_model.dart';
import 'package:hovee_attendence/modals/getAnnounment_model.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/add_annouments_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnnoumentController extends GetxController {
  var announmentBatchList = <BatchData>[].obs;
  var announmentList = <AnnounmentsData>[].obs;
  var isLoading = true.obs;

  var courseNamesController = ''.obs;
  var batchNamesController = ''.obs; // RxList<String>

  var userNamesController = ''.obs;
  var titleController = ''.obs;
  final title = TextEditingController();
  var courseNames = <String>[].obs;

  var batchNames = <String>[].obs;
  var userNames = <String>[].obs;
  var descriptionController = ''.obs;
  final description = TextEditingController();
  var validationMessages = <String>[].obs;

  final storage = GetStorage();
  var instituteId =''.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAnnounmentsBatchList();
    fetchAnnounmentsList();
    _clearData();
  }



  bool validateFields(BuildContext context) {
    validationMessages.clear();
    if (courseNamesController.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Course name is required',
      );
      return false;
    }
    if (batchNamesController.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Batch name is required');
      return false;
    }
    if (title.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Title type is required',
      );
      return false;
    }
    if (description.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Description is required');
      return false;
    }

    return true;
  }
  void fetchAnnounmentsBatchList() async {
    try {
      isLoading(true);
      var courseResponse = await WebService.fetchAnnounmentsBatchList();
      if (courseResponse.data != null) {
        announmentBatchList.value = courseResponse.data!;

        // Combine className and subject to form "className - subject"
        courseNames.value = courseResponse.data!
            .map((course) {
              final className = course.className ?? '';
              final subject = course.subject ?? '';
              return className.isNotEmpty && subject.isNotEmpty
                  ? '$className - $subject'
                  : className.isNotEmpty
                      ? className
                      : subject; // Handle missing data
            })
            .where((entry) => entry.isNotEmpty) // Filter out empty entries
            .toList();

        // Store the complete course data and courseCode list in GetStorage
        final storage = GetStorage();
        storage.write(
          'courseList',
          courseResponse.data!.map((batch) => batch.courseCode ?? '').toList(),
        );
        storage.write(
            'courseNames', courseNames); // Updated to store combined names
            SharedPreferences prefs = await SharedPreferences.getInstance();
       instituteId.value=   prefs.getString('InstituteId') ?? '';
      } else {
        print('Course data is null');
      }
    } catch (e) {
      print('Error: $e');
      // SnackBarUtils.showSuccessSnackBar(context, 'Failed to fetch course');
    } finally {
      isLoading(false);
    }
  }

  void fetchAnnounmentsList({String searchTerm = ''}) async {
    try {
      isLoading(true);
      var courseResponse = await WebService.fetchAnnounmentsList(searchTerm);
      if (courseResponse.data != null) {
        announmentList.value = courseResponse.data!;
      } else {
        print('Course data is null');
      }
    } catch (e) {
      print('Error: $e');
      //  SnackBarUtils.showSuccessSnackBar(context,'Failed to fetch course');
    } finally {
      isLoading(false);
    }
  }

void addAnnoument(BuildContext context) async {
  if (validateFields(context)) {
    isLoading.value = true;
    try {
      // Find the corresponding course ID for the selected course
      final selectedCourse = announmentBatchList.firstWhereOrNull((batchData) {
        final courseName = '${batchData.className ?? ''} - ${batchData.subject ?? ''}';
        return courseName == courseNamesController.value;
      });

      // Find the corresponding batch for the selected batch
      final selectedBatch = selectedCourse?.batchList?.firstWhereOrNull((batch) {
        return batch.batchName == batchNamesController.value;
      });

      // Check if both course and batch are found
      if (selectedCourse != null && selectedBatch != null) {
        List<String?> studentIds = [];

        if (userNamesController.value.isNotEmpty) {
          // If a specific student is selected, add only that student's ID
          final selectedUser = selectedBatch.userList?.firstWhereOrNull((user) {
            return '${user.studentFirstName} ${user.studentLastName}' == userNamesController.value;
          });

          if (selectedUser != null) {
            studentIds.add(selectedUser.studentId!); // Add the selected student's ID
          }
        } else {
          // If no student is selected, add all student IDs from the batch
          studentIds = selectedBatch.userList?.map((user) => user.studentId).toList() ?? [];
        }

        // Create the payload
        var batchData = {
          "title": title.text,
          "description": description.text,
          "studentId": studentIds, // Pass student IDs as an array
          "courseId": selectedCourse.sId, // Assuming courseCode is the course ID
          "batchId": selectedBatch.sId, // Assuming batchId is the batch ID
           'type': "N",
        };

        final addAnnouncementModel? response =
            await WebService.addAnnoument(batchData);

        if (response != null && response.statusCode == 200) {
          Get.back();
          onInit();
          _clearData();
          SnackBarUtils.showSuccessSnackBar(
            context,
            'Announcement Posted Successfully! Your announcement has been sent to the tutees',
          );
        } else {
          SnackBarUtils.showErrorSnackBar(
              context, response?.message ?? 'Failed to add announcement');
        }
      } else {
        SnackBarUtils.showErrorSnackBar(context, 'Course or Batch not found');
      }
    } catch (e) {
      SnackBarUtils.showErrorSnackBar(context, 'Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

void editAnnoument(BuildContext context,String announcementId) async {
  if (validateFields(context)) {
    isLoading.value = true;
    try {
      // Find the corresponding course ID for the selected course
      final selectedCourse = announmentBatchList.firstWhereOrNull((batchData) {
        final courseName = '${batchData.className ?? ''} - ${batchData.subject ?? ''}';
        return courseName == courseNamesController.value;
      });

      // Find the corresponding batch for the selected batch
      final selectedBatch = selectedCourse?.batchList?.firstWhereOrNull((batch) {
        return batch.batchName == batchNamesController.value;
      });

      // Check if both course and batch are found
      if (selectedCourse != null && selectedBatch != null) {
        List<String?> studentIds = [];

        if (userNamesController.value.isNotEmpty) {
          // If a specific student is selected, add only that student's ID
          final selectedUser = selectedBatch.userList?.firstWhereOrNull((user) {
            return '${user.studentFirstName} ${user.studentLastName}' == userNamesController.value;
          });

          if (selectedUser != null) {
            studentIds.add(selectedUser.studentId!); // Add the selected student's ID
          }
        } else {
          // If no student is selected, add all student IDs from the batch
          studentIds = selectedBatch.userList?.map((user) => user.studentId).toList() ?? [];
        }

        // Create the payload
        var batchData = {
          "title": title.text,
          "description": description.text,
          "studentId": studentIds, // Pass student IDs as an array
          "courseId": selectedCourse.sId, // Assuming courseCode is the course ID
          "batchId": selectedBatch.sId,
           'type': "U",
          'announcementId':announcementId, // Assuming batchId is the batch ID
        };

        final addAnnouncementModel? response =
            await WebService.addAnnoument(batchData);

        if (response != null && response.statusCode == 200) {
          Get.back();
          onInit();
          _clearData();
          SnackBarUtils.showSuccessSnackBar(
            context,
            'Announcement updated successfully',
          );
        } else {
          SnackBarUtils.showErrorSnackBar(
              context, response?.message ?? 'Failed to update announcement');
        }
      } else {
        SnackBarUtils.showErrorSnackBar(context, 'Course or Batch not found');
      }
    } catch (e) {
      SnackBarUtils.showErrorSnackBar(context, 'Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

void deleteAnnouncement(BuildContext context, String batchId,courseId,announcementId) async {
    isLoading.value = true;
    try {
      var batchData = {
        "courseId": courseId, // Assuming courseCode is the course ID
          "batchId": batchId,
           'type': "D",
      };

      final DeleteAnnouncementModel? response =
          await WebService.deleteAnnouncement(batchData);

      if (response != null && response.statusCode == 200) {
         announmentList.removeWhere((item) => item.announcementId == announcementId);

      // Notify listeners about the updated list
      announmentList.refresh(); 
       Get.snackbar(
          'Announcement deleted successfully',
  icon: const Icon(Icons.check_circle, color: Colors.white, size: 40),
  colorText: Colors.white,
  backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
  shouldIconPulse: false,
  messageText: const SizedBox(
    height: 40, // Set desired height here
    child: Center(
      child: Text(
        'Announcement deleted successfully',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  ),
);
        //  Get.snackbar(icon: Icon(Icons.check_circle,color: Colors.white,size: 40,)
        // ,'Announcement deleted successfully',colorText: Colors.white,backgroundColor: Color.fromRGBO(186, 1, 97, 1),);
      // SnackBarUtils.showSuccessSnackBar(context, 'Holiday delete successfully');
        //  Get.back();
        //  onInit();
      } else {
         Get.snackbar(
          response?.message ?? 'Failed to deleted announcement',
  icon: const Icon(Icons.info, color: Colors.white, size: 40),
  colorText: Colors.white,
  backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
  shouldIconPulse: false,
  messageText:  SizedBox(
    height: 40, // Set desired height here
    child: Center(
      child: Text(
        response?.message ?? 'Failed to deleted announcement',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  ),
);
    // Get.snackbar(icon: Icon(Icons.info,color: Colors.white,size: 40,),response?.message ?? 'Failed to deleted announcement',colorText: Colors.white,backgroundColor: Color.fromRGBO(186, 1, 97, 1),);
      }
    } catch (e) {
        Get.snackbar(
          'Error: $e',
  icon: const Icon(Icons.info, color: Colors.white, size: 40),
  colorText: Colors.white,
  backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
  shouldIconPulse: false,
  messageText:  SizedBox(
    height: 40, // Set desired height here
    child: Center(
      child: Text(
       'Error: $e',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  ),
);
       //Get.snackbar(icon: Icon(Icons.info,color: Colors.white,size: 40,), 'Error: $e',colorText: Colors.white,backgroundColor: Color.fromRGBO(186, 1, 97, 1),);
    } finally {
      isLoading.value = false;
    }
  }



  // Function to set selected course and filter batch names
  void setCourse(String selectedCourse) {
    courseNamesController.value = selectedCourse;

    // Find the corresponding BatchData for the selected course
    final selectedBatch = announmentBatchList.firstWhereOrNull((batch) {
      final courseName = '${batch.className ?? ''} - ${batch.subject ?? ''}';
      return courseName == selectedCourse;
    });

    // Update batch names if found
    if (selectedBatch != null && selectedBatch.batchList != null) {
      batchNames.value = selectedBatch.batchList!
          .map((batch) => batch.batchName ?? '')
          .where((name) => name.isNotEmpty)
          .toList();
    } else {
      batchNames.clear(); // Clear if no matching batches
    }
  }

  // Function to set selected batch and filter students
  void setBatch(String selectedBatch) {
    batchNamesController.value = selectedBatch;

    // Find the corresponding BatchList for the selected batch
    final selectedBatchData = announmentBatchList
        .expand((batchData) => batchData.batchList ?? [])
        .firstWhereOrNull((batch) => batch.batchName == selectedBatch);

    // Update student names if found
    if (selectedBatchData != null && selectedBatchData.userList != null) {
      userNames.value = selectedBatchData.userList!
          .map<String>((user) =>
              '${user.studentFirstName ?? ''} ${user.studentLastName ?? ''}')
          .toList();
    } else {
      userNames.clear(); // Clear if no matching students
    }
  }

// Function to set selected student
  void setStudent(String selectedStudent) {
    userNamesController.value = selectedStudent;
  }

    void _clearData() {
    batchNamesController.value = '';
    courseNamesController.value='';
    userNamesController.value = '';
    title.clear();
    description.clear();
  }

  
  void navigateToAddBatchScreen() {
    Get.to(() => AddAnnoumentsScreen());
  }
}
