class ForumItem{
  String title;
  String replier;
  String resume;
  String bestReply;
  int replies;
  DateTime time;

  ForumItem({this.title, this.replier, this.resume, this.bestReply, this.replies, this.time});
}
// ForumItem (String title, String resume, String bestReply, int replies, DateTime time)
/*
ListView.builder(
        itemCount: _listViewData.length,
        itemBuilder: (context, index) => Container(
              color: _selectedIndex != null && _selectedIndex == index
                  ? Colors.red
                  : Colors.white,
              child: ListTile(
                title: Text(_listViewData[index]),
                onTap: () => _onSelected(index),
              ),
            ),
      ),
 */