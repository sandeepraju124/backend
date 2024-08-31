// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:backendapp/provider/businessmongo_provider.dart';
// import 'package:backendapp/utils/constants.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';

// class AddPhotos extends StatefulWidget {
//   @override
//   State<AddPhotos> createState() => _AddPhotosState();
// }

// class _AddPhotosState extends State<AddPhotos> {
//   List<File> _images = [];
//   bool _isLoading = false;

//   void uploadImage() async {
//     setState(() {
//       _isLoading = true;
//     });
//     String businessUid = await getBusinessUid(context);
//     bool isSuccess = await Provider.of<ServicesProvider>(context, listen: false)
//         .uploadImagesToServer(_images, businessUid);
//     if (isSuccess) {
//       setState(() {
//         _images.clear();
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Images uploaded successfully"),
//           backgroundColor: Colors.black54,
//           behavior: SnackBarBehavior.floating,
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Failed to upload images"),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//     setState(() {
//       _isLoading = false;
//     });
//   }

//   Future<void> multiImagePick() async {
//     List<XFile> pickedFiles = await ImagePicker().pickMultiImage();
//     setState(() {
//       _images.addAll(pickedFiles.map((file) => File(file.path)).toList());
//     });
//   }

//   void removeImage(int index) {
//     setState(() {
//       _images.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var data = Provider.of<ServicesProvider>(context);
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text(
//           'Add Photos',
//           style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
//         ),
//         backgroundColor: tgPrimaryColor,
//         elevation: 0,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(Icons.keyboard_arrow_left_rounded)),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               flex: 3,
//               child: _buildImagePickerSection(),
//             ),
//             Expanded(
//               flex: 7,
//               child: _buildExistingImagesSection(data),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: _buildUploadButton(),
//     );
//   }

//   Widget _buildImagePickerSection() {
//     return Container(
//       margin: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               "Add New Photos",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Expanded(
//             child: _images.isEmpty
//                 ? _buildAddPhotoButton()
//                 : _buildSelectedImagesGrid(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAddPhotoButton() {
//     return InkWell(
//       onTap: multiImagePick,
//       child: DottedBorder(
//         borderType: BorderType.RRect,
//         radius: Radius.circular(12),
//         color: tgAccentColor,
//         strokeWidth: 2,
//         dashPattern: [8, 4],
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.add_photo_alternate,
//                   size: 40, color: Colors.teal.shade800),
//               SizedBox(height: 8),
//               Text("Add Photos", style: TextStyle(color: tgAccentColor)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSelectedImagesGrid() {
//     return GridView.builder(
//       padding: EdgeInsets.all(8),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         crossAxisSpacing: 8,
//         mainAxisSpacing: 8,
//       ),
//       itemCount: _images.length + 1,
//       itemBuilder: (context, index) {
//         if (index == _images.length) {
//           return _buildAddMoreButton();
//         }
//         return _buildImageTile(index);
//       },
//     );
//   }

//   Widget _buildAddMoreButton() {
//     return InkWell(
//       onTap: multiImagePick,
//       child: DottedBorder(
//         borderType: BorderType.RRect,
//         radius: Radius.circular(12),
//         color: tgAccentColor,
//         strokeWidth: 2,
//         dashPattern: [8, 4],
//         child: Center(
//           child: Icon(Icons.add, color: tgAccentColor),
//         ),
//       ),
//     );
//   }

//   Widget _buildImageTile(int index) {
//     return Stack(
//       children: [
//         ClipRRect(
//           borderRadius: BorderRadius.circular(12),
//           child: Image.file(
//             _images[index],
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//         ),
//         Positioned(
//           top: 4,
//           right: 4,
//           child: InkWell(
//             onTap: () => removeImage(index),
//             child: Container(
//               padding: EdgeInsets.all(4),
//               decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(0.5),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(Icons.close, color: Colors.white, size: 16),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildExistingImagesSection(ServicesProvider data) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(30),
//           topRight: Radius.circular(30),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Text(
//               "Existing Images (${data.BusinessData?.images?.length ?? 0})",
//               style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Expanded(
//             child: data.BusinessData?.images != null &&
//                     data.BusinessData!.images!.isNotEmpty
//                 ? GridView.builder(
//                     padding: EdgeInsets.all(16),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3,
//                       crossAxisSpacing: 8,
//                       mainAxisSpacing: 8,
//                     ),
//                     itemCount: data.BusinessData!.images!.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return _buildExistingImageTile(
//                           data.BusinessData!.images![index]);
//                     },
//                   )
//                 : Center(
//                     child: Text("No existing images"),
//                   ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildExistingImageTile(String imageUrl) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => FullScreenImage(imageUrl: imageUrl),
//           ),
//         );
//       },
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(12),
//         child: Image.network(
//           imageUrl,
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }

