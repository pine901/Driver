// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  NotificationType notificationType;
  bool? seen;
  String? orderId; // if type == 'deliveryProposal'
  String iconUrl;
  String title;
  String subtitle;
  Timestamp createdAt;
  dynamic data;

  NotificationModel(
      {required this.notificationType,
      this.orderId,
      required this.iconUrl,
      required this.title,
      required this.subtitle,
      required this.createdAt,
      this.data});

  factory NotificationModel.fromMap(Map data) {
    dynamic notificationData;
    switch (NotificationType.values[data['notificationType']]) {
      case NotificationType.PROPOSAL:
        notificationData = ProposalNotificationData.fromMap(data['data']);
        break;
      case NotificationType.INVOICE:
        notificationData = InvoiceNotificationData.fromMap(data['data']);
        break;
      default:
    }

    return NotificationModel(
        notificationType: NotificationType.values[data['notificationType']],
        iconUrl: data['iconUrl'] ?? '',
        title: data['title'],
        subtitle: data['subtitle'],
        createdAt: data['createdAt'],
        data: notificationData);
  }
}

enum NotificationType {
  ORDER,
  PROPOSAL,
  ACCEPTED_PROPOSAL,
  INVOICE,
  OFFER,
  MESSAGE
}

// proposal notification data type
class ProposalNotificationData {
  String proposalId;
  String driverId;
  String deliveryAddress;
  String storeName;
  String fare;

  ProposalNotificationData({
    required this.proposalId,
    required this.driverId,
    required this.deliveryAddress,
    required this.storeName,
    required this.fare,
  });

  factory ProposalNotificationData.fromMap(Map data) {
    return ProposalNotificationData(
        proposalId: data['proposalId'],
        driverId: data['driverId'],
        deliveryAddress: data['deliveryAddress'],
        storeName: data['storeName'],
        fare: data['fare']);
  }
}

// invoice notification data type
class InvoiceNotificationData {
  String invoiceId;
  String orderId;
  String driverId;
  String amount;

  InvoiceNotificationData(
      {required this.invoiceId,
      required this.orderId,
      required this.driverId,
      required this.amount});

  factory InvoiceNotificationData.fromMap(Map data) {
    return InvoiceNotificationData(
        invoiceId: data['invoiceId'],
        orderId: data['orderId'],
        driverId: data['driverId'],
        amount: data['amount']);
  }
}
