import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/store/auth/auth_store.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'widgets/address_form.dart';

class AddressBookScreen extends StatefulWidget {
  @override
  _AddressBookScreenState createState() => _AddressBookScreenState();
}

class _AddressBookScreenState extends State<AddressBookScreen> with SnackMixin, LoadingMixin, AppBarMixin {
  AuthStore _authStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authStore = Provider.of<AuthStore>(context);
    _authStore.addressStore.getAddressCountry(userId: _authStore.user.id);
  }

  postAddress(Map data) async {
    try {
      TranslateType translate = AppLocalizations.of(context).translate;
      await _authStore.addressStore.postBilling(
        userId: _authStore.user.id,
        data: data,
      );
      showSuccess(context, translate('address_billing_success'));
    } catch (e) {
      showError(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context).translate;
    return Observer(builder: (_) {
      Map billData = _authStore?.addressStore?.customer?.billing;
      bool loading = _authStore?.addressStore?.loading;
      return Scaffold(
        appBar: baseStyleAppBar(context, title: translate('address_billing')),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: loading
              ? buildLoading(context, isLoading: loading)
              : Padding(
                  padding: EdgeInsets.only(bottom: 24),
                  child: AddressForm(data: billData, countries: _authStore.addressStore.country, onSave: postAddress),
                ),
        ),
      );
    });
  }
}
