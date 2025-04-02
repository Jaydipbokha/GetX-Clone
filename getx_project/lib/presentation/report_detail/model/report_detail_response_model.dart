class GetReportModel {
  GetReportModel({
    required this.draw,
    required this.recordsTotal,
    required this.recordsFiltered,
    required this.data,
    required this.search,
    required this.totals,
  });

  final num? draw;
  final num? recordsTotal;
  final num? recordsFiltered;
  final Data? data;
  final String? search;
  final Totals? totals;

  factory GetReportModel.fromJson(Map<String, dynamic> json){
    return GetReportModel(
      draw: json["draw"],
      recordsTotal: json["recordsTotal"],
      recordsFiltered: json["recordsFiltered"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      search: json["search"],
      totals: json["totals"] == null ? null : Totals.fromJson(json["totals"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "draw": draw,
    "recordsTotal": recordsTotal,
    "recordsFiltered": recordsFiltered,
    "data": data?.toJson(),
    "search": search,
    "totals": totals?.toJson(),
  };

}

class Data {
  Data({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  final num? currentPage;
  final List<Datum> data;
  final String? firstPageUrl;
  final num? from;
  final num? lastPage;
  final String? lastPageUrl;
  final List<Link> links;
  final String? nextPageUrl;
  final String? path;
  final num? perPage;
  final dynamic prevPageUrl;
  final num? to;
  final num? total;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      currentPage: json["current_page"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      firstPageUrl: json["first_page_url"],
      from: json["from"],
      lastPage: json["last_page"],
      lastPageUrl: json["last_page_url"],
      links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
      nextPageUrl: json["next_page_url"],
      path: json["path"],
      perPage: json["per_page"],
      prevPageUrl: json["prev_page_url"],
      to: json["to"],
      total: json["total"],
    );
  }

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data.map((x) => x?.toJson()).toList(),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links.map((x) => x?.toJson()).toList(),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };

}

class Datum {
  Datum({
    required this.id,
    required this.saledate,
    required this.netamount,
    required this.cashAmount,
    required this.onlineAmount,
  });

  final num? id;
  final String? saledate;
  String? netamount;
  num? cashAmount;
  num? onlineAmount;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["id"],
      saledate: json["saledate"],
      netamount: json["netamount"],
      cashAmount: json["cash_amount"],
      onlineAmount: json["online_amount"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "saledate": saledate,
    "netamount": netamount,
    "cash_amount": cashAmount,
    "online_amount": onlineAmount,
  };

}

class Link {
  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  final String? url;
  final String? label;
  final bool? active;

  factory Link.fromJson(Map<String, dynamic> json){
    return Link(
      url: json["url"],
      label: json["label"],
      active: json["active"],
    );
  }

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };

}

class Totals {
  Totals({
    required this.totalNetAmount,
    required this.totalCashAmount,
    required this.totalOnlineAmount,
  });

  final num? totalNetAmount;
  final num? totalCashAmount;
  final num? totalOnlineAmount;

  factory Totals.fromJson(Map<String, dynamic> json){
    return Totals(
      totalNetAmount: json["totalNetAmount"],
      totalCashAmount: json["totalCashAmount"],
      totalOnlineAmount: json["totalOnlineAmount"],
    );
  }

  Map<String, dynamic> toJson() => {
    "totalNetAmount": totalNetAmount,
    "totalCashAmount": totalCashAmount,
    "totalOnlineAmount": totalOnlineAmount,
  };

}
