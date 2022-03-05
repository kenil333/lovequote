import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../domain/all.dart';

class SetReminderScreen extends StatefulWidget {
  const SetReminderScreen({Key? key}) : super(key: key);

  @override
  State<SetReminderScreen> createState() => _SetReminderScreenState();
}

class _SetReminderScreenState extends State<SetReminderScreen> {
  final _control = Get.put(GlobalCache());
  final _bloc = SetRemainderBloc();

  @override
  void initState() {
    _bloc.fetchandset();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return StreamBuilder<List<NotificationModel>>(
      stream: _bloc.liststream,
      initialData: const [],
      builder: (context, listsnap) {
        return Scaffold(
          backgroundColor: _control.darkmoderx.value ? screenbackdark : whit,
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(
              color: _control.darkmoderx.value ? whit : black87,
            ),
            backgroundColor: _control.darkmoderx.value ? appbardark : whit,
            title: Text(
              "Set reminders",
              style: TextStyle(
                letterSpacing: 1.5,
                color: _control.darkmoderx.value ? whit : black87,
              ),
            ),
          ),
          body: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 20, bottom: 30),
            itemCount: listsnap.data!.length,
            itemBuilder: (context, i) {
              return ReminderWidget(
                size: size,
                title:
                    "${listsnap.data![i].hour}:${listsnap.data![i].minute} ${listsnap.data![i].ampm}",
                dark: _control.darkmoderx.value,
                initialbool: listsnap.data![i].active,
                onclick: (bool value) async {
                  _control.vibrateclick();
                  _bloc.activechange(
                    listsnap.data!,
                    i,
                    value,
                    _control.todayquoterx.value,
                  );
                },
                editfunc: () async {
                  _control.vibrateclick();
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    final String _hour = pickedTime.hour.toString();
                    final String _min = pickedTime.minute.toString().length == 1
                        ? "0${pickedTime.minute.toString()}"
                        : pickedTime.minute.toString();
                    final String _id = "$_hour$_min";
                    final bool _found = listsnap.data!.any(
                      (element) => element.id == int.parse(_id),
                    );
                    if (_found) {
                      Get.snackbar(
                        "Alert !",
                        "The Time which you choose are already in the list !",
                        colorText: whit,
                        backgroundColor: redcol,
                      );
                    } else {
                      _bloc.editlist(
                        listsnap.data!,
                        i,
                        _id,
                        pickedTime,
                        _control.todayquoterx.value,
                      );
                    }
                  }
                },
                deletefunc: () async {
                  _control.vibrateclick();
                  _bloc.deletelist(listsnap.data!, i);
                },
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              _control.vibrateclick();
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (pickedTime != null) {
                final String _hour = pickedTime.hour.toString();
                final String _min = pickedTime.minute.toString().length == 1
                    ? "0${pickedTime.minute.toString()}"
                    : pickedTime.minute.toString();
                final String _id = "$_hour$_min";
                final bool _found = listsnap.data!.any(
                  (element) => element.id == int.parse(_id),
                );
                if (_found) {
                  Get.snackbar(
                    "Alert !",
                    "The Time which you choose are already in the list !",
                    colorText: whit,
                    backgroundColor: redcol,
                  );
                } else {
                  _bloc.addintolist(
                    listsnap.data!,
                    _id,
                    pickedTime,
                    _control.todayquoterx.value,
                  );
                }
              }
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
