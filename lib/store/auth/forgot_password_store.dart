import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

part 'forgot_password_store.g.dart';

class ForgotPasswordStore = _ForgotPasswordStore with _$ForgotPasswordStore;

abstract class _ForgotPasswordStore with Store {
  // // repository instance
  // RequestHelper _requestHelper;
  //
  // // store for handling form errors
  // final ForgotPasswordErrorStore formErrorStore = ForgotPasswordErrorStore();
  //
  // // constructor:-------------------------------------------------------------------------------------------------------
  // _ForgotPasswordStore(RequestHelper api) {
  //   this._requestHelper = api;
  // }
  //
  // // disposers:-----------------------------------------------------------------
  // List<ReactionDisposer> _disposers;
  //
  // // store variables:-----------------------------------------------------------
  //
  //
  // @observable
  // bool loading = false;
  //
  // @observable
  // bool success = false;
  //
  // @computed
  // bool get canForgotPassword => !formErrorStore.hasErrorsInForgotPassword && email.isNotEmpty;
  //
  // // actions:-------------------------------------------------------------------
  //
  // @action
  // Future forgotPassword({String identityToken, String userIdentity}) async {
  //   loading = true;
  //   success = false;
  //   try {
  //     await _requestHelper.forgotPassword(userLogin: email);
  //     loading = false;
  //     success = true;
  //   } catch (e) {
  //     loading = false;
  //   }
  // }
  //
  // // general methods:-----------------------------------------------------------
  // void dispose() {
  //   for (final d in _disposers) {
  //     d();
  //   }
  // }

  // Request helper instance
  RequestHelper _requestHelper;

  // constructor:-------------------------------------------------------------------------------------------------------
  _ForgotPasswordStore(RequestHelper requestHelper) {
    _requestHelper = requestHelper;
  }

  // store variables:-----------------------------------------------------------
  @observable
  bool _loading = false;

  @computed
  bool get loading => _loading;

  // actions:-------------------------------------------------------------------
  @action
  Future<bool> forgotPassword(String userLogin) async {
    _loading = true;
    try {
      await _requestHelper.forgotPassword(userLogin: userLogin);
      _loading = false;
      return true;
    } on DioError catch (e) {
      _loading = false;
      throw e;
    }
  }
}
