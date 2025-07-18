import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tomato_guard/model/user_data_model.dart';
import 'package:tomato_guard/model/userprofile_model.dart';
import 'package:tomato_guard/utils/api.dart';

final Api api = Api();

class GetUploadFunction {
  Future<bool> uploaddata(File imagefile, String diseasename) async {
    try {
      var uri = Uri.parse(api.api);
      var request = http.MultipartRequest('POST', uri);
      request.fields['DiseaseName'] = diseasename;
      request.files.add(
        await http.MultipartFile.fromPath('DiseaseImage', imagefile.path),
      );

      var response = await request.send();

      if (response.statusCode == 201) {
        print('Disease data uploaded successfully');
        return true;
      } else {
        print('Failed to upload disease data');
        return false;
      }
    } catch (e) {
      print('Upload Error: $e');
      return false;
    }
  }

  Future<List<UserDataModel>> fetchdata() async {
    List<UserDataModel> userdata = [];
    try {
      final response = await http.get(Uri.parse(api.api));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        data.forEach((item) {
          userdata.add(
            UserDataModel(
              id: item['id'].toString(),
              title: item['DiseaseName'],
              image: item['DiseaseImage'],
              data: item['Date'].toString(),
            ),
          );
        });
        return userdata.reversed.toList();
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Fetch Error: $e');
    }
    return userdata;
  }

  Future<bool> deletedata(String id) async {
    try {
      final Uri deleteUrl = Uri.parse('${api.api}$id/');
      final response = await http.delete(deleteUrl);

      if (response.statusCode == 204) {
        print('Deleted successfully');
        return true;
      } else {
        print('Failed to delete: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Delete Error: $e');
      return false;
    }
  }

  Future<bool> uploadorsaveprofile(
    String uid,
    String username,
    String useremail,
    String userfarmingexperience,
    File? imagefile,
  ) async {
    try {
      final request = await http.MultipartRequest(
        'POST',
        Uri.parse('${api.profileApi}'),
      );
      request.fields['uid'] = uid;
      request.fields['username'] = username;
      request.fields['useremail'] = useremail;
      request.fields['userfarmingexperience'] = userfarmingexperience;
      if (imagefile != null) {
        request.files.add(
          await http.MultipartFile.fromPath('userimage', imagefile.path),
        );
      }
      var streamedresponsed = await request.send();
      var response = await http.Response.fromStream(streamedresponsed);
      if (response.statusCode == 201) {
        print('profile upload and update successfully');
        return true;
      } else {
        print('not upload or update');
      }
    } catch (e) {
      print('Error: $e');
    }
    return false;
  }

  Future<UserprofileModel?> fetchprofiledata(String uid) async {
    try {
      final response = await http.get(Uri.parse('${api.profileApi}$uid/'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return UserprofileModel.fromMap(data);
      } else {
        print('Faild to load profile');
      }
    } catch (e) {
      print('Error:$e');
    }
    return null;
  }
}
