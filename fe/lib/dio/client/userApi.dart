import 'package:ai_cv_generator/dio/client/dioClient.dart';
import 'package:ai_cv_generator/dio/request/DetailsRequests/Employment/AddEmploymentRequest.dart';
import 'package:ai_cv_generator/dio/request/DetailsRequests/Employment/RemoveEmploymentRequest.dart';
import 'package:ai_cv_generator/dio/request/DetailsRequests/Employment/UpdateEmploymentRequest.dart';
import 'package:ai_cv_generator/dio/request/DetailsRequests/Link/AddLinkRequest.dart';
import 'package:ai_cv_generator/dio/request/DetailsRequests/Link/RemoveLinkRequest.dart';
import 'package:ai_cv_generator/dio/request/DetailsRequests/Link/UpdateLinkRequest.dart';
import 'package:ai_cv_generator/dio/request/DetailsRequests/Qualification/AddQualificationRequest.dart';
import 'package:ai_cv_generator/dio/request/DetailsRequests/Reference/ReferenceRequest.dart';
import 'package:ai_cv_generator/dio/request/DetailsRequests/Skill/SkillRequest.dart';
import 'package:ai_cv_generator/dio/request/UserRequests/UpdateUserRequest.dart';
import 'package:ai_cv_generator/dio/request/DetailsRequests/Qualification/RemoveQualificationRequest.dart';
import 'package:ai_cv_generator/dio/request/DetailsRequests/Qualification/UpdateQualificationRequest.dart';
import 'package:ai_cv_generator/dio/response/DetailsResponses/QualificationsResponse.dart';
import 'package:ai_cv_generator/dio/response/DetailsResponses/EmploymentResponse.dart';
import 'package:ai_cv_generator/dio/response/DetailsResponses/LinkResponse.dart';
import 'package:ai_cv_generator/dio/response/DetailsResponses/ReferenceResponse.dart';
import 'package:ai_cv_generator/dio/response/DetailsResponses/SkillResponse.dart';
import 'package:ai_cv_generator/dio/response/UserResponses/UserResponse.dart';
import 'package:ai_cv_generator/models/user/Employment.dart';
import 'package:ai_cv_generator/models/user/Qualification.dart';
import 'package:ai_cv_generator/models/user/Reference.dart';
import 'package:ai_cv_generator/models/user/Skill.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:dio/dio.dart';
import 'package:ai_cv_generator/models/user/Link.dart' as lin;

