
/// medicine order model

class orderDetailClass {
  int? status;
  String? msg;
  OrderDetailData? data;

  orderDetailClass({this.status, this.msg, this.data});

  orderDetailClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new OrderDetailData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class OrderDetailData {
  int? id;
  int? pharmacyId;
  int? userId;
  int? orderType;
  String?paymentType;
  dynamic transactionId;
  dynamic status;
  dynamic prescription;
  dynamic phone;
  String? address;
  String? message;
  dynamic taxPr;
  dynamic tax;
  dynamic deliveryCharge;
  dynamic total;
  String? createdAt;
  String? updatedAt;
  int? isCompleted;
  dynamic subtotal;
  dynamic prescriptionPrice;
  String? pharmacyName;
  String? pharmacyAddress;
  String? pharmacyEmail;
  dynamic pharmacyPhoneno;
  String? pharmacyImage;
  List<OrderMedicine>? medicine;
  String? userImage;
  String? userName;
  String? userEmail;
  dynamic adminDeliveryCharge;
  dynamic adminTax;

  OrderDetailData(
      {this.id,
        this.pharmacyId,
        this.userId,
        this.orderType,
        this.paymentType,
        this.transactionId,
        this.status,
        this.prescription,
        this.phone,
        this.address,
        this.message,
        this.taxPr,
        this.tax,
        this.deliveryCharge,
        this.total,
        this.createdAt,
        this.updatedAt,
        this.isCompleted,
        this.subtotal,
        this.prescriptionPrice,
        this.pharmacyName,
        this.pharmacyAddress,
        this.pharmacyEmail,
        this.pharmacyPhoneno,
        this.pharmacyImage,
        this.medicine,
        this.userImage,
        this.userName,
        this.userEmail,
        this.adminDeliveryCharge,
        this.adminTax,

      });

  OrderDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pharmacyId = json['Pharmacy_id'];
    userId = json['user_id'];
    orderType = json['order_type'];
    paymentType = json['payment_type'];
    transactionId = json['transaction_id'];
    status = json['status'];
    prescription = json['prescription'];
    phone = json['phone'];
    address = json['address'];
    message = json['message'];
    taxPr = json['tax_pr'];
    tax = json['tax'];
    deliveryCharge = json['delivery_charge'];
    total = json['total'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isCompleted = json['is_completed'];
    subtotal = json['subtotal'];
    prescriptionPrice = json['prescription_price'];
    pharmacyName = json['Pharmacy_name'];
    pharmacyAddress = json['Pharmacy_address'];
    pharmacyEmail = json['Pharmacy_email'];
    pharmacyPhoneno = json['Pharmacy_phoneno'];
    pharmacyImage = json['Pharmacy_image'];
    if (json['medicine'] != null) {
      medicine = <OrderMedicine>[];
      json['medicine'].forEach((v) {
        medicine!.add(new OrderMedicine.fromJson(v));
      });
    }
    userImage = json['user_image'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    adminDeliveryCharge = json['admin_delivery_charge'];
    adminTax = json['admin_tax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Pharmacy_id'] = this.pharmacyId;
    data['user_id'] = this.userId;
    data['order_type'] = this.orderType;
    data['payment_type'] = this.paymentType;
    data['transaction_id'] = this.transactionId;
    data['status'] = this.status;
    data['prescription'] = this.prescription;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['message'] = this.message;
    data['tax_pr'] = this.taxPr;
    data['tax'] = this.tax;
    data['delivery_charge'] = this.deliveryCharge;
    data['total'] = this.total;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_completed'] = this.isCompleted;
    data['subtotal'] = this.subtotal;
    data['prescription_price'] = this.prescriptionPrice;
    data['Pharmacy_name'] = this.pharmacyName;
    data['Pharmacy_address'] = this.pharmacyAddress;
    data['Pharmacy_email'] = this.pharmacyEmail;
    data['Pharmacy_phoneno'] = this.pharmacyPhoneno;
    data['Pharmacy_image'] = this.pharmacyImage;
    if (this.medicine != null) {
      data['medicine'] = this.medicine!.map((v) => v.toJson()).toList();
    }
    data['user_image'] = this.userImage;
    data['user_name'] = this.userName;
    data['user_email'] = this.userEmail;
    data['admin_delivery_charge'] = this.adminDeliveryCharge;
    data['admin_tax'] = this.adminTax;
    return data;
  }
}

class OrderMedicine {
  int? id;
  int? orderId;
  int? serviceId;
  dynamic? qty;
  String? name;
  dynamic? price;
  String? createdAt;
  String? updatedAt;
  String? medicineImg;

  OrderMedicine(
      {this.id,
        this.orderId,
        this.serviceId,
        this.qty,
        this.name,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.medicineImg});

  OrderMedicine.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    serviceId = json['service_id'];
    qty = json['qty'];
    name = json['name'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    medicineImg = json['medicine_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['service_id'] = this.serviceId;
    data['qty'] = this.qty;
    data['name'] = this.name;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['medicine_img'] = this.medicineImg;
    return data;
  }
}

/// report model

class reportDetailClass {
  dynamic status;
  dynamic msg;
  ReportDetailData? data;

  reportDetailClass({this.status, this.msg, this.data});

  reportDetailClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new ReportDetailData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ReportDetailData {
  dynamic id;
  dynamic laboratoryId;
  dynamic userId;
  dynamic orderType;
  dynamic paymentType;
  dynamic transactionId;
  dynamic status;
  dynamic reportFile;
  dynamic phone;
  dynamic address;
  dynamic message;
  dynamic taxPr;
  dynamic tax;
  dynamic deliveryCharge;
  dynamic total;
  dynamic testType;
  dynamic prescription;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic isCompleted;
  dynamic reportPrice;
  dynamic subtotal;
  dynamic laboratoryName;
  dynamic laboratoryAddress;
  dynamic laboratoryEmail;
  dynamic laboratoryPhoneno;
  dynamic laboratoryImage;
  List<ReportData>? report;
  dynamic userImage;
  dynamic userName;
  dynamic userEmail;
  dynamic adminDeliveryCharge;
  dynamic adminTax;

  ReportDetailData(
      {this.id,
        this.laboratoryId,
        this.userId,
        this.orderType,
        this.paymentType,
        this.transactionId,
        this.status,
        this.reportFile,
        this.phone,
        this.address,
        this.message,
        this.taxPr,
        this.tax,
        this.deliveryCharge,
        this.total,
        this.testType,
        this.prescription,
        this.createdAt,
        this.updatedAt,
        this.isCompleted,
        this.reportPrice,
        this.subtotal,
        this.laboratoryName,
        this.laboratoryAddress,
        this.laboratoryEmail,
        this.laboratoryPhoneno,
        this.laboratoryImage,
        this.report,
        this.userImage,
        this.userName,
        this.userEmail,
        this.adminDeliveryCharge,
        this.adminTax});

  ReportDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    laboratoryId = json['laboratory_id'];
    userId = json['user_id'];
    orderType = json['order_type'];
    paymentType = json['payment_type'];
    transactionId = json['transaction_id'];
    status = json['status'];
    reportFile = json['report_file'];
    phone = json['phone'];
    address = json['address'];
    message = json['message'];
    taxPr = json['tax_pr'];
    tax = json['tax'];
    deliveryCharge = json['delivery_charge'];
    total = json['total'];
    testType = json['test_type'];
    prescription = json['prescription'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isCompleted = json['is_completed'];
    reportPrice = json['report_price'];
    subtotal = json['subtotal'];
    laboratoryName = json['Laboratory_name'];
    laboratoryAddress = json['Laboratory_address'];
    laboratoryEmail = json['Laboratory_email'];
    laboratoryPhoneno = json['Laboratory_phoneno'];
    laboratoryImage = json['Laboratory_image'];
    if (json['report'] != null) {
      report = <ReportData>[];
      json['report'].forEach((v) {
        report!.add(new ReportData.fromJson(v));
      });
    }
    userImage = json['user_image'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    adminDeliveryCharge = json['admin_delivery_charge'];
    adminTax = json['admin_tax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['laboratory_id'] = this.laboratoryId;
    data['user_id'] = this.userId;
    data['order_type'] = this.orderType;
    data['payment_type'] = this.paymentType;
    data['transaction_id'] = this.transactionId;
    data['status'] = this.status;
    data['report_file'] = this.reportFile;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['message'] = this.message;
    data['tax_pr'] = this.taxPr;
    data['tax'] = this.tax;
    data['delivery_charge'] = this.deliveryCharge;
    data['total'] = this.total;
    data['test_type'] = this.testType;
    data['prescription'] = this.prescription;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_completed'] = this.isCompleted;
    data['report_price'] = this.reportPrice;
    data['subtotal'] = this.subtotal;
    data['Laboratory_name'] = this.laboratoryName;
    data['Laboratory_address'] = this.laboratoryAddress;
    data['Laboratory_email'] = this.laboratoryEmail;
    data['Laboratory_phoneno'] = this.laboratoryPhoneno;
    data['Laboratory_image'] = this.laboratoryImage;
    if (this.report != null) {
      data['report'] = this.report!.map((v) => v.toJson()).toList();
    }
    data['user_image'] = this.userImage;
    data['user_name'] = this.userName;
    data['user_email'] = this.userEmail;
    data['admin_delivery_charge'] = this.adminDeliveryCharge;
    data['admin_tax'] = this.adminTax;
    return data;
  }
}

class ReportData {
  dynamic id;
  dynamic orderId;
  dynamic serviceId;
  dynamic qty;
  dynamic name;
  dynamic price;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic laboratoryImg;

  ReportData(
      {this.id,
        this.orderId,
        this.serviceId,
        this.qty,
        this.name,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.laboratoryImg});

  ReportData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    serviceId = json['service_id'];
    qty = json['qty'];
    name = json['name'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    laboratoryImg = json['laboratory_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['service_id'] = this.serviceId;
    data['qty'] = this.qty;
    data['name'] = this.name;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['laboratory_img'] = this.laboratoryImg;
    return data;
  }
}

