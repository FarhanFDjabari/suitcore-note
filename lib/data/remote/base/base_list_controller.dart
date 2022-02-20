import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'base_refresher_status.dart';

abstract class BaseListController<T> extends GetxController {
  Box<T>? box;
  List<T> dataList = [];
  int page = 1;
  bool hasNext = false;
  int perPage = 10;
  String message = "";
  RefresherStatus status = RefresherStatus.loading;

  bool get isInitial => status == RefresherStatus.initial;
  bool get isLoading => status == RefresherStatus.loading;

  /// **Note:**
  /// loading with no data from the beginning
  bool get isShimmering => isLoading && isEmptyData;

  bool get isEmptyData => dataList.isEmpty;
  bool get isSuccess => status == RefresherStatus.success;
  bool get isError => status == RefresherStatus.failed;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void refreshPage();
  void loadNextPage();

  /// **NOTE:**
  /// make sure you call this method at initial state, before you call method [saveCache]
  Future<void> getCacheBox(String _cacheBoxName) async {
    box = Hive.box<T>(_cacheBoxName);
    loadingState();
    List<T> list = [];
    list.addAll(box?.values ?? []);
    _setFinishCallbacks(list);
  }

  /// **NOTE:**
  /// [idList] is list id of the data you pass, make sure it is sort the same way like the list of [datas],
  /// don't need to call [finishLoadData] anymore
  void saveCacheAndFinish(List<T>? datas, {required Iterable<String>? idList}) {
    if (datas != null && box != null) {
      box!.clear();
      datas.asMap().forEach((index, value) {
        box!.put(idList?.toList()[index], value);
      });
      finishLoadData(list: datas);
    }
  }

  /// **Note:**
  /// the state will go to error state if the [errorMessage] is not null,
  /// call this [finishLoadData] instead [saveCacheAndFinish] if the data is not require to saved in local data
  void finishLoadData({
    String errorMessage = "",
    List<T> list = const [],
  }) {
    if (errorMessage.isNotEmpty) {
      _setErrorStatus(errorMessage);
    } else {
      if (list.isNotEmpty) {
        status = RefresherStatus.success;
        _setFinishCallbacks(list);
      } else {
        status = RefresherStatus.empty;
      }
    }
    update();
  }

  /// **NOTE:**
  /// call this to change state to Loading State
  loadingState() {
    status = RefresherStatus.loading;
    update();
  }

  void _addData(List<T> data) {
    if (data.isNotEmpty) {
      this.dataList.addAll(data);
    }
  }

  void _setFinishCallbacks(List<T> list) {
    _addData(list);
    status = RefresherStatus.success;
    _finishRefresh();
    update();
  }

  void _setErrorStatus(String message) {
    status = RefresherStatus.failed;
    message = (message.isNotEmpty) ? message : "Something when wrong..";
    Get.snackbar('txt_error_title'.tr, message.toString());
  }

  void _finishRefresh() {
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