class UserApi extends DioClient {
  static Future<UserModel?> getUser() async {
    UserModel? user;
    try {
      Response response = await DioClient.dio.get(
        'api/User/user',
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return (status !< 500);
          }
        )
      );
      user = UserResponse.fromJson(response.data).user;
    } on DioException catch (e) {
      DioClient.handleError(e);
    }
    return user;
  }
  
  static Future<UserModel?> updateUser({
      required UserModel user
    }) async {
    UserModel? updateduser;

    try {
      UpdateUserRequest request = UpdateUserRequest(user: user);
      Response response = await DioClient.dio.post(
        'api/User/user',
        data: request.toJson()
      );

      updateduser = UserResponse.fromJson(response.data).user;
    } on DioException catch (e) {
      DioClient.handleError(e);
    }

    return updateduser;
  }

  static Future<List<Qualification>?> addQulaification({
    required Qualification qualification
  }) async {
    try {
      AddQualificationRequest request = AddQualificationRequest(qualification: qualification);
      Response resp = await DioClient.dio.post(
        'api/User/addQua',
        data: request.toJson()
        );
      return QualificationsResponse.fromJson(resp.data).qualifications;
    } on DioException catch (e) {
      DioClient.handleError(e);
    }
    return null;
  }

  static Future<List<Qualification>?> removeQulaification({
    required Qualification qualification
  }) async {
    try {
      RemoveQualificationRequest request = RemoveQualificationRequest(qualification: qualification);
      Response resp = await DioClient.dio.post(
        'api/User/remQua',
        data: request.toJson()
        );
      return QualificationsResponse.fromJson(resp.data).qualifications;
    } on DioException catch (e) {
      DioClient.handleError(e);
    }
    return null;
  }

  static Future<List<Qualification>?> updateQulaification({
    required Qualification qualification
  }) async {
    try {
      UpdateQualificationRequest request = UpdateQualificationRequest(qualification: qualification);
      Response resp = await DioClient.dio.post(
        'api/User/updateQua',
        data: request.toJson()
        );
      return QualificationsResponse.fromJson(resp.data).qualifications;
    } on DioException catch (e) {
      DioClient.handleError(e);
    }
    return null;
  }

  static Future<List<Employment>?> addEmployment({
    required Employment employment
  }) async {
    try {
      AddEmploymentRequest request = AddEmploymentRequest(employment: employment);
      Response resp = await DioClient.dio.post(
        'api/User/addEmp',
        data: request.toJson()
      );
      return EmploymentResponse.fromJson(resp.data).employees;
    } on DioException catch(e) {
      DioClient.handleError(e);
    }
    return null;
  }

  static Future<List<Employment>?> RemoveEmployment({
    required Employment employment
  }) async {
    try {
      RemoveEmploymentRequest request = RemoveEmploymentRequest(employment: employment);
      Response resp = await DioClient.dio.post(
        'api/User/remEmp',
        data: request.toJson()
      );
      return EmploymentResponse.fromJson(resp.data).employees;
    } on DioException catch(e) {
      DioClient.handleError(e);
    }
    return null;
  }

  static Future<List<Employment>?> UpdateEmployment({
    required Employment employment
  }) async {
    try {
      UpdateEmploymentRequest request = UpdateEmploymentRequest(employment: employment);
      Response resp = await DioClient.dio.post(
        'api/User/updateEmp',
        data: request.toJson()
      );
      return EmploymentResponse.fromJson(resp.data).employees;
    } on DioException catch(e) {
      DioClient.handleError(e);
    }
    return null;
  }

  static Future<List<lin.Link>?> AddLink({
    required lin.Link link
  }) async {
    try {
      AddLinkRequest request = AddLinkRequest(link: link);
      Response resp = await DioClient.dio.post(
        'api/User/addLink',
        data: request.toJson()
      );
      return LinkResponse.fromJson(resp.data).links;
    } on DioException catch (e) {
      DioClient.handleError(e);
    }
    return null;
  }

  static Future<List<lin.Link>?> RemoveLink({
    required lin.Link link
  }) async {
    try {
      RemoveLinkRequest request = RemoveLinkRequest(link: link);
      Response resp = await DioClient.dio.post(
        'api/User/remLink',
        data: request.toJson()
      );
      return LinkResponse.fromJson(resp.data).links;
    } on DioException catch (e) {
      DioClient.handleError(e);
    }
    return null;
  }

  static Future<List<lin.Link>?> UpdateLink({
    required lin.Link link
  }) async {
    try {
      UpdateLinkRequest request = UpdateLinkRequest(link: link);
      Response resp = await DioClient.dio.post(
        'api/User/updateLink',
        data: request.toJson()
      );
      return LinkResponse.fromJson(resp.data).links;
    } on DioException catch (e) {
      DioClient.handleError(e);
    }
    return null;
  }

  static Future<List<Reference>?> addReference({
    required Reference reference
  }) async {
    try {
      ReferenceRequest request = ReferenceRequest(reference: reference);
      Response resp = await DioClient.dio.post(
        'api/User/addRef',
        data: request.toJson()
      );
      return ReferenceResponse.fromJson(resp.data).references;
    } on DioException catch (e) {
      DioClient.handleError(e);
    }
    return null;
  }

  static Future<List<Reference>?> removeReference({
    required Reference reference
  }) async {
    try {
      ReferenceRequest request = ReferenceRequest(reference: reference);
      Response resp = await DioClient.dio.post(
        'api/User/remRef',
        data: request.toJson()
      );
      return ReferenceResponse.fromJson(resp.data).references;
    } on DioException catch (e) {
      DioClient.handleError(e);
    }
    return null;
  }

  static Future<List<Reference>?> updateReference({
    required Reference reference
  }) async {
    try {
      ReferenceRequest request = ReferenceRequest(reference: reference);
      Response resp = await DioClient.dio.post(
        'api/User/updateRef',
        data: request.toJson()
      );
      return ReferenceResponse.fromJson(resp.data).references;
    } on DioException catch (e) {
      DioClient.handleError(e);
    }
    return null;
  }
  
  static Future<List<Skill>?> addSkill({
    required Skill skill
  }) async {
    try {
      SkillRequest request = SkillRequest(skill: skill);
      Response resp = await DioClient.dio.post(
        'api/User/addSkill',
        data: request.toJson()
      );
      return SkillResponse.fromJson(resp.data).skills;
    } on DioException catch (e) {
      DioClient.handleError(e);
    }
    return null;
  }

  static Future<List<Skill>?> removeSkill({
    required Skill skill
  }) async {
    try {
      SkillRequest request = SkillRequest(skill: skill);
      Response resp = await DioClient.dio.post(
        'api/User/remSkill',
        data: request.toJson()
      );
      return SkillResponse.fromJson(resp.data).skills;
    } on DioException catch (e) {
      DioClient.handleError(e);
    }
    return null;
  }

  static Future<List<Skill>?> updateSkill({
    required Skill skill
  }) async {
    try {
      SkillRequest request = SkillRequest(skill: skill);
      Response resp = await DioClient.dio.post(
        'api/User/updateSkill',
        data: request.toJson()
      );
      return SkillResponse.fromJson(resp.data).skills;
    } on DioException catch (e) {
      DioClient.handleError(e);
    }
    return null;
  }
}