//   Widget _buildUploadButton() {
//     return Visibility(
//       visible: _images.isNotEmpty,
//       child: Container(
//         padding: EdgeInsets.all(16),
//         child: ElevatedButton(
//           onPressed: _isLoading ? null : uploadImage,
//           style: ElevatedButton.styleFrom(
//             backgroundColor: tgAccentColor,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             padding: EdgeInsets.symmetric(vertical: 16),
//           ),
//           child: SizedBox(
//             height: 20,
//             child: _isLoading
//                 ? SizedBox(
//                     height: 20,
//                     width: 20,
//                     child: CircularProgressIndicator(
//                       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                       strokeWidth: 2.0,
//                     ),
//                   )
//                 : Text(
//                     "Upload Images",
//                     style: TextStyle(fontSize: 15, color: Colors.white),
//                   ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class FullScreenImage extends StatelessWidget {
//   final String imageUrl;

//   const FullScreenImage({Key? key, required this.imageUrl}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.delete, color: Colors.white),
//             onPressed: () async {
//               bool confirm = await showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: Text("Delete Image"),
//                     content:
//                         Text("Are you sure you want to delete this image?"),
//                     actions: [
//                       TextButton(
//                         child: Text("Cancel"),
//                         onPressed: () => Navigator.of(context).pop(false),
//                       ),
//                       TextButton(
//                         child: Text("Delete"),
//                         onPressed: () => Navigator.of(context).pop(true),
//                       ),
//                     ],
//                   );
//                 },
//               );

//               if (confirm) {
//                 String businessUid = await getBusinessUid(context);
//                 await Provider.of<ServicesProvider>(context, listen: false)
//                     .deleteImage(businessUid, imageUrl);
//                 Navigator.pop(context);
//               }
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: InteractiveViewer(
//           panEnabled: true,
//           boundaryMargin: EdgeInsets.all(20),
//           minScale: 0.5,
//           maxScale: 4,
//           child: Image.network(
//             imageUrl,
//             fit: BoxFit.contain,
//             loadingBuilder: (BuildContext context, Widget child,
//                 ImageChunkEvent? loadingProgress) {
//               if (loadingProgress == null) return child;
//               return Center(
//                 child: CircularProgressIndicator(
//                   value: loadingProgress.expectedTotalBytes != null
//                       ? loadingProgress.cumulativeBytesLoaded /
//                           loadingProgress.expectedTotalBytes!
//                       : null,
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:backendapp/provider/businessmongo_provider.dart';
import 'package:backendapp/utils/constants.dart';
import 'package:dotted_border/dotted_border.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AddPhotos extends StatefulWidget {
  @override
  State<AddPhotos> createState() => _AddPhotosState();
}

class _AddPhotosState extends State<AddPhotos> {
  List<File> _images = [];
  bool _isLoading = false;
  int _currentImageIndex = 0;

