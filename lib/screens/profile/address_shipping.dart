import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/store/auth/auth_store.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'widgets/address_form.dart';

class AddressShippingScreen extends StatefulWidget {
  @override
  _AddressShippingScreenState createState() => _AddressShippingScreenState();
}

class _AddressShippingScreenState extends State<AddressShippingScreen> with SnackMixin, LoadingMixin, AppBarMixin {
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
      await _authStore.addressStore.postShipping(
        userId: _authStore.user.id,
        data: data,
      );
      showSuccess(context, translate('address_shipping_success'));
    } catch (e) {
      showError(context, e);
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context).translate;
    return Observer(builder: (_) {
      Map shipData = _authStore?.addressStore?.customer?.shipping;
      bool loading = _authStore?.addressStore?.loading;
      return Scaffold(
        appBar: AppBar(
          title: Text(translate('address_shipping'), style: theme.textTheme.subtitle1),
          shadowColor: Colors.transparent,
          centerTitle: true,
          leading: leading(),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: loading
              ? buildLoading(context, isLoading: loading)
              : Padding(
                  padding: EdgeInsets.only(bottom: 24),
                  child: AddressForm(data: shipData, countries: _authStore.addressStore.country, onSave: postAddress),
                ),
        ),
      );
    });
  }
}
