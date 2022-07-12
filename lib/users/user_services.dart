import 'package:adminapp/utils/database.dart';
import 'package:adminapp/utils/service_details.dart';
import 'package:flutter/material.dart';

class UserServices extends StatefulWidget {
  final String id;
  final String serviceName;

  const UserServices({Key? key, required this.id, required this.serviceName}) : super(key: key);

  @override
  State<UserServices> createState() => _UserServicesState();
}

class _UserServicesState extends State<UserServices> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ServiceDetails>(
      stream: DatabaseServiceDetails(uid: widget.id, serviceName: widget.serviceName).readUserServices(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Container();
        }else{
          return Column(
            children: [
              Row(
                children: [
                  Text('Service ${snapshot.data!.serviceName}')
                ],
              ),
            ],
          );
        }
      },
    );
  }
}