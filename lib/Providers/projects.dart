import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import './project.dart';

class Projects with ChangeNotifier {
  List<Project> _items=[];
   final String authToken=null;
  final String userId=null;

  

  List<Project> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return _items;
  }

  

  Project findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }
    
  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    
      final List<Project> loadedProducts = [];
      
      _items = loadedProducts;
      notifyListeners();
    } 
    
  

  Future<void> addProduct(Project project) async {
    final url =
        'https://projfire-d9f08.firebaseio.com/projects.json';
    
      http.post(
        url,
        body: json.encode({
          'title': project.title,
          'description': project.description,
          'image': project.image,
          'prequisites': project.prequisites,
          'duration': project.duration,
          'complexity': project.complexity,
          'affordability':project.affordability,
          'id':project.id,
          'contact':project.contact,
          'members':project.members
          
        }),
      ).then((response){
      
      print(json.decode(response.body));
      final newProduct = Project(
        title: project.title,
        description: project.description,
        prequisites: project.prequisites,
        image:project.image,
        id: project.id,
        duration: project.duration,
        complexity: project.complexity,
        affordability: project.affordability,
        contact: project.contact,
        members: project.members

      );
      _items.add(newProduct);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
      });
    
  }

  

  Future<void> deleteProduct(String id) async {
    final url =
        'https://projectmate-5c85c.firebaseio.com/products/$id.json?auth=$authToken';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}