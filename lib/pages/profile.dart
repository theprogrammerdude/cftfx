import 'package:avatars/avatars.dart';
import 'package:cftfx/methods/auth_methods.dart';
import 'package:cftfx/methods/db_methods.dart';
import 'package:cftfx/models/user_model.dart';
import 'package:cftfx/pages/welcome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthMethods _authMethods = AuthMethods();
  final DbMethods _dbMethods = DbMethods();

  _accountBottomSheet() {
    return showBarModalBottomSheet(
        context: context,
        useRootNavigator: true,
        builder: (context) {
          return StreamBuilder(
            stream: _dbMethods.getUserData(_authMethods.currentUser()!.uid),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData) {
                UserModel _user = UserModel.fromMap(
                    snapshot.data!.data() as Map<String, dynamic>);

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _user.name.text.bold.capitalize.size(24).make(),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        'Username: '.text.size(16).make(),
                        _user.username.text
                            .size(16)
                            .align(TextAlign.right)
                            .make(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        'Email: '.text.size(16).make(),
                        _user.email.text.size(16).align(TextAlign.right).make(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        'Amount: '.text.size(16).make(),
                        ('\$ ' + _user.amount.toStringAsFixed(3))
                            .text
                            .size(16)
                            .align(TextAlign.right)
                            .make(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        'Equity: '.text.size(16).make(),
                        ('\$ ' + _user.equity.toStringAsFixed(3))
                            .text
                            .size(16)
                            .align(TextAlign.right)
                            .make(),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: 'Deposit Amount'.text.size(18).make(),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Vx.green700),
                      ),
                    )
                        .cornerRadius(10)
                        .wPCT(context: context, widthPCT: 100)
                        .h(50),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: 'Withdraw Amount'.text.size(18).make(),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Vx.red700),
                      ),
                    )
                        .cornerRadius(10)
                        .wPCT(context: context, widthPCT: 100)
                        .h(50),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ).p12();
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        });
  }

  contactBottom() {
    showBarModalBottomSheet(
        context: context,
        useRootNavigator: true,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              'Contact Us'.text.bold.size(22).make(),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  String _url = 'tel:+918860048155';

                  if (await canLaunch(_url)) {
                    await launch(_url);
                  } else {
                    throw 'Could not launch $_url';
                  }
                },
                child: Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.phone,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        'Call Us'.text.bold.size(18).make(),
                        'Contact us on phone.'.text.make(),
                        '+91 8860048155'.text.make(),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.black,
                height: 36,
              ).wPCT(context: context, widthPCT: 80),
              GestureDetector(
                onTap: () async {
                  String _url = 'mailto:info@cryptofuturetrade.com';

                  if (await canLaunch(_url)) {
                    await launch(_url);
                  } else {
                    throw 'Could not launch $_url';
                  }
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.email,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        'Email Us'.text.bold.size(18).make(),
                        'Email us on our official email id.'.text.make(),
                        'info@cryptofuturetrade.com'.text.make(),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.black,
                height: 36,
              ).wPCT(context: context, widthPCT: 80),
              GestureDetector(
                onTap: () async {
                  var whatsapp = "+31684398083";
                  var whatsappURlAndroid = "whatsapp://send?phone=$whatsapp";
                  // var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
                  // if(Platform.isIOS){
                  //   for iOS phone only
                  //   if( await canLaunch(whatappURL_ios)){
                  //      await launch(whatappURL_ios, forceSafariVC: false);
                  //   }else{
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //         SnackBar(content: new Text("whatsapp no installed")));
                  //   }
                  // }else{
                  // android , web
                  if (await canLaunch(whatsappURlAndroid)) {
                    await launch(whatsappURlAndroid);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("whatsapp not installed")));
                  }
                  // }
                },
                child: Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.whatsapp,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        'Whatsapp'.text.bold.size(18).make(),
                        'Contact us on whatsapp.'.text.make(),
                        '+31 6 84398083'.text.make(),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ).p16();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Profile'.text.make(),
      ),
      body: StreamBuilder(
        stream: _dbMethods.getUserData(_authMethods.currentUser()!.uid),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            // print(snapshot.data!.data());
            UserModel _user = UserModel.fromMap(
                snapshot.data!.data() as Map<String, dynamic>);

            return SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Avatar(
                      name: _user.name,
                    ).pSymmetric(v: 15),
                    _user.name.text.capitalize.size(28).make(),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () => _accountBottomSheet(),
                          child: Row(
                            children: [
                              Icon(Icons.account_box_rounded,
                                      size: 30,
                                      color: Theme.of(context).primaryColor)
                                  .px16(),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    'Account'
                                        .text
                                        .extraBold
                                        .color(Theme.of(context).primaryColor)
                                        .size(25)
                                        .make(),
                                    'Get all your account related details.'
                                        .text
                                        .color(Theme.of(context).primaryColor)
                                        .size(14)
                                        .make()
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          height: 36,
                        ).wPCT(context: context, widthPCT: 80),
                        GestureDetector(
                          child: Row(
                            children: [
                              Icon(Icons.info_outline_rounded,
                                      size: 30,
                                      color: Theme.of(context).primaryColor)
                                  .px16(),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    'Terms and Conditions'
                                        .text
                                        .extraBold
                                        .color(Theme.of(context).primaryColor)
                                        .size(25)
                                        .make(),
                                    'Read about our Terms and Conditions here'
                                        .text
                                        .color(Theme.of(context).primaryColor)
                                        .size(14)
                                        .make()
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          height: 36,
                        ).wPCT(context: context, widthPCT: 80),
                        GestureDetector(
                          child: Row(
                            children: [
                              Icon(Icons.lock_outline_rounded,
                                      size: 30,
                                      color: Theme.of(context).primaryColor)
                                  .px16(),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    'Privacy Policy'
                                        .text
                                        .extraBold
                                        .color(Theme.of(context).primaryColor)
                                        .size(25)
                                        .make(),
                                    'Read about our Privacy Policy here'
                                        .text
                                        .color(Theme.of(context).primaryColor)
                                        .size(14)
                                        .softWrap(true)
                                        .make()
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          height: 36,
                        ).wPCT(context: context, widthPCT: 80),
                        GestureDetector(
                          onTap: () => contactBottom(),
                          child: Row(
                            children: [
                              Icon(Icons.call_rounded,
                                      size: 30,
                                      color: Theme.of(context).primaryColor)
                                  .px16(),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    'Contact Us'
                                        .text
                                        .extraBold
                                        .color(Theme.of(context).primaryColor)
                                        .size(25)
                                        .make(),
                                    'To know more, contact us.'
                                        .text
                                        .color(Theme.of(context).primaryColor)
                                        .size(14)
                                        .softWrap(true)
                                        .make()
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ).py20().backgroundColor(Vx.white).cornerRadius(20),
                    Divider(
                      color: Theme.of(context).backgroundColor,
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () => _authMethods.logout().then(
                            (value) => pushNewScreen(
                              context,
                              screen: const Welcome(),
                              withNavBar: false,
                            ),
                          ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Row(
                          children: [
                            const Icon(Icons.logout_rounded,
                                    size: 30, color: Vx.red600)
                                .px16(),
                            'Logout'.text.extraBold.red600.size(25).make(),
                          ],
                        ).py20().backgroundColor(Vx.white),
                      ),
                    )
                  ],
                ).p12(),
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
