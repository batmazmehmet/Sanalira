import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:sanalira/config/palette.dart';
import 'package:sanalira/config/theme.dart';
import 'package:sanalira/provider/bank_list_provider.dart';
import 'package:sanalira/view/register_view.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    super.initState();
    BankListProvider provider =
        Provider.of<BankListProvider>(context, listen: false);
    provider.getData();
  }

  Widget build(BuildContext context) {
    BankListProvider provider = Provider.of<BankListProvider>(context);

    double sWidth = MediaQuery.of(context).size.width;
    double sHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        bottomNavigationBar: SizedBox(
          height: sHeight * 0.1,
          child: BottomNavigationBar(
            elevation: 10,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.grey.shade400,
            unselectedItemColor: Colors.grey.shade400,
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.assessment,
                ),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: const CircleAvatar(
                    maxRadius: 25,
                    backgroundColor: Color.fromARGB(255, 38, 40, 62),
                    child: Icon(
                      Icons.grid_view_rounded,
                      color: Colors.white,
                    )),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.credit_card_outlined),
                label: '',
              ),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: ""),
            ],
          ),
        ),
        appBar: AppBar(
            leading:  Padding(
              padding: EdgeInsets.all(8.0),
              child: InkWell(
                onTap:() async{

                  await FirebaseAuth.instance.signOut();
                   Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterView()));
                  
                },
                child: const CircleAvatar(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 243, 244, 246),
            actions: [
              const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.notifications,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: sWidth * 0.015,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                ),
              ),
            ]),
        body: Container(
          height: sHeight,
          color: const Color.fromARGB(255, 243, 244, 246),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Container(
                    height: sHeight * 0.15,
                    child: ListView(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: ListTile(
                              style: ListTileStyle.drawer,
                              leading: const CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/trk.jpg"),
                              ),
                              title: Text("Türk Lirası",
                                  style: CustomTheme.body(context,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text("TL",
                                  style: CustomTheme.body(context,
                                      color: Palette.grayColor)),
                              trailing: Text("250₺",
                                  style: CustomTheme.subtitle(context,
                                      fontWeight: FontWeight.bold))),
                        ),
                        SizedBox(
                          height: sHeight * 0.01,
                        ),
                        Text("Türk lirası yatırmak için banka seçiniz",
                            style: CustomTheme.body(context,
                                color: Palette.grayColor)),
                        SizedBox(
                          height: sHeight * 0.01,
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: sHeight * 0.65,
                    child: provider.loading
                        ? const Center(child: const CircularProgressIndicator())
                        : ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(
                                  height: sHeight * 0.01,
                                ),
                            itemCount: provider.bankListModel!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: ListTile(
                                  leading: DottedBorder(
                                      color: Palette.grayColor,
                                      child: Image.asset(
                                          "assets/images/sanaliraImage.jpg")),
                                  title: Text(
                                      provider.bankListModel![index].bankName
                                          .toString(),
                                      style: CustomTheme.body(context,
                                          fontWeight: FontWeight.bold)),
                                  subtitle: Text(
                                      ("Havale / EFT ile para gönderin."),
                                      style: CustomTheme.body(context,
                                          color: Palette.grayColor)),
                                  onTap: () {
                                    showModalBottomSheet(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(10.0),
                                          ),
                                        ),
                                        context: context,
                                        builder: (context) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, left: 10, right: 10,bottom: 25),
                                            child: Column(
                                              mainAxisSize:
                                                      MainAxisSize.min,
                                              children: [
                                                Container(
                                                  color: Colors.black,
                                                  width: sWidth * 0.1,
                                                  height: sHeight * 0.002,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: sHeight * 0.01,
                                                    ),
                                                    Text(
                                                      "Hesap Adı",
                                                      style: CustomTheme.body(
                                                          context,
                                                          color: Palette
                                                              .grayColor),
                                                    ),
                                                    TextField(
                                                      readOnly: true,
                                                      autofocus: false,
                                                      style: CustomTheme.body(
                                                          context),
                                                      decoration:
                                                          InputDecoration(
                                                        suffixIcon: InkWell(
                                                          onTap: () async => await Clipboard.setData(ClipboardData(text: provider
                                                            .bankListModel![
                                                                index]
                                                            .bankAccountName)),
                                                          child: Icon(
                                                            Icons.copy,
                                                            color: Palette
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                        filled: true,
                                                        hintText: provider
                                                            .bankListModel![
                                                                index]
                                                            .bankAccountName,
                                                        fillColor: const Color
                                                                .fromARGB(
                                                            255, 243, 244, 246),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 14.0,
                                                                bottom: 8.0,
                                                                top: 8.0),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .white),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .white),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: sHeight * 0.01,
                                                    ),
                                                    Text(
                                                      "IBAN",
                                                      style: CustomTheme.body(
                                                          context,
                                                          color: Palette
                                                              .grayColor),
                                                    ),
                                                    TextField(
                                                      readOnly: true,
                                                      style: CustomTheme.body(
                                                          context),
                                                      decoration:
                                                          InputDecoration(
                                                        suffixIcon: InkWell(
                                                           onTap: () async => await Clipboard.setData(ClipboardData(text: provider
                                                            .bankListModel![
                                                                index]
                                                            .bankIban)),
                                                          child: Icon(
                                                            Icons.copy,
                                                            color: Palette
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                        filled: true,
                                                        hintText: provider
                                                            .bankListModel![
                                                                index]
                                                            .bankIban,
                                                        fillColor: const Color
                                                                .fromARGB(
                                                            255, 243, 244, 246),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 14.0,
                                                                bottom: 8.0,
                                                                top: 8.0),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .white),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .white),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: sHeight * 0.01,
                                                    ),
                                                    Text(
                                                      "Açıklama",
                                                      style: CustomTheme.body(
                                                          context,
                                                          color: Palette
                                                              .grayColor),
                                                    ),
                                                    TextField(
                                                      readOnly: true,
                                                      autofocus: false,
                                                      style: CustomTheme.body(
                                                          context),
                                                      decoration:
                                                          InputDecoration(
                                                        suffixIcon: InkWell(
                                                           onTap: () async => await Clipboard.setData(ClipboardData(text: provider
                                                            .bankListModel![
                                                                index]
                                                            .descriptionNo)),
                                                          child: Icon(
                                                            Icons.copy,
                                                            color: Palette
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                        filled: true,
                                                        hintText: provider
                                                            .bankListModel![
                                                                index]
                                                            .descriptionNo,
                                                        fillColor: const Color
                                                                .fromARGB(
                                                            255, 243, 244, 246),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 14.0,
                                                                bottom: 8.0,
                                                                top: 8.0),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .white),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .white),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: sHeight * 0.01,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: sHeight * 0.01,
                                                ),
                                                Container(
                                                  color: const Color.fromARGB(
                                                      255, 243, 244, 246),
                                                  width: sWidth,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 14.0,
                                                            bottom: 8.0,
                                                            top: 8.0,
                                                            right: 14.0),
                                                    child: Text(
                                                        "Lütfen havale yaparken açıklama alanına yukarıdaki kodu yazmayı unutmayın.",
                                                        style: CustomTheme.body(
                                                            context,
                                                            color: Palette
                                                                .grayColor),
                                                        textAlign:
                                                            TextAlign.center),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: sHeight * 0.01,
                                                ),
                                                Container(
                                                  color: const Color.fromARGB(
                                                      255, 255,246,246),
                                                  width: sWidth,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 14.0,
                                                            bottom: 8.0,
                                                            top: 8.0,
                                                            right: 14.0),
                                                    child: Text(
                                                        "Eksik bilgi girilmesi sebebiyle tutarın askıda kalması durumunda, ücret kesintisi yapılacaktır.",
                                                        style: CustomTheme.body(
                                                            context,
                                                            color: Colors.red),
                                                        textAlign:
                                                            TextAlign.center),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                ),
                              );
                            }),
                  ),
                ],
              )),
        ));
  }
}
