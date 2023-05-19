class MessageModel {
  String? sender;
  String? text;
  bool? seen;
  DateTime? createAt;

  MessageModel({
    this.sender,
    this.text,
    this.seen,
    this.createAt,
  });

  MessageModel.fromMap(Map<String, dynamic> map) {
    sender = map['sender'];
    text = map['text'];
    seen = map['seen'];
    createAt = map['createat'];
  }

  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'text': text,
      'seen': seen,
      'createat': createAt,
    };
  }
}
