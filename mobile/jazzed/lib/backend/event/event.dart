class Event {
  int attending;
  int cap;
  String category;
  String description;
  String endTime;
  String eventId;
  String imageUrl;
  String link;
  String name;
  String organizer;
  List<String> participants;
  String startTime;

  Event(
      {this.attending,
      this.cap,
      this.category,
      this.description,
      this.endTime,
      this.eventId,
      this.imageUrl,
      this.link,
      this.name,
      this.organizer,
      this.participants,
      this.startTime});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      attending: json['attending'],
      cap: int.parse(json['cap'].toString()),
      category: json['category'],
      description: json['description'],
      endTime: json['endTime'],
      eventId: json['eventId'],
      imageUrl: json['imageUrl'],
      link: json['link'],
      name: json['name'],
      organizer: json['organizer'],
      participants: json['participants'] != null
          ? new List<String>.from(json['participants'])
          : null,
      startTime: json['startTime'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attending'] = this.attending;
    data['cap'] = this.cap;
    data['category'] = this.category;
    data['description'] = this.description;
    data['endTime'] = this.endTime;
    data['eventId'] = this.eventId;
    data['imageUrl'] = this.imageUrl;
    data['link'] = this.link;
    data['name'] = this.name;
    data['organizer'] = this.organizer;
    data['startTime'] = this.startTime;
    if (this.participants != null) {
      data['participants'] = this.participants;
    }
    return data;
  }
}
