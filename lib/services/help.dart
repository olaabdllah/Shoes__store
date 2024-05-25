import 'package:flutter/services.dart' as the_bundle;
import 'package:flutter_application_1/models/sneaker_model.dart';

class Helper {
  Future<List<Sneakers>> getMaleSneakers() async {
    final data = await the_bundle.rootBundle.loadString("json/men_shoes.json");
    final maleList = snekersFromJson(data);
    return maleList;
  }

  Future<List<Sneakers>> getFemaleSneakers() async {
    final data = await the_bundle.rootBundle.loadString("json/women_shoes.json");
    final femaleList = snekersFromJson(data);
    return femaleList;
  }

  Future<List<Sneakers>> getKidsSneakers() async {
    final data = await the_bundle.rootBundle.loadString("json/kids_shoes.json");
    final kidsList = snekersFromJson(data);
    return kidsList;
  }

//male
  Future<Sneakers> getMaleSneakersById(String id) async {
    final data = await the_bundle.rootBundle.loadString("json/men_shoes.json");
    final maleList = snekersFromJson(data);
    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);
    return sneaker;
  }

//female
  Future<Sneakers> getFealeSneakersById(String id) async {
    final data =
        await the_bundle.rootBundle.loadString("json/women_shoes.json");
    final femaleList = snekersFromJson(data);
    final sneaker = femaleList.firstWhere((sneaker) => sneaker.id == id);
    return sneaker;
  }

//kids
  Future<Sneakers> getKidsSneakersById(String id) async {
    final data = await the_bundle.rootBundle.loadString("json/kids_shoes.json");
    final kidsList = snekersFromJson(data);
    final sneaker = kidsList.firstWhere((sneaker) => sneaker.id == id);
    return sneaker;
  }
}
