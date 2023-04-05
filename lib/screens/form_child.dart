import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:saibupi/architectures/domain/entities/FamilyMember.dart';
import 'package:saibupi/bloc/family_member_save/bloc.dart';
import 'package:saibupi/helpers/inputFormaters/InputDateFormatter.dart';
import 'package:saibupi/theme/colors/Warna.dart';
import 'package:saibupi/theme/colors/light_colors.dart';
import 'package:saibupi/theme/decorations/box_decoration.dart';
import 'package:saibupi/theme/decorations/input_decoration.dart';
import 'package:saibupi/theme/styles/text_field_style.dart';
import 'package:saibupi/widgets/PhotoChild.dart';
import 'package:saibupi/widgets/TampilanDialog.dart';
import 'package:saibupi/widgets/top_container.dart';
import 'package:saibupi/widgets/back_button.dart';
import 'package:saibupi/widgets/my_text_field.dart';
import 'package:saibupi/screens/home_page.dart';
import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart' as Path;

class form_child extends StatefulWidget {
  @override
  State<form_child> createState() => _form_childState();
}

class _form_childState extends State<form_child> {
  final formKey = GlobalKey<FormBuilderState>();
  TextEditingController _etName = new TextEditingController();
  TextEditingController _etTanggalLahir = new TextEditingController();
  TextEditingController _etLike = new TextEditingController();
  TextEditingController _etNotLike = new TextEditingController();
  TextEditingController _etChildRank = new TextEditingController();
  bool fileBeda = false;
  File? fotoChild;
  void saveForm() async {
    if (fotoChild == null) {
      TampilanDialog.showDialogAlert("Pilih foto terlebih dahulu");
      return;
    }
    if (!formKey.currentState!.saveAndValidate()) {
      TampilanDialog.showDialogAlert("Lengkapi form terlebih dahulu");
      return;
    }

    // String base64Image = base64Encode(fotoChild!.readAsBytesSync());

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    final fileName = Path.basename(fotoChild!.path);
    final newPath = fileBeda ? '$appDocPath/$fileName' : fotoChild!.path;
    if (fileBeda) {
      final File localImage = await fotoChild!.copy(newPath);
    }

    BlocProvider.of<FamilyMemberSaveBloc>(context)
        .add(FamilyMemberSaveBlocStart(FamilyMember(
      id: oldData == null ? 0 : oldData!.id,
      name: _etName.text,
      gender: "f",
      birth: _etTanggalLahir.text,
      childRank: int.parse(_etChildRank.text),
      like: _etLike.text,
      notlike: _etNotLike.text,
      picture: newPath,
    )));
  }

  FamilyMember? oldData;

  @override
  void initState() {
    oldData = Get.arguments;
    if (oldData != null) {
      _etName.text = oldData!.name;
      _etTanggalLahir.text = oldData!.birth;
      _etLike.text = oldData!.like;
      _etNotLike.text = oldData!.notlike;
      _etChildRank.text = oldData!.childRank.toString();
      fotoChild = File(oldData!.picture);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var downwardIcon = Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black54,
    );
    return Scaffold(
      backgroundColor: Warna.unguMuda,
      body: SafeArea(
        child: FormBuilder(
          key: formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: MyBackButton(),
              ),
              Expanded(
                  child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: BlocConsumer<FamilyMemberSaveBloc,
                    FamilyMemberSaveBlocState>(listener: (context, state) {
                  if (state is FamilyMemberSaveOnError) {
                    TampilanDialog.showDialogAlert(state.errorMessage);
                  }
                  if (state is FamilyMemberSaveOnSuccess) {
                    Get.back(result: true);
                  }
                }, builder: (context, state) {
                  if (state is FamilyMemberSaveOnStarted) {
                    return Center(
                      child: SpinKitWave(
                        color: Warna.warnaUtama,
                        size: 50.0,
                      ),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      PhotoChild(
                        initialFile: fotoChild,
                        onChanged: (File? newFile) {
                          fileBeda = true;
                          fotoChild = newFile;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 25.0,
                          left: 16,
                        ),
                        child: Text("Nama",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: box_field_abu,
                          child: new FormBuilderTextField(
                            name: "Nama",
                            controller: _etName,
                            decoration: text_field_abu,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                            ]),
                            keyboardType: TextInputType.text,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 25.0,
                          left: 16,
                        ),
                        child: Text("Tanggal Lahir",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: box_field_abu,
                          child: new FormBuilderTextField(
                            name: "bod",
                            controller: _etTanggalLahir,
                            decoration: text_field_abu.copyWith(
                                hintText: "Cth 11/03/2020"),
                            keyboardType: TextInputType.number,
                            inputFormatters: [InputDateFormatter("")],
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(context),
                              ],
                            ),
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 25.0,
                          left: 16,
                        ),
                        child: Text("Yang disukai",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: box_field_abu,
                          child: new FormBuilderTextField(
                            name: "like",
                            controller: _etLike,
                            decoration: text_field_abu,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                            ]),
                            keyboardType: TextInputType.text,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 25.0,
                          left: 16,
                        ),
                        child: Text("Yang tidak disukai",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: box_field_abu,
                          child: new FormBuilderTextField(
                            name: "notlike",
                            controller: _etNotLike,
                            decoration: text_field_abu,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                            ]),
                            keyboardType: TextInputType.text,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 25.0,
                          left: 16,
                        ),
                        child: Text("Anak ke berapa",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          bottom: 40,
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: box_field_abu,
                          child: new FormBuilderTextField(
                            name: "childRank",
                            controller: _etChildRank,
                            decoration: text_field_abu,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                            ]),
                            keyboardType: TextInputType.number,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              )),
              Container(
                height: 80,
                width: width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    InkWell(
                      onTap: saveForm,
                      child: Container(
                        child: Text(
                          'Simpan',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                        width: width - 40,
                        decoration: BoxDecoration(
                          color: Warna.unguTua,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
