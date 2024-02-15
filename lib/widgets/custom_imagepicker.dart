import 'dart:io';

import 'package:eschool/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../core/utils/image_constant.dart';
import '../core/utils/size_utils.dart';

class CustomImagePicker extends StatefulWidget {
  final double size;
  final Function(File) onImageSelected;
  String? currentImage;

  CustomImagePicker({
    Key? key,
    required this.size,
    required this.onImageSelected,
    this.currentImage,
  }) : super(key: key);

  @override
  _CustomImagePickerState createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  @override
  void initState() {
    super.initState();
    if (widget.currentImage != null) {
      _image = File(widget.currentImage!);
    }
  }

  Future<void> _getImageFromCamera() async {
    final image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image.path);
        widget.onImageSelected(_image!);
        widget.currentImage = "";
      });
    }
  }

  Future<void> _getImageFromGallery() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
        widget.onImageSelected(_image!);
        widget.currentImage = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: widget.size * 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: _getImageFromCamera,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Icon(Icons.camera_alt),
                            SizedBox(width: 16),
                            Text("Take a photo"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: _getImageFromGallery,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Icon(Icons.image),
                            SizedBox(width: 16),
                            Text("Choose from gallery"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        height: widget.size,
        width: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade200,
        ),
        child: widget.currentImage == "" && _image != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.file(
                  _image!,
                  fit: BoxFit.cover,
                ),
              )
            : widget.currentImage != null && widget.currentImage != ""
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      widget.currentImage!,
                      fit: BoxFit.cover,
                    ),
                  )
                : Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                      ),
                      CustomImageView(
                        svgPath: ImageConstant.imgUploadbutton,
                        height: getVerticalSize(31),
                        width: getHorizontalSize(32),
                        alignment: Alignment.bottomRight,
                        margin: getMargin(right: 3),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: widget.size * 2,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: _getImageFromCamera,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Row(
                                            children: [
                                              Icon(Icons.camera_alt),
                                              SizedBox(width: 16),
                                              Text("Take a photo"),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: _getImageFromGallery,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Row(
                                            children: [
                                              Icon(Icons.image),
                                              SizedBox(width: 16),
                                              Text("Choose from gallery"),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
      ),
    );
  }
}
