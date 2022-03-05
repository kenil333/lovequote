import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../domain/all.dart';

class SetRemainderBloc {
  final StreamController<List<NotificationModel>> _listcontroller =
      StreamController<List<NotificationModel>>();
  StreamSink<List<NotificationModel>> get _listsink => _listcontroller.sink;
  Stream<List<NotificationModel>> get liststream => _listcontroller.stream;

  fetchandset() async {
    List<NotificationModel> _notificationlist = [];
    final _notifications = await NotificationDbHelper.getData();
    _notificationlist = _notifications
        .map(
          (e) => NotificationModel(
            id: int.parse(e["id"]),
            hour: e["hour"],
            minute: e["minute"],
            ampm: e["ampm"],
            active: e["active"] == "true" ? true : false,
          ),
        )
        .toList();
    if (_notificationlist.length > 1) {
      _notificationlist.sort((a, b) => a.id.compareTo(b.id));
    }
    _listsink.add(_notificationlist);
  }

  activechange(
    List<NotificationModel> fromlist,
    int index,
    bool activestatus,
    String todayquote,
  ) async {
    List<NotificationModel> _list = fromlist;
    await NotificationDbHelper.insert(
      {
        "id": _list[index].id.toString(),
        "hour": _list[index].hour,
        "minute": _list[index].minute,
        "ampm": _list[index].ampm,
        "active": activestatus.toString(),
      },
    );
    if (!activestatus) {
      await NotificationService().canclenotification(_list[index].id);
    } else {
      await NotificationService().schedulenotification(
        _list[index].id,
        "Quote of the Day",
        "$todayquote\n\n- Click to open the app for new quotes.",
        _list[index].hour,
        _list[index].minute,
        _list[index].ampm,
      );
    }
    final _id = _list[index].id;
    final _hour = _list[index].hour;
    final _minute = _list[index].minute;
    final _ampm = _list[index].ampm;
    _list.removeAt(index);
    _list.add(
      NotificationModel(
        id: _id,
        hour: _hour,
        minute: _minute,
        ampm: _ampm,
        active: activestatus,
      ),
    );
    if (_list.length > 1) {
      _list.sort((a, b) => a.id.compareTo(b.id));
    }
    _listsink.add(_list);
  }

  editlist(
    List<NotificationModel> fromlist,
    int index,
    String newid,
    TimeOfDay pickedtime,
    String todayquote,
  ) async {
    List<NotificationModel> _list = fromlist;
    await NotificationDbHelper.delete(_list[index].id.toString());
    if (_list[index].active) {
      await NotificationService().canclenotification(_list[index].id);
    }
    _list.removeAt(index);
    int _hour = pickedtime.hour;
    String _ampm = "AM";
    if (pickedtime.hour > 12) {
      _hour = pickedtime.hour - 12;
      _ampm = "PM";
    }
    await NotificationDbHelper.insert(
      {
        "id": newid,
        "hour": _hour.toString().length == 1
            ? "0${_hour.toString()}"
            : _hour.toString(),
        "minute": pickedtime.minute.toString().length == 1
            ? "0${pickedtime.minute.toString()}"
            : pickedtime.minute.toString(),
        "ampm": _ampm,
        "active": "true",
      },
    );
    await NotificationService().schedulenotification(
      int.parse(newid),
      "Quote of the Day",
      "$todayquote\n\n- Click to open the app for new quotes.",
      _hour.toString().length == 1 ? "0${_hour.toString()}" : _hour.toString(),
      pickedtime.minute.toString().length == 1
          ? "0${pickedtime.minute.toString()}"
          : pickedtime.minute.toString(),
      _ampm,
    );
    _list.add(
      NotificationModel(
        id: int.parse(newid),
        hour: _hour.toString().length == 1
            ? "0${_hour.toString()}"
            : _hour.toString(),
        minute: pickedtime.minute.toString().length == 1
            ? "0${pickedtime.minute.toString()}"
            : pickedtime.minute.toString(),
        ampm: _ampm,
        active: true,
      ),
    );
    if (_list.length > 1) {
      _list.sort((a, b) => a.id.compareTo(b.id));
    }
    _listsink.add(_list);
  }

