import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  getPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: false,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("Request Granted");
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print("Provisional State Granted");
    } else {
      return null;
    }
  }

  getDeviceToken() async {
    String? token = await messaging.getToken();

    await FirebaseFirestore.instance.collection('tokens').doc(FirebaseAuth.instance.currentUser!.uid).set({
      'token': token,
    });
  }

  initNotification(BuildContext context) async {
    RemoteMessage? remoteMessage = await messaging.getInitialMessage();
    if (remoteMessage != null) {
      print("Notification When App Launch");
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
      if (remoteMessage != null) {
        print("Notification in Foreground State");
        if (Platform.isAndroid) {
          initLocalNotifications(context, remoteMessage);
          showNotification(context, remoteMessage);
        } else {
          showNotification(context, remoteMessage);
        }
        //here we will use local notification for Handling;
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      print("Notification In background State");
    });
  }

  void initLocalNotifications(BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSetting =
        InitializationSettings(android: androidInitializationSettings, iOS: iosInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {
      // handleMessage(context, message, message.data['userId']);
    });
  }

  Future<void> showNotification(BuildContext context, RemoteMessage message) async {
    initLocalNotifications(context, message);
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(100000).toString(),
      "High Importance Notification",
      importance: Importance.max,
    );
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: "your channel description",
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      presentSound: true,
      presentBadge: true,
      presentAlert: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
      );
    });
  }

  sendPushNotification(String userId, String title, String body) async {
    try {
      DocumentSnapshot snap = await FirebaseFirestore.instance.collection('tokens').doc(userId).get();
      await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization":
              "key=AAAAmbq5PZs:APA91bE6Vq-6RvKczwk5HtpuZlYw-gAEgwnAEXXZOER8tnZ2zv5UIPmR8APvp8NHyP-iYkOSRahGxfjqC5isM6dnCiZjC5zleZDufAW8thH3PvigCL51ud8NzlKKvfnExusvZREHeco5"
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': "high",
            "data": <String, dynamic>{
              "click_action": "FLUTTER_NOTIFICATION_CLICK",
              "id": '1',
              "status": "done",
            },
            "notification": <String, dynamic>{
              "title": title,
              "body": body,
              // "android_channel_id": "abc",
            },
            "to": snap['token'],
          },
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  addNotificationInDB({required String supplierId, required String title}) async {
    try {
      DocumentSnapshot snap =
          await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
      await FirebaseFirestore.instance.collection('notifications').add({
        'toUserId': supplierId,
        'fromUserId': FirebaseAuth.instance.currentUser!.uid,
        'createdAt': DateTime.now(),
        'userImage': snap['image'],
        'userName': snap['userName'],
        'title': title,
      });
    } on FirebaseException catch (e) {
      EasyLoading.showError(e.message!);
    }
  }
}
