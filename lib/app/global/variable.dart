import 'package:aplikasi_pemesanan_travel/app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
firebase_storage.FirebaseStorage storage =
    firebase_storage.FirebaseStorage.instance;
GetStorage getStorage = GetStorage();

CollectionReference users = firestore.collection("users");
CollectionReference drivers = firestore.collection("drivers");
CollectionReference routes = firestore.collection("routes");
CollectionReference trips = firestore.collection("trips");
CollectionReference orders = firestore.collection("orders");
CollectionReference helps = firestore.collection("helps");
CollectionReference chats = firestore.collection("chats");

var user = UserModel().obs;

String googleMapKey = "AIzaSyA1MgLuZuyqR_OGY3ob3M52N46TDBRI_9k";
