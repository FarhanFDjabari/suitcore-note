import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'base_refresher_status.dart';

abstract class BaseObjectController<T> extends GetxController {
  BaseObjectController({this.id});

  Box<T>? box;
  String? id = "0";
  T? mData;
  String message = "";
  RefresherStatus status = RefresherStatus.initial;

  bool get isInitial => status == RefresherStatus.initial;
  bool get isLoading => status == RefresherStatus.loading;

  /// **Note:**
  /// loading with no data from the beginning
  bool get isShimmering => isLoading && isEmptyData;

  bool get isEmptyData => status == RefresherStatus.empty || mData == null;
  bool get isSuccess => status == RefresherStatus.success;
  bool get isError => status == RefresherStatus.failed;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  /// **NOTE:**
  /// make sure you call this method at initial state, before you call method [saveCache]
  Future<void> getCacheBox(String hiveConst, {String? custoumId}) async {
    box = Hive.box<T>(hiveConst);
    if (box != null) {
      var obj = box?.get(custoumId ?? id);
      _setFinishCallbacks(obj);
    }
  }

  /// Save the data and Finish (Don't need to call [finishLoadData])
  Future<void> saveCacheBoxAndFinish(T? data, {String hiveConst = ''}) async {
    if (box == null) {
      box = Hive.box<T>(hiveConst);
    }
    box?.put(id, data!);
    _setFinishCallbacks(data);
  }

  /// Change state to Loading State
  void loadingState() {
    status = RefresherStatus.loading;
    update();
  }

  /// **Note:**
  /// the state will go to error state if the [errorMessage] is not null,
  /// call this [finishLoadData] instead [saveCacheBoxAndFinish] if the data is not require to saved in local data
  void finishLoadData({String? errorMessage}) {
    finishRefresh();
    if (errorMessage != null) {
      _setErrorStatus(errorMessage);
    } else {
      status = RefresherStatus.success;
    }
    update();
  }

  void _setData(T data) {
    if (data != null) {
      this.mData = data;
    }
  }

  void _setFinishCallbacks(T? data) {
    if (data == null) {
      status = RefresherStatus.empty;
    } else {
      _setData(data);
      status = RefresherStatus.success;
    }
    finishRefresh();
    update();
  }

  void _setErrorStatus(String message) {
    status = RefresherStatus.failed;
    message = (message.isNotEmpty) ? message : "Something when wrong..";
    Get.snackbar('txt_error_title'.tr, message.toString(),
        backgroundColor: Colors.red, colorText: Colors.white);
  }

  void finishRefresh() {
    if (refreshController.isRefresh) {
      refreshController.refreshCompleted();
    }
    if (refreshController.isLoading) {
      refreshController.loadComplete();
    }
  }

  Future<void> showLoading({String? message}) async {
    if (Get.overlayContext != null && Get.isOverlaysClosed) {
      showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [CircularProgressIndicator()],
              ),
            ),
          ),
        ),
      );
    }
  }

  dismissLoading() {
    if (Get.overlayContext != null) {
      Navigator.of(Get.overlayContext!).pop();
    }
  }
}
