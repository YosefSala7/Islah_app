// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
    int code;
    String status;
    Data data;

    Welcome({
        required this.code,
        required this.status,
        required this.data,
    });

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        code: json["code"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": data.toJson(),
    };
}

class Data {
    Times times;
    Date date;
    Qibla qibla;
    ProhibitedTimes prohibitedTimes;
    Timezone timezone;

    Data({
        required this.times,
        required this.date,
        required this.qibla,
        required this.prohibitedTimes,
        required this.timezone,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        times: Times.fromJson(json["times"]),
        date: Date.fromJson(json["date"]),
        qibla: Qibla.fromJson(json["qibla"]),
        prohibitedTimes: ProhibitedTimes.fromJson(json["prohibited_times"]),
        timezone: Timezone.fromJson(json["timezone"]),
    );

    Map<String, dynamic> toJson() => {
        "times": times.toJson(),
        "date": date.toJson(),
        "qibla": qibla.toJson(),
        "prohibited_times": prohibitedTimes.toJson(),
        "timezone": timezone.toJson(),
    };
}

class Date {
    String readable;
    String timestamp;
    Hijri hijri;
    Gregorian gregorian;

    Date({
        required this.readable,
        required this.timestamp,
        required this.hijri,
        required this.gregorian,
    });

    factory Date.fromJson(Map<String, dynamic> json) => Date(
        readable: json["readable"],
        timestamp: json["timestamp"],
        hijri: Hijri.fromJson(json["hijri"]),
        gregorian: Gregorian.fromJson(json["gregorian"]),
    );

    Map<String, dynamic> toJson() => {
        "readable": readable,
        "timestamp": timestamp,
        "hijri": hijri.toJson(),
        "gregorian": gregorian.toJson(),
    };
}

class Gregorian {
    DateTime date;
    String format;
    String day;
    GregorianWeekday weekday;
    GregorianMonth month;
    String year;
    Designation designation;

    Gregorian({
        required this.date,
        required this.format,
        required this.day,
        required this.weekday,
        required this.month,
        required this.year,
        required this.designation,
    });

    factory Gregorian.fromJson(Map<String, dynamic> json) => Gregorian(
        date: DateTime.parse(json["date"]),
        format: json["format"],
        day: json["day"],
        weekday: GregorianWeekday.fromJson(json["weekday"]),
        month: GregorianMonth.fromJson(json["month"]),
        year: json["year"],
        designation: Designation.fromJson(json["designation"]),
    );

    Map<String, dynamic> toJson() => {
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "format": format,
        "day": day,
        "weekday": weekday.toJson(),
        "month": month.toJson(),
        "year": year,
        "designation": designation.toJson(),
    };
}

class Designation {
    String abbreviated;
    String expanded;

    Designation({
        required this.abbreviated,
        required this.expanded,
    });

    factory Designation.fromJson(Map<String, dynamic> json) => Designation(
        abbreviated: json["abbreviated"],
        expanded: json["expanded"],
    );

    Map<String, dynamic> toJson() => {
        "abbreviated": abbreviated,
        "expanded": expanded,
    };
}

class GregorianMonth {
    int number;
    String en;

    GregorianMonth({
        required this.number,
        required this.en,
    });

    factory GregorianMonth.fromJson(Map<String, dynamic> json) => GregorianMonth(
        number: json["number"],
        en: json["en"],
    );

    Map<String, dynamic> toJson() => {
        "number": number,
        "en": en,
    };
}

class GregorianWeekday {
    String en;

    GregorianWeekday({
        required this.en,
    });

    factory GregorianWeekday.fromJson(Map<String, dynamic> json) => GregorianWeekday(
        en: json["en"],
    );

    Map<String, dynamic> toJson() => {
        "en": en,
    };
}

class Hijri {
    DateTime date;
    String format;
    String day;
    HijriWeekday weekday;
    HijriMonth month;
    String year;
    Designation designation;
    List<dynamic> holidays;
    List<dynamic> adjustedHolidays;
    String method;

    Hijri({
        required this.date,
        required this.format,
        required this.day,
        required this.weekday,
        required this.month,
        required this.year,
        required this.designation,
        required this.holidays,
        required this.adjustedHolidays,
        required this.method,
    });

    factory Hijri.fromJson(Map<String, dynamic> json) => Hijri(
        date: DateTime.parse(json["date"]),
        format: json["format"],
        day: json["day"],
        weekday: HijriWeekday.fromJson(json["weekday"]),
        month: HijriMonth.fromJson(json["month"]),
        year: json["year"],
        designation: Designation.fromJson(json["designation"]),
        holidays: List<dynamic>.from(json["holidays"].map((x) => x)),
        adjustedHolidays: List<dynamic>.from(json["adjustedHolidays"].map((x) => x)),
        method: json["method"],
    );

    Map<String, dynamic> toJson() => {
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "format": format,
        "day": day,
        "weekday": weekday.toJson(),
        "month": month.toJson(),
        "year": year,
        "designation": designation.toJson(),
        "holidays": List<dynamic>.from(holidays.map((x) => x)),
        "adjustedHolidays": List<dynamic>.from(adjustedHolidays.map((x) => x)),
        "method": method,
    };
}

class HijriMonth {
    int number;
    String en;
    String ar;
    int days;

