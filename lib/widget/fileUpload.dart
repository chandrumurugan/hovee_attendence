import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/widget/single_custom_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class FileUpload extends StatefulWidget {
  final void Function(File?) onFilePicked;
  final String title;
  final bool? isProfile;

  FileUpload({
    super.key,
    required this.onFilePicked,
    required this.title,
    this.isProfile,
  });

  @override
  State<FileUpload> createState() => _FileUploadState();
}

class _FileUploadState extends State<FileUpload> {
  File? _pickedFile;
  final ImagePicker _imagePicker = ImagePicker();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _pickedFile = null;
    });
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(

      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', ],
    );

    if (result != null&& result.files.single.path != null) {
      setState(() {
        _pickedFile = File(result.files.single.path!);
      });
    }
  }

  void _pickImageFromCamera() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _pickedFile = File(image.path);
      });
    }
  }

  void _removeFile() {
    setState(() {
      _pickedFile = null;
      // widget.onFilePicked(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // height: 500,
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const SizedBox(
                height: 4.59,
              ),
              Container(
                width: 54,
                height: 10,
                decoration: BoxDecoration(
                    color: Color(0xffD9D9D9),
                    border: const Border(),
                    borderRadius: BorderRadius.circular(25)),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '${widget.title}',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                    fontSize: 20, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              if (widget.isProfile != null && widget.isProfile!)
                Text(
                  "Note: First name,last name and ID proof cannot be edited",
                  style: GoogleFonts.nunito(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(15.0)),
                    ),
                    builder: (BuildContext context) {
                      return Wrap(
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(Icons.attach_file_outlined),
                            title: const Text('Upload from File'),
                            onTap: () {
                              Navigator.pop(context);
                              _pickFile();
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.camera_alt_outlined),
                            title: const Text('Upload from Camera'),
                            onTap: () {
                              Navigator.pop(context);
                              _pickImageFromCamera();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Card(
                  color: Color(0xffD9D9D9),
                  surfaceTintColor: Colors.white,
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Icon(Icons.attach_file_outlined),
                            ),
                          ),
                          Text(
                            'Attachment',
                            style: GoogleFonts.nunito(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.5)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              if (_pickedFile != null)
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            _pickedFile!.path.split('/').last,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.nunito(fontSize: 16),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: _removeFile,
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 30),
              if (_pickedFile != null)
          //           SingleCustomButtom(
          //   btnName: 'Upload',
          //   isPadded: false,
          //   onTap: () {
            //  widget.onFilePicked(_pickedFile);
            //           Navigator.pop(context);
          //   },
          // ),
          Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
                 widget.onFilePicked(_pickedFile);
                      Navigator.pop(context);
            },
            child: Container(
              height: 48,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                gradient: LinearGradient(
                  colors: [Color(0xFFC13584), Color(0xFF833AB4)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                      child: Text(
                       'Upload',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
            ),
          ),
        ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
