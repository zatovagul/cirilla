import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/address/country.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

import 'modal_country.dart';
import 'modal_state.dart';

class AddressForm extends StatefulWidget {
  final Map<String, dynamic> data;
  final List<CountryData> countries;
  final Function(Map data) onSave;

  AddressForm({Key key, @required this.data, @required this.countries, @required this.onSave}) : super(key: key);

  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> with Utility {
  final _formKey = GlobalKey<FormState>();

  String countryId = '';
  String stateId = '';
  final _txtFirstName = TextEditingController();
  final _txtLastName = TextEditingController();
  final _txtCompany = TextEditingController();
  final _txtCountry = TextEditingController();
  final _txtState = TextEditingController();
  final _txtAddress1 = TextEditingController();
  final _txtAddress2 = TextEditingController();
  final _txtCity = TextEditingController();
  final _txtPostCode = TextEditingController();
  TextEditingController _txtPhone;
  TextEditingController _txtEmail;

  FocusNode _lastNameFocusNode;
  FocusNode _companyFocusNode;
  FocusNode _address1FocusNode;
  FocusNode _address2FocusNode;
  FocusNode _cityFocusNode;
  FocusNode _postCodeFocusNode;
  FocusNode _phoneFocusNode;
  FocusNode _emailFocusNode;

  @override
  void didChangeDependencies() {
    _txtFirstName.text = get(widget.data, ['first_name'], '');
    _txtLastName.text = get(widget.data, ['last_name'], '');
    _txtCompany.text = get(widget.data, ['company'], '');
    _txtAddress1.text = get(widget.data, ['address_1'], '');
    _txtAddress2.text = get(widget.data, ['address_2'], '');
    _txtCity.text = get(widget.data, ['city'], '');
    _txtPostCode.text = get(widget.data, ['postcode'], '');
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    String email = get(widget.data, ['email'], null);
    String phone = get(widget.data, ['phone'], null);
    countryId = get(widget.data, ['country'], '');
    stateId = get(widget.data, ['state'], '');

    if (email != null) {
      _txtEmail = TextEditingController(text: email);
    }
    if (email != null) {
      _txtPhone = TextEditingController(text: phone);
    }
    _lastNameFocusNode = FocusNode();
    _companyFocusNode = FocusNode();
    _address1FocusNode = FocusNode();
    _address2FocusNode = FocusNode();
    _cityFocusNode = FocusNode();
    _postCodeFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _txtFirstName.dispose();
    _txtLastName.dispose();
    _txtCompany.dispose();
    _txtCountry.dispose();
    _txtAddress1.dispose();
    _txtAddress2.dispose();
    _txtCity.dispose();
    _txtState.dispose();
    _txtPostCode.dispose();
    _txtPhone?.dispose();
    _txtEmail?.dispose();

    _lastNameFocusNode.dispose();
    _companyFocusNode.dispose();
    _address1FocusNode.dispose();
    _address2FocusNode.dispose();
    _cityFocusNode.dispose();
    _postCodeFocusNode.dispose();
    _phoneFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context).translate;
    CountryData countrySelect = widget.countries.firstWhere((element) => element.code == countryId, orElse: () => null);

    List<Map<String, dynamic>> states = countrySelect is CountryData ? countrySelect.states : [];
    Map<String, dynamic> stateSelect = states.firstWhere((element) => element['code'] == stateId, orElse: () => null);
    _txtCountry.text = countrySelect is CountryData ? countrySelect.name : '';
    _txtState.text = stateSelect is Map<String, dynamic> ? stateSelect['name'] : '';
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameField(translate),
          SizedBox(height: 16),
          buildLastNameField(translate),
          SizedBox(height: 16),
          buildCompanyField(translate),
          SizedBox(height: 16),
          buildCountryField(translate, countries: widget.countries),
          SizedBox(height: 16),
          buildAddress1Field(translate),
          SizedBox(height: 16),
          buildAddress2Field(translate),
          SizedBox(height: 16),
          buildCityField(translate),
          if (states.isNotEmpty) ...[
            SizedBox(height: 16),
            buildStateField(translate, states: states),
          ],
          SizedBox(height: 16),
          buildPostCodeField(translate),
          SizedBox(height: 16),
          if (_txtEmail != null) ...[
            buildEmailField(translate),
            SizedBox(height: 16),
          ],
          if (_txtPhone != null) ...[
            buildPhoneField(translate),
            SizedBox(height: 16),
          ],
          Text(translate('address_note'), style: theme.textTheme.caption),
          SizedBox(height: 24),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton(
              child: Text(translate('address_save')),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Map<String, dynamic> newData = {
                    'first_name': _txtFirstName.text,
                    'last_name': _txtLastName.text,
                    'company': _txtCompany.text,
                    'country': countryId,
                    'address_1': _txtAddress1.text,
                    'address_2': _txtAddress2.text,
                    'city': _txtCity.text,
                    'state': stateId,
                    'postcode': _txtPostCode.text,
                  };

                  if (_txtEmail is TextEditingController) {
                    newData.addAll({'email': _txtEmail.text});
                  }
                  if (_txtPhone is TextEditingController) {
                    newData.addAll({'phone': _txtPhone.text});
                  }
                  widget.onSave(newData);
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildFirstNameField(TranslateType translate) {
    return TextFormField(
      controller: _txtFirstName,
      validator: (value) {
        if (value.isEmpty) {
          return translate('validate_first_name_required');
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: translate('address_first_name'),
      ),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_lastNameFocusNode);
      },
    );
  }

  Widget buildLastNameField(TranslateType translate) {
    return TextFormField(
      controller: _txtLastName,
      validator: (value) {
        if (value.isEmpty) {
          return translate('validate_last_name_required');
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: translate('address_last_name'),
      ),
      textInputAction: TextInputAction.next,
      focusNode: _lastNameFocusNode,
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_companyFocusNode);
      },
    );
  }

