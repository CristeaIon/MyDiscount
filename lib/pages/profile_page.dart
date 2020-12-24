import 'package:MyDiscount/services/auth_service.dart';
import 'package:MyDiscount/widgets/profile_field_widget.dart';
import 'package:MyDiscount/widgets/profile_item_widget.dart';

import 'package:flutter/material.dart';

import '../localization/localizations.dart';
import '../models/profile_model.dart';
import '../models/user_credentials.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage();
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService service = AuthService();
  @override
  void initState() {
    UserCredentials().getUserProfileData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final String pageName = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(pageName),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: Container(
        color: Colors.green,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                  child: FutureBuilder<Profile>(
                    future: UserCredentials().getUserProfileData(),
                    builder: (context, snapshot) => snapshot.hasData
                        ? SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Container(
                              padding:
                                  EdgeInsets.only(left: 10, right: 10, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ProfileItemWidget(
                                      labelText: AppLocalizations.of(context)
                                          .translate('text26'),
                                      text: snapshot.data.firstName),
                                  Divider(),
                                  ProfileItemWidget(
                                      labelText: AppLocalizations.of(context)
                                          .translate('text27'),
                                      text: snapshot.data.lastName),
                                  Divider(),
                                  ProfileItemWidget(
                                      labelText: 'E-mail',
                                      text: snapshot.data.email),
                                  Divider(),
                                  ProfileFieldWidget(
                                    labelText: AppLocalizations.of(context)
                                          .translate('text37'),
                                    info: snapshot.data.phone,
                                  ),
                                  Divider(),
                                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      OutlineButton(
                        onPressed: () {
                          service.signOut(context);
                        },
                        splashColor: Colors.green,
                        borderSide: BorderSide(color: Colors.green),
                        highlightColor: Colors.green,
                        highlightedBorderColor: Colors.red,
                        child: Text(AppLocalizations.of(context)
                                          .translate('text31')),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ],
                  )
                                ],
                              ),
                            ),
                          )
                        : Container(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

