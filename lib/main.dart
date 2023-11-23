import 'package:flutter/material.dart'; 
 
void main() => runApp(TestApp()); 
 
class TestApp extends StatelessWidget { 
@override 
Widget build(BuildContext context) { 
return MaterialApp( 
title: 'Ремонт оборудования', 
theme: ThemeData( 
primarySwatch: Colors.indigo, 
), 
home: RepairScreen(), 
); 
} 
} 
 
class RepairScreen extends StatefulWidget { 
  @override 
  _RepairScreenState createState() => _RepairScreenState(); 
} 
 
class _RepairScreenState extends State { 
  bool isAuthenticated = false; 
  String passwordInput = ''; 
  
  final TextEditingController _orderNumberController = TextEditingController(); 
  final TextEditingController _descriptionController = TextEditingController(); 
  final TextEditingController _clientController = TextEditingController(); 
  final TextEditingController _dataController = TextEditingController(); 
  final TextEditingController _equipmentController = TextEditingController(); 
 
  List orders = []; 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar(title: Text('Ремонт оборудования')), 
      body: isAuthenticated 
      ? buildAuthenticatedContent() 
      : buildLoginContent(), 
      ); 
      } 
 
  Widget buildLoginContent() { 
    return Padding( 
      padding: const EdgeInsets.all(20.0), 
      child: Column( 
      crossAxisAlignment: CrossAxisAlignment.stretch, 
      children: [ 
        TextField( 
          onChanged: (value) { 
            setState(() { 
              passwordInput = value; 
              }); 
              }, 
              decoration: InputDecoration( 
                labelText: 'Введите пароль', 
                ), 
                ), 
                SizedBox(height:  20), 
                ElevatedButton( 
                  onPressed: () { 
                    if (passwordInput == '1234') { 
                      setState(() { 
                        isAuthenticated = true; 
                        }); 
                        } else { 
                          showDialog( 
                            context: context, 
                            builder: (BuildContext context) { 
                              return AlertDialog( 
                                title: Text('Ошибка'), 
                                content: Text('Неверный пароль'), 
                                actions: [ 
                                  TextButton( 
                                    child: Text('ОК'), 
                                    onPressed: () { 
                                      Navigator.of(context).pop(); 
                                      }, 
                                    ), 
                                  ], 
                                ); 
                              }, 
                            ); 
                          } 
                      }, 
                    child: Text('Войти'), 
                    ),     
                ], 
              ), 
           ); 
          } 
 
  Widget buildAuthenticatedContent() { 
    return DefaultTabController(
      length: 3, 
      child: Scaffold( 
      appBar: AppBar( 
      bottom: TabBar( 
      tabs: [ 
        
        Tab(text: 'Создать заказ'), 
        Tab(text: 'Список заказов'), 
        Tab(text: 'Прогресс'), 
        ], 
      ), 
    ), 
      body: TabBarView( 
      children: [  
        buildCreateOrderTab(), 
        buildOrdersTab(),  
        buildRegistrationTab(),
        ], 
        ), 
        ), 
        ); 
        } 
 
  
  Widget buildCreateOrderTab() { 
    return Padding( 
      padding: const EdgeInsets.all(20.0), 
      child: Column( 
      crossAxisAlignment: CrossAxisAlignment.stretch, 
      children: [ 
        TextField( 
          controller: _orderNumberController, 
          decoration: InputDecoration( 
          labelText: 'Номер заказа', 
          ), 
        ), 
        SizedBox(height: 16), 
        TextField( 
          controller: _dataController, 
          decoration: InputDecoration( 
          labelText: 'Дата добавления', 
          ), 
          ), 
          SizedBox(height: 16), 
        TextField( 
            controller: _equipmentController, 
            decoration: InputDecoration( 
            labelText: 'Оборудование', 
          ), 
          ), 
          SizedBox(height: 16), 
          TextField( 
            controller: _descriptionController, 
            decoration: InputDecoration( 
            labelText: 'Описание неиспрвности', 
          ), 
          ), 
          SizedBox(height: 16), 
          TextField( 
            controller: _clientController, 
            decoration: InputDecoration( 
            labelText: 'ФИО клиента', 
          ), 
          ), 
          SizedBox(height: 16),
              ElevatedButton( 
                onPressed: () { 
                  setState(() { 
                    orders.add(Order( 
                      orderNumber: _orderNumberController.text, 
                      description: _descriptionController.text, 
                      client: _clientController.text, 
                      data: _dataController.text,
                      equipment: _equipmentController.text,
                      )); 
                      
                      _orderNumberController.clear(); 
                      _descriptionController.clear(); 
                      _clientController.clear(); 
                      _dataController.clear();
                      _equipmentController.clear();
                      }); 
                    }, 
                    child: Text('Создать запись'), 
                    ), 
                  ], 
                ), 
              ); 
            } 
 

 // второй экран

  Widget buildOrdersTab() { 
    return ListView.builder( 
      itemCount: orders.length, 
      itemBuilder: (context, index) { 
        return ListTile( 
          title: Text(orders[index].orderNumber), 
          subtitle: Text(orders[index].description,), 
           
          trailing: IconButton( 
          icon: Icon(Icons.delete), 
          onPressed: () { 
            setState(() { 
            orders.removeAt(index); 
            }); 
          }, 
        ), 
      ); 
    }, 
  ); 
} 
} 



Widget buildRegistrationTab(){
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Количество заявок: ',
        style: TextStyle(fontSize: 20.0),)
      ],
    ),
  );
}

class Order { 
final String orderNumber; 
final String description; 
final String client; 
final String data;
final String equipment;
 
Order({required this.orderNumber, required this.description, required this.client, required this.data, required this.equipment}); 
}