

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:projq/Providers/project.dart';

class ProjectItem extends StatelessWidget {
  final Project project;
  ProjectItem({this.project});

  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: InkWell(
      
      onTap:()=> Navigator.of(context).pushNamed('/proj_detail_screen',arguments:project.id),
      child: Card(
        margin: EdgeInsets.all(8),
        color: Colors.white,
        child:
                  Row(
            children: <Widget>[
              SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                      'https://www.bensound.com/bensound-img/hey.jpg',
                      height: 100,
                      width: 80,
                      fit: BoxFit.cover,
                      alignment: Alignment.center),
                ),
              ),
              SizedBox(width: 20),
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        project.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.people),
                      Text(project.members,style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,))
                      ],
                    ),
                    
                    SizedBox(height: 30),
                    ButtonBar(
                      alignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(children: <Widget>[
                          Icon(Icons.timer),
                          Text(
                            project.duration,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Icon(Icons.assignment_late),
                          Text(project.complexity,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),

                              Icon(Icons.attach_money),
                              Text(project.affordability,style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,))
                        ])
                      ],
                    ),
                  ])
            ],
          ),
        ),
      ),
    );
  }
}