    HijriMonth({
        required this.number,
        required this.en,
        required this.ar,
        required this.days,
    });

    factory HijriMonth.fromJson(Map<String, dynamic> json) => HijriMonth(
        number: json["number"],
        en: json["en"],
        ar: json["ar"],
        days: json["days"],
    );

    Map<String, dynamic> toJson() => {
        "number": number,
        "en": en,
        "ar": ar,
        "days": days,
    };
}

class HijriWeekday {
    String en;
    String ar;

    HijriWeekday({
        required this.en,
        required this.ar,
    });

    factory HijriWeekday.fromJson(Map<String, dynamic> json) => HijriWeekday(
        en: json["en"],
        ar: json["ar"],
    );

    Map<String, dynamic> toJson() => {
        "en": en,
        "ar": ar,
    };
}

class ProhibitedTimes {
    Noon sunrise;
    Noon noon;
    Noon sunset;

    ProhibitedTimes({
        required this.sunrise,
        required this.noon,
        required this.sunset,
    });

    factory ProhibitedTimes.fromJson(Map<String, dynamic> json) => ProhibitedTimes(
        sunrise: Noon.fromJson(json["sunrise"]),
        noon: Noon.fromJson(json["noon"]),
        sunset: Noon.fromJson(json["sunset"]),
    );

    Map<String, dynamic> toJson() => {
        "sunrise": sunrise.toJson(),
        "noon": noon.toJson(),
        "sunset": sunset.toJson(),
    };
}

class Noon {
    String start;
    String end;

    Noon({
        required this.start,
        required this.end,
    });

    factory Noon.fromJson(Map<String, dynamic> json) => Noon(
        start: json["start"],
        end: json["end"],
    );

    Map<String, dynamic> toJson() => {
        "start": start,
        "end": end,
    };
}

class Qibla {
    Direction direction;
    Distance distance;

    Qibla({
        required this.direction,
        required this.distance,
    });

    factory Qibla.fromJson(Map<String, dynamic> json) => Qibla(
        direction: Direction.fromJson(json["direction"]),
        distance: Distance.fromJson(json["distance"]),
    );

    Map<String, dynamic> toJson() => {
        "direction": direction.toJson(),
        "distance": distance.toJson(),
    };
}

class Direction {
    double degrees;
    String from;
    bool clockwise;

    Direction({
        required this.degrees,
        required this.from,
        required this.clockwise,
    });

    factory Direction.fromJson(Map<String, dynamic> json) => Direction(
        degrees: json["degrees"]?.toDouble(),
        from: json["from"],
        clockwise: json["clockwise"],
    );

    Map<String, dynamic> toJson() => {
        "degrees": degrees,
        "from": from,
        "clockwise": clockwise,
    };
}

class Distance {
    double value;
    String unit;

    Distance({
        required this.value,
        required this.unit,
    });

    factory Distance.fromJson(Map<String, dynamic> json) => Distance(
        value: json["value"]?.toDouble(),
        unit: json["unit"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "unit": unit,
    };
}

class Times {
    String fajr;
    String sunrise;
    String dhuhr;
    String asr;
    String sunset;
    String maghrib;
    String isha;
    String imsak;
    String midnight;
    String firstthird;
    String lastthird;

    Times({
        required this.fajr,
        required this.sunrise,
        required this.dhuhr,
        required this.asr,
        required this.sunset,
        required this.maghrib,
        required this.isha,
        required this.imsak,
        required this.midnight,
        required this.firstthird,
        required this.lastthird,
    });

    factory Times.fromJson(Map<String, dynamic> json) => Times(
        fajr: json["Fajr"],
        sunrise: json["Sunrise"],
        dhuhr: json["Dhuhr"],
        asr: json["Asr"],
        sunset: json["Sunset"],
        maghrib: json["Maghrib"],
        isha: json["Isha"],
        imsak: json["Imsak"],
        midnight: json["Midnight"],
        firstthird: json["Firstthird"],
        lastthird: json["Lastthird"],
    );

    Map<String, dynamic> toJson() => {
        "Fajr": fajr,
        "Sunrise": sunrise,
        "Dhuhr": dhuhr,
        "Asr": asr,
        "Sunset": sunset,
        "Maghrib": maghrib,
        "Isha": isha,
        "Imsak": imsak,
        "Midnight": midnight,
        "Firstthird": firstthird,
        "Lastthird": lastthird,
    };
}

class Timezone {
    String name;
    String utcOffset;
    String abbreviation;

    Timezone({
        required this.name,
        required this.utcOffset,
        required this.abbreviation,
    });

    factory Timezone.fromJson(Map<String, dynamic> json) => Timezone(
        name: json["name"],
        utcOffset: json["utc_offset"],
        abbreviation: json["abbreviation"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "utc_offset": utcOffset,
        "abbreviation": abbreviation,
    };
}