  void uploadImage() async {
    setState(() {
      _isLoading = true;
    });
    String businessUid = await getBusinessUid(context);
    bool isSuccess = await Provider.of<ServicesProvider>(context, listen: false)
        .uploadImagesToServer(_images, businessUid);
    if (isSuccess) {
      setState(() {
        _images.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Images uploaded successfully"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to upload images"),
          backgroundColor: Colors.red,
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> multiImagePick() async {
    List<XFile> pickedFiles = await ImagePicker().pickMultiImage();
    setState(() {
      _images.addAll(pickedFiles.map((file) => File(file.path)).toList());
    });
  }

  void removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ServicesProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Add Photos',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        backgroundColor: tgPrimaryColor,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.keyboard_arrow_left_rounded)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildImageCarousel(data),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildImagePickerSection(),
                    _buildExistingImagesSection(data),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildUploadButton(),
    );
  }

  Widget _buildImageCarousel(ServicesProvider data) {
    var images = data.BusinessData?.images ?? [];
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider.builder(
          itemCount: images.isEmpty ? 1 : images.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return images.isEmpty
                ? Image.network(
                    "https://upload.wikimedia.org/wikipedia/commons/b/b9/No_Cover.jpg",
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : Image.network(
                    images[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  );
          },
          options: CarouselOptions(
            height: 200,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentImageIndex = index;
              });
            },
          ),
        ),
        Positioned(
          bottom: 10,
          child: AnimatedSmoothIndicator(
            activeIndex: _currentImageIndex,
            count: images.isEmpty ? 1 : images.length,
            effect: WormEffect(
              dotWidth: 10,
              dotHeight: 10,
              activeDotColor: Colors.grey[600]!,
              dotColor: Colors.white.withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImagePickerSection() {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Add New Photos",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          _images.isEmpty ? _buildAddPhotoButton() : _buildSelectedImagesGrid(),
        ],
      ),
    );
  }

  Widget _buildAddPhotoButton() {
    return InkWell(
      onTap: multiImagePick,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(12),
        color: tgAccentColor,
        strokeWidth: 2,
        dashPattern: [8, 4],
        child: Container(
          height: 100,
          width: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_photo_alternate, size: 40, color: tgAccentColor),
                SizedBox(height: 8),
                Text("Add Photos", style: TextStyle(color: tgAccentColor)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedImagesGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: _images.length + 1,
      itemBuilder: (context, index) {
        if (index == _images.length) {
          return _buildAddMoreButton();
        }
        return _buildImageTile(index);
      },
    );
  }

  Widget _buildAddMoreButton() {
    return InkWell(
      onTap: multiImagePick,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(12),
        color: tgAccentColor,
        strokeWidth: 2,
        dashPattern: [8, 4],
        child: Center(
          child: Icon(Icons.add, color: tgAccentColor),
        ),
      ),
    );
  }

  Widget _buildImageTile(int index) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
            _images[index],
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: InkWell(
            onTap: () => removeImage(index),
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, color: Colors.white, size: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExistingImagesSection(ServicesProvider data) {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Existing Images (${data.BusinessData?.images?.length ?? 0})",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          data.BusinessData?.images != null &&
                  data.BusinessData!.images!.isNotEmpty
              ? GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: data.BusinessData!.images!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildExistingImageTile(
                        data.BusinessData!.images![index]);
                  },
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("No existing images"),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildExistingImageTile(String imageUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreenImage(imageUrl: imageUrl),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildUploadButton() {
    return Visibility(
      visible: _images.isNotEmpty,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _isLoading ? null : uploadImage,
          style: ElevatedButton.styleFrom(
            backgroundColor: tgAccentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
          child: SizedBox(
            height: 20,
            child: _isLoading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 2.0,
                    ),
                  )
                : Text(
                    "Upload Images",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
          ),
        ),
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.white),
            onPressed: () async {
              bool confirm = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Delete Image"),
                    content:
                        Text("Are you sure you want to delete this image?"),
                    actions: [
                      TextButton(
                        child: Text("Cancel"),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      TextButton(
                        child: Text("Delete"),
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ],
                  );
                },
              );

              if (confirm) {
                String businessUid = await getBusinessUid(context);
                await Provider.of<ServicesProvider>(context, listen: false)
                    .deleteImage(businessUid, imageUrl);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Center(
        child: InteractiveViewer(
          panEnabled: true,
          boundaryMargin: EdgeInsets.all(20),
          minScale: 0.5,
          maxScale: 4,
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