  deletelist(
    List<NotificationModel> fromlist,
    int index,
  ) async {
    List<NotificationModel> _list = fromlist;
    if (_list[index].active) {
      await NotificationService().canclenotification(_list[index].id);
    }
    await NotificationDbHelper.delete(_list[index].id.toString());
    _list.removeAt(index);
    if (_list.length > 1) {
      _list.sort((a, b) => a.id.compareTo(b.id));
    }
    _listsink.add(_list);
    Get.snackbar(
      "Success",
      "Notification Removed.",
      colorText: whit,
      backgroundColor: Colors.green[200],
    );
  }

  addintolist(
    List<NotificationModel> fromlist,
    String newid,
    TimeOfDay pickedtime,
    String todayquote,
  ) async {
    List<NotificationModel> _list = fromlist;
    int _hour = pickedtime.hour;
    String _ampm = "AM";
    if (pickedtime.hour > 12) {
      _hour = pickedtime.hour - 12;
      _ampm = "PM";
    }
    await NotificationDbHelper.insert(
      {
        "id": newid,
        "hour": _hour.toString().length == 1
            ? "0${_hour.toString()}"
            : _hour.toString(),
        "minute": pickedtime.minute.toString().length == 1
            ? "0${pickedtime.minute.toString()}"
            : pickedtime.minute.toString(),
        "ampm": _ampm,
        "active": "true",
      },
    );
    await NotificationService().schedulenotification(
      int.parse(newid),
      "Quote of the Day",
      "$todayquote\n\n- Click to open the app for new quotes.",
      _hour.toString().length == 1 ? "0${_hour.toString()}" : _hour.toString(),
      pickedtime.minute.toString().length == 1
          ? "0${pickedtime.minute.toString()}"
          : pickedtime.minute.toString(),
      _ampm,
    );
    _list.add(
      NotificationModel(
        id: int.parse(newid),
        hour: _hour.toString().length == 1
            ? "0${_hour.toString()}"
            : _hour.toString(),
        minute: pickedtime.minute.toString().length == 1
            ? "0${pickedtime.minute.toString()}"
            : pickedtime.minute.toString(),
        ampm: _ampm,
        active: true,
      ),
    );
    if (_list.length > 1) {
      _list.sort((a, b) => a.id.compareTo(b.id));
    }
    _listsink.add(_list);
  }

  void dispose() {
    _listcontroller.close();
  }
}

  // activationchange(
  //   String id,
  //   String hour,
  //   String minute,
  //   String ampm,
  //   String active,
  //   Function done,
  // ) async {
  //   await NotificationDbHelper.insert(
  //     {
  //       "id": id,
  //       "hour": hour,
  //       "minute": minute,
  //       "ampm": ampm,
  //       "active": active,
  //     },
  //   );
  //   done();
  // }


  /////
  ///
  ///
  ///

  // addnewnotification(
  //   String id,
  //   TimeOfDay pickedtime,
  //   Function addintolist,
  // ) async {
  //   int _hour = 0;
  //   String _ampm = "AM";
  //   if (pickedtime.hour > 12) {
  //     _hour = pickedtime.hour - 12;
  //     _ampm = "PM";
  //   } else {
  //     _hour = pickedtime.hour;
  //   }
  //   await NotificationDbHelper.insert(
  //     {
  //       "id": id,
  //       "hour": _hour.toString().length == 1
  //           ? "0${_hour.toString()}"
  //           : _hour.toString(),
  //       "minute": pickedtime.minute.toString().length == 1
  //           ? "0${pickedtime.minute.toString()}"
  //           : pickedtime.minute.toString(),
  //       "ampm": _ampm,
  //       "active": "true",
  //     },
  //   );
  //   addintolist(
  //     _hour.toString().length == 1 ? "0${_hour.toString()}" : _hour.toString(),
  //     pickedtime.minute.toString().length == 1
  //         ? "0${pickedtime.minute.toString()}"
  //         : pickedtime.minute.toString(),
  //     _ampm,
  //     true,
  //   );
  // }