  Widget buildCompanyField(TranslateType translate) {
    return TextFormField(
      controller: _txtCompany,
      decoration: InputDecoration(
        labelText: translate('address_company'),
      ),
      textInputAction: TextInputAction.next,
      focusNode: _companyFocusNode,
    );
  }

  Widget buildCountryField(TranslateType translate, {List<CountryData> countries}) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return buildViewModal(
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter stateSetter) {
                  return ModalCountries(
                    countries: countries,
                    countryId: countryId,
                    onChange: (String countryValue, String stateValue) {
                      stateSetter(() {
                        countryId = countryValue;
                        stateId = stateValue;
                      });
                      setState(() {
                        countryId = countryValue;
                        stateId = stateValue;
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            );
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
        );
      },
      child: TextFormField(
        controller: _txtCountry,
        validator: (value) {
          if (value.isEmpty) {
            return translate('validate_country_required');
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: translate('address_country'),
          suffixIcon: Icon(FeatherIcons.chevronDown, size: 16),
          suffixIconConstraints: BoxConstraints(
            minWidth: 2,
            minHeight: 2,
          ),
        ),
        enabled: false,
      ),
    );
  }

  Widget buildAddress1Field(TranslateType translate) {
    return TextFormField(
      controller: _txtAddress1,
      validator: (value) {
        if (value.isEmpty) {
          return translate('validate_address1_required');
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: translate('address_1'),
      ),
      textInputAction: TextInputAction.next,
      focusNode: _address1FocusNode,
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_address2FocusNode);
      },
    );
  }

  Widget buildAddress2Field(TranslateType translate) {
    return TextFormField(
      controller: _txtAddress2,
      decoration: InputDecoration(
        labelText: translate('address_2'),
      ),
      textInputAction: TextInputAction.next,
      focusNode: _address2FocusNode,
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_cityFocusNode);
      },
    );
  }

  Widget buildCityField(TranslateType translate) {
    return TextFormField(
      controller: _txtCity,
      validator: (value) {
        if (value.isEmpty) {
          return translate('validate_city_required');
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: translate('address_city'),
      ),
      textInputAction: TextInputAction.next,
      focusNode: _cityFocusNode,
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_postCodeFocusNode);
      },
    );
  }

  Widget buildStateField(TranslateType translate, {List<Map<String, dynamic>> states}) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return buildViewModal(
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter stateSetter) {
                  return ModalState(
                    states: states,
                    stateId: stateId,
                    onChange: (String stateValue) {
                      stateSetter(() {
                        stateId = stateValue;
                      });
                      setState(() {
                        stateId = stateValue;
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            );
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
        );
      },
      child: TextFormField(
        controller: _txtState,
        validator: (value) {
          if (states.length > 0 && value.isEmpty) {
            return translate('validate_state_required');
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: translate('address_state'),
          suffixIcon: Icon(FeatherIcons.chevronDown, size: 16),
          suffixIconConstraints: BoxConstraints(
            minWidth: 2,
            minHeight: 2,
          ),
        ),
        enabled: false,
      ),
    );
  }

  Widget buildPostCodeField(TranslateType translate) {
    return TextFormField(
      controller: _txtPostCode,
      decoration: InputDecoration(
        labelText: translate('address_post_code'),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return translate('validate_postcode_required');
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      focusNode: _postCodeFocusNode,
      onFieldSubmitted: (value) {
        if (_txtEmail != null) {
          FocusScope.of(context).requestFocus(_emailFocusNode);
        }
        // FocusScope.of(context).requestFocus();
      },
    );
  }

  Widget buildEmailField(TranslateType translate) {
    return TextFormField(
      controller: _txtEmail,
      validator: (value) => emailValidator(value: value, errorEmail: translate('validate_email_value')),
      decoration: InputDecoration(
        labelText: translate('address_email'),
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      focusNode: _emailFocusNode,
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_phoneFocusNode);
      },
    );
  }

  Widget buildPhoneField(TranslateType translate) {
    return TextFormField(
      controller: _txtPhone,
      validator: (value) {
        if (value.isEmpty) {
          return translate('validate_phone_required');
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: translate('address_phone'),
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.phone,
      focusNode: _phoneFocusNode,
    );
  }

  Widget buildViewModal({Widget child}) {
    return LayoutBuilder(builder: (_, BoxConstraints constraints) {
      double height = constraints.maxHeight;
      return Container(
        constraints: BoxConstraints(maxHeight: height - 100),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: SizedBox(
          width: double.infinity,
          child: child,
        ),
      );
    });
  }
}
