class PharmacyOrder {
  int? status;
  String? msg;
  List<orderdata>? data;

  PharmacyOrder({this.status, this.msg, this.data});

  PharmacyOrder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <orderdata>[];
      json['data'].forEach((v) {
        data!.add(new orderdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class orderdata {
  int? id;
  int? pharmacyId;
  dynamic pharmacyName;
  dynamic pharmacyImage;
  dynamic pharmacyAddress;
  dynamic pharmacyPhoneno;
  dynamic pharmacyEmail;
  int? userId;
  int? orderType;
  String? paymentType;
  dynamic transactionId;
  int? status;
  dynamic prescription;
  int? phone;
  dynamic address;
  dynamic message;
  dynamic total;
  dynamic subtotal;
  dynamic delivery_charge;
  dynamic tax_pr;
  String? createdAt;
  String? updatedAt;
  int? isCompleted;
  List<Medicine>? medicine;

  orderdata(
      {this.id,
        this.pharmacyId,
        this.pharmacyName,
        this.pharmacyImage,
        this.pharmacyAddress,
        this.pharmacyPhoneno,
        this.pharmacyEmail,
        this.userId,
        this.orderType,
        this.paymentType,
        this.transactionId,
        this.status,
        this.prescription,
        this.phone,
        this.address,
        this.message,
        this.total,
        this.subtotal,
        this.delivery_charge,
        this.tax_pr,
        this.createdAt,
        this.updatedAt,
        this.isCompleted,
        this.medicine});

  orderdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pharmacyId = json['Pharmacy_id'];
    pharmacyName = json['Pharmacy_name'];
    pharmacyImage = json['Pharmacy_image'];
    pharmacyAddress = json['Pharmacy_address'];
    pharmacyEmail = json['Pharmacy_email'];
    pharmacyPhoneno = json['Pharmacy_phoneno'];
    userId = json['user_id'];
    orderType = json['order_type'];
    paymentType = json['payment_type'];
    transactionId = json['transaction_id'];
    status = json['status'];
    prescription = json['prescription'];
    phone = json['phone'];
    address = json['address'];
    message = json['message'];
    total = json['total'];
    subtotal = json['subtotal'];
    delivery_charge = json['delivery_charge'];
    tax_pr = json['tax_pr'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isCompleted = json['is_completed'];
    if (json['medicine'] != null) {
      medicine = <Medicine>[];
      json['medicine'].forEach((v) {
        medicine!.add(new Medicine.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Pharmacy_id'] = this.pharmacyId;
    data['Pharmacy_name'] = this.pharmacyName;
    data['Pharmacy_image'] = this.pharmacyImage;
    data['Pharmacy_address'] = this.pharmacyAddress;
    data['Pharmacy_email'] = this.pharmacyEmail;
    data['Pharmacy_phoneno'] = this.pharmacyPhoneno;
    data['user_id'] = this.userId;
    data['order_type'] = this.orderType;
    data['payment_type'] = this.paymentType;
    data['transaction_id'] = this.transactionId;
    data['status'] = this.status;
    data['prescription'] = this.prescription;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['message'] = this.message;
    data['total'] = this.total;
    data['subtotal'] = this.subtotal;
    data['delivery_charge'] = this.delivery_charge;
    data['tax_pr'] = this.tax_pr;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_completed'] = this.isCompleted;
    if (this.medicine != null) {
      data['medicine'] = this.medicine!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Medicine {
  int? id;
  int? orderId;
  int? serviceId;
  int? qty;
  String? name;
  String? medicine_img;
  dynamic? price;
  String? createdAt;
  String? updatedAt;

  Medicine(
      {this.id,
        this.orderId,
        this.serviceId,
        this.qty,
        this.name,
        this.medicine_img,
        this.price,
        this.createdAt,
        this.updatedAt});

  Medicine.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    serviceId = json['service_id'];
    qty = json['qty'];
    name = json['name'];
    medicine_img = json['medicine_img'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['service_id'] = this.serviceId;
    data['qty'] = this.qty;
    data['name'] = this.name;
    data['medicine_img'] = this.medicine_img;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class LaboratoryReport {
  int? status;
  String? msg;
  List<reportdata>? data;

  LaboratoryReport({this.status, this.msg, this.data});

  LaboratoryReport.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <reportdata>[];
      json['data'].forEach((v) {
        data!.add(new reportdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class reportdata {
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
  List<Report>? report;
  dynamic subtotal;
  dynamic laboratoryName;
  dynamic laboratoryAddress;
  dynamic laboratoryEmail;
  dynamic laboratoryPhoneno;
  dynamic laboratoryImage;

  reportdata(
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
        this.report,
        this.subtotal,
        this.laboratoryName,
        this.laboratoryAddress,
        this.laboratoryEmail,
        this.laboratoryPhoneno,
        this.laboratoryImage});

  reportdata.fromJson(Map<String, dynamic> json) {
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
    if (json['report'] != null) {
      report = <Report>[];
      json['report'].forEach((v) {
        report!.add(new Report.fromJson(v));
      });
    }
    subtotal = json['subtotal'];
    laboratoryName = json['laboratory_name'];
    laboratoryAddress = json['laboratory_address'];
    laboratoryEmail = json['laboratory_email'];
    laboratoryPhoneno = json['laboratory_phoneno'];
    laboratoryImage = json['laboratory_image'];
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
    if (this.report != null) {
      data['report'] = this.report!.map((v) => v.toJson()).toList();
    }
    data['subtotal'] = this.subtotal;
    data['laboratory_name'] = this.laboratoryName;
    data['laboratory_address'] = this.laboratoryAddress;
    data['laboratory_email'] = this.laboratoryEmail;
    data['laboratory_phoneno'] = this.laboratoryPhoneno;
    data['laboratory_image'] = this.laboratoryImage;
    return data;
  }
}

class Report {
  dynamic id;
  dynamic orderId;
  dynamic serviceId;
  dynamic qty;
  dynamic name;
  dynamic price;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic reportImg;

  Report(
      {this.id,
        this.orderId,
        this.serviceId,
        this.qty,
        this.name,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.reportImg});

  Report.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    serviceId = json['service_id'];
    qty = json['qty'];
    name = json['name'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    reportImg = json['report_img'];
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
    data['report_img'] = this.reportImg;
    return data;
  }
}
