class Message {
  final String id;
  final String content;
  final String userFrom;
  final String userTo;
  final DateTime createAt;
  final bool isMine;
  final String regNum;

  Message(
      {required this.id,
      required this.content,
      required this.userFrom,
      required this.userTo,
      required this.createAt,
      required this.isMine,
      required this.regNum});

  Message.create(
      {required this.content,
      required this.userFrom,
      required this.userTo,
      required this.regNum})
      : id = '',
        isMine = true,
        createAt = DateTime.now();

  Message.fromJson(Map<String, dynamic> json, String userId)
      : id = json['id'],
        content = json['content'],
        userFrom = json['user_from'],
        userTo = json['user_to'],
        createAt = DateTime.parse(json['created_at']),
        isMine = json['user_from'] == userId,
        regNum = json["reg_num"];

  Map toMap() {
    return {
      'content': content,
      'user_from': userFrom,
      'user_to': userTo,
      "reg_num": regNum
    };
  }
}
