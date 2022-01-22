
class Note{
  final int id;
  final String title;
  final String note;
    Note({
      required this.id,
      required this.title,
      required this.note
      });
 Map<String,dynamic>toMap(){
   return {
     'id':id,
     'title':title,
     'note':note
   };
   @override
  String toString() {
    return 'Note{id: $id, title: $title, note: $note}';
  }
 }     
}