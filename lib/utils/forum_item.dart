class ForumItem{
  String title;
  String replier;
  String resume;
  String bestReply;
  int replies;
  DateTime time;
  bool isFavorite = false;
  String author;

  ForumItem(this.title, this.replier, this.author, this.resume, this.bestReply, this.replies, this.time, this.isFavorite);
}
