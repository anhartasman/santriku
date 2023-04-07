import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:saibupi/architectures/domain/entities/FamilyEvaluation.dart';
import 'package:saibupi/bloc/family_evaluation_save/bloc.dart';
import 'package:saibupi/enums/enum_pertanyaan_evaluasi.dart';
import 'package:saibupi/helpers/extensions/ext_string.dart';
import 'package:saibupi/theme/colors/Warna.dart';
import 'package:saibupi/theme/decorations/box_decoration.dart';
import 'package:saibupi/widgets/TampilanDialog.dart';
import 'package:saibupi/widgets/back_button.dart';
import 'package:saibupi/widgets/reusables/ReusableFormField.dart';
import 'package:saibupi/widgets/top_container.dart';

class form_evaluation extends StatefulWidget {
  final int childId;
  const form_evaluation({required this.childId});
  @override
  State<form_evaluation> createState() => _form_evaluationState();
}

class _form_evaluationState extends State<form_evaluation> {
  final formKey = GlobalKey<FormBuilderState>();
  TextEditingController _etTanggal = new TextEditingController();
  bool fileBeda = false;
  DateTime? selectedDate;
  late DateTime today;
  late DateTime firstDate;
  late DateTime lastDate;
  List<int> jawabanList = [];
  void saveForm() async {
    if (selectedDate == null) {
      TampilanDialog.showDialogAlert("Pilih tanggal terlebih dahulu");
      return;
    }
    if (!formKey.currentState!.saveAndValidate()) {
      TampilanDialog.showDialogAlert("Lengkapi form terlebih dahulu");
      return;
    }

    BlocProvider.of<FamilyEvaluationSaveBloc>(context)
        .add(FamilyEvaluationSaveBlocStart(FamilyEvaluation(
      id: 0,
      date: selectedDate!.toTanggal("yyyy-MM-dd"),
      childId: widget.childId,
      answers: jawabanList,
    )));
  }

  @override
  void initState() {
    today = DateTime.now();
    firstDate = today.subtract(Duration(days: 60));
    lastDate = today;
    for (var element in PertanyaanEvaluasi.values) {
      jawabanList.add(-1);
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
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 20),
              //   child: MyBackButton(),
              // ),
              TopContainer(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
                height: null,
                child: Column(
                  children: <Widget>[
                    MyBackButton(),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Form Evaluasi',
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: BlocConsumer<FamilyEvaluationSaveBloc,
                    FamilyEvaluationSaveBlocState>(listener: (context, state) {
                  if (state is FamilyEvaluationSaveOnError) {
                    TampilanDialog.showDialogAlert(state.errorMessage);
                  }
                  if (state is FamilyEvaluationSaveOnSuccess) {
                    TampilanDialog.showDialogSuccess("Data tersimpan")
                        .then((value) => Get.back(result: true));
                  }
                }, builder: (context, state) {
                  if (state is FamilyEvaluationSaveOnStarted) {
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
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 25.0,
                          left: 16,
                        ),
                        child: Text("Tanggal",
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
                            name: "tanggal",
                            readOnly: true,
                            onTap: () => TampilanDialog.DatePicker(
                              initialDate: selectedDate ?? today,
                              firstDate: firstDate,
                              lastDate: lastDate,
                            ).then((value) {
                              if (value != null) {
                                selectedDate = value;
                                _etTanggal.text =
                                    value.toTanggal("EEE, dd MMM yyyy");
                              }
                            }),
                            controller: _etTanggal,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                            PertanyaanEvaluasi.values.length, (index) {
                          final thePertanyaanEvaluasi =
                              PertanyaanEvaluasi.values[index];
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 25.0,
                                  left: 16,
                                ),
                                child: Text(thePertanyaanEvaluasi.label,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  decoration: box_field_abu,
                                  child: ReusableFormField.dropdown<bool>(
                                    context,
                                    name: "sudahTanya${index}",
                                    itemText: (bool value) {
                                      return value ? "Sudah" : "Belum";
                                    },
                                    onChanged: (bool? value) {
                                      if (value != null) {
                                        jawabanList[index] =
                                            value == true ? 1 : 0;
                                      }
                                    },
                                    items: [true, false],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                      SizedBox(
                        height: 40,
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
