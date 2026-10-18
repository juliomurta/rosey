import 'package:flutter/material.dart';
import 'package:rosey/screens/appointments/add_appointment_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const double paddingValue = 18;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 32,
                    horizontal: paddingValue,
                  ),
                  child: Text(
                    "Olá Fulano",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: paddingValue,
                  ),
                  child: Text("foto-user"),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: paddingValue,
                  ),
                  child: Text(
                    "Agendamentos",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
            Row(
              children: [ 
                 Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: paddingValue,
                  ),
                  child:                
                    Text(
                      "Agendamentos mais recentes",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)
                    )
                 )
              ],
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: paddingValue),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Text(
                        "Agendamento ${index + 1}", 
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Text(
                            "Aguardando análise", 
                            style: TextStyle(fontSize: 20)
                          ),
                          SizedBox(height: 8),
                          Text(
                            "20 de outubro", 
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)
                          )
                        ]
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            tooltip: 'Edit',
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              print('Edit appointment ${index + 1}');
                            },
                          ),
                          IconButton(
                            tooltip: 'Remove',
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () {
                              print('Remove appointment ${index + 1}');
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.large(        
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        shape: CircleBorder(),
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => AddNewAppointmentScreen()
            ),
          );
        }
      ),
    );
  }
}
