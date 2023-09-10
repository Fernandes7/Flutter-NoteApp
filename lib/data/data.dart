import 'package:crud/data/getalldata/getalldata.dart';
import 'package:crud/data/notedata/notedata.dart';
import 'package:crud/data/urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class Apicalls {
  Future<Notedata?> createNote(Notedata value);
  Future<List<Notedata>?> getAllnote();
  Future<Notedata?> updateNote(Notedata value);
  Future<void> deletNote(String id);
}

class NoteDB implements Apicalls {
  NoteDB._internal();
  static NoteDB instance = NoteDB._internal();
  NoteDB factory() {
    return instance;
  }

  final dio = Dio();
  final url = Url();
  ValueNotifier<List<Notedata>> noteListNotifier = ValueNotifier([]);

  NoteDB() {
    dio.options = BaseOptions(
      baseUrl: url.baseurl,
      responseType: ResponseType.plain,
    );
  }
  @override
  Future<Notedata?> createNote(Notedata value) async {
    try {
      final result =
          await dio.post(url.baseurl + url.createnote, data: value.toJson());
      final note = Notedata.fromJson(result.data);
      noteListNotifier.value.insert(0, note);
      noteListNotifier.notifyListeners();
      return note;
    } on DioError catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    throw UnimplementedError();
  }

  @override
  Future<void> deletNote(String id) async {
    final result =
        await dio.delete(url.baseurl + url.deletenode.replaceFirst("{id}", id));
    if (result.data == null) {
      return;
    }
    final index =
        noteListNotifier.value.indexWhere((element) => element.id == id);
    if (index == -1) {
      return;
    }
    noteListNotifier.value.removeAt(index);
    noteListNotifier.notifyListeners();
    throw UnimplementedError();
  }

  @override
  Future<List<Notedata>> getAllnote() async {
    final result = await dio.get(url.baseurl + url.getallnote);
    if (result.data == null) {
      return [];
    } else {
      final getNoteResp = Getalldata.fromJson(result.data);
      noteListNotifier.value.clear();
      noteListNotifier.value.addAll(getNoteResp.data);
      noteListNotifier.notifyListeners();
      return getNoteResp.data;
    }
  }

  @override
  Future<Notedata?> updateNote(Notedata value) async {
    final result =
        await dio.put(url.baseurl + url.updatenote, data: value.toJson());
    if (result.data == null) {
      return null;
    }
    final indexs =
        noteListNotifier.value.indexWhere((element) => element.id == value.id);
    if (indexs == -1) {
      return null;
    }
    noteListNotifier.value.removeAt(indexs);
    noteListNotifier.value.insert(indexs, value);
    noteListNotifier.notifyListeners();
    return value;
  }

  Notedata? getNotebyId(String id) {
    try {
      return noteListNotifier.value.firstWhere((note) => note.id == id);
    } catch (e) {
      return null;
    }
  }
}
