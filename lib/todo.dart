import 'package:flutter/material.dart';
import 'Model/todo.dart';
import 'Data/database.dart';



class Todo extends StatefulWidget {

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo>{

  final TextEditingController textController = TextEditingController();

  // database Model
  todoModel db = todoModel();

  @override
  void initState() {
    // TODO: implement initState    

    if(db.myBox.get('tasks') == null){
      db.createDummyData();
    }
    else {
    db.loadDatabase();
    }
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    //Add TASK Method
    addText(){
      String value = textController.text;

      if(value.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(" Please Add Text "), backgroundColor: Colors.red));
      }

      else{
      setState(() {
        db.myList.add(listModel(text: value));
        db.updateDatabase();

        FocusManager.instance.primaryFocus!.unfocus();
        textController.clear();
      });
      }

    }

    themeToggleMethod(){

      setState(() {

        db.themeToggle = !db.themeToggle;

        if (db.themeToggle == false){

          todoModel.themeNotifier.value = ThemeMode.dark;
          //MyApp.of(context).changeTheme(ThemeMode.light);
        }
        else{
          todoModel.themeNotifier.value = ThemeMode.light;
        }
        
      });
    }



    //Remove TASK Method
    deleteTask(int index) => setState((){
      db.myList.removeAt(index);
      db.updateDatabase();
      });


    // Widget
    return Scaffold(

        appBar: AppBar(
          title: TextFormField(
            controller: textController,
            decoration: InputDecoration(
                labelText: " Enter Your Text ",
                // labelStyle: TextStyle(color: Colors.black87),
                floatingLabelStyle: TextStyle(color: Colors.red.shade900),
                contentPadding: EdgeInsets.all(20),
                suffixIcon: IconButton(
                  onPressed: () => addText(),
                  icon: CircleAvatar(
                      child: Icon(Icons.add, color: Colors.white),
                      backgroundColor: Colors.red),
                  iconSize: 50,
                  padding: EdgeInsets.all(3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide:  const BorderSide(color: Colors.red)
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(width: 5)
                )),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            padding: EdgeInsets.all(18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("All ToDos", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: ()=>themeToggleMethod(),
                  icon: Icon(db.themeToggle == true ? Icons.lightbulb_outline_rounded : Icons.lightbulb, size: 28))
              ],
            ),
            alignment: Alignment.bottomLeft,
          ),

          toolbarHeight: 220,
          backgroundColor: Colors.grey.withAlpha(25),
          elevation: 0,

        ),

        body: Container(
          padding: EdgeInsets.all(5),
          
          child: ListView.builder(
            itemCount: db.myList.length == Null ? 0 : db.myList.length,
            itemBuilder: (context, index){

              return Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 15,
                    child: ListTile(

                    leading: Checkbox(
                      fillColor: MaterialStateProperty.all(Colors.red),
                      value: db.myList[index].isChecked, onChanged: (bool? e)=>setState(() => db.myList[index].isChecked = e!,
                      )),
                    title: Text(
                      "${db.myList[index].text}",
                      style: TextStyle(//color: Colors.black,
                      decoration: db.myList[index].isChecked == true ? TextDecoration.lineThrough : TextDecoration.none)),
                      trailing: IconButton(onPressed: ()=>deleteTask(index), icon: const Icon(Icons.delete_rounded, color: Colors.red)),
                  ),
                ),
              );
            

            }),
        )



      );
  }
}