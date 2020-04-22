class User {
    List<Attending> attending;
    Credentials credentials;

    User({this.attending, this.credentials});

    factory User.fromJson(Map<String, dynamic> json) {
        return User(
            attending: json['attending'] != null ? (json['attending'] as List).map((i) => Attending.fromJson(i)).toList() : null,
            credentials: json['credentials'] != null ? Credentials.fromJson(json['credentials']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.attending != null) {
            data['attending'] = this.attending.map((v) => v.toJson()).toList();
        }
        if (this.credentials != null) {
            data['credentials'] = this.credentials.toJson();
        }
        return data;
    }
}

class Attending {
    int attending;
    String cap;
    String category;
    String description;
    String endTime;
    String imageUrl;
    String link;
    String name;
    String organizer;
    List<String> participants;
    String startTime;

    Attending({this.attending, this.cap, this.category, this.description, this.endTime, this.imageUrl, this.link, this.name, this.organizer, this.participants, this.startTime});

    factory Attending.fromJson(Map<String, dynamic> json) {
        return Attending(
            attending: json['attending'],
            cap: json['cap'],
            category: json['category'],
            description: json['description'],
            endTime: json['endTime'],
            imageUrl: json['imageUrl'],
            link: json['link'],
            name: json['name'],
            organizer: json['organizer'],
            participants: json['participants'] != null ? new List<String>.from(json['participants']) : null,
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

class Credentials {
    List<String> attending;
    String createdAt;
    String email;
    String imageUrl;
    String userId;
    String userName;

    Credentials({this.attending, this.createdAt, this.email, this.imageUrl, this.userId, this.userName});

    factory Credentials.fromJson(Map<String, dynamic> json) {
        return Credentials(
            attending: json['attending'] != null ? new List<String>.from(json['attending']) : null,
            createdAt: json['createdAt'],
            email: json['email'],
            imageUrl: json['imageUrl'],
            userId: json['userId'],
            userName: json['userName'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['createdAt'] = this.createdAt;
        data['email'] = this.email;
        data['imageUrl'] = this.imageUrl;
        data['userId'] = this.userId;
        data['userName'] = this.userName;
        if (this.attending != null) {
            data['attending'] = this.attending;
        }
        return data;
    }
}