import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'choix.dart';

class FormulaireDialog extends StatefulWidget {
  final String userEmail;

  const FormulaireDialog({super.key, required this.userEmail});

  get enfants => null;

  @override
  _FormulaireDialogState createState() => _FormulaireDialogState();
}

class _FormulaireDialogState extends State<FormulaireDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _pseudo;
  late String _emailenfant;
  late String _motDePasse;
  String? _genre;
  bool _isObscure = true;
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool isValidEmail(String emailenfant) {
    final emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?$");
    return emailRegExp.hasMatch(emailenfant);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Ajouter un enfant',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Pseudo',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 7, 155, 205)),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez saisir un pseudo';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _pseudo = value!;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'emailenfant',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 7, 155, 205)),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez saisir un emailenfant';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _emailenfant = value!;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        labelText: 'Mot de passe',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure; // Inverse l'état
                            });
                          },
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 7, 155, 205)),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: password,
                      validator: (value) {
                        if (password.text == "") {
                          return 'Veuillez saisir un mot de passe';
                        }
                        return null;
                      },
                      // onSaved: (value) {
                      //   _motDePasse = value!;
                      // },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: _isObscure, // Masque le texte par défaut
                      decoration: InputDecoration(
                        labelText: 'Confirmer le mot de passe',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure; // Inverse l'état
                            });
                          },
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 7, 155, 205)),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      controller: confirmPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez saisir à nouveau le mot de passe';
                        }
                        if (confirmPassword.text != password.text) {
                          return 'Les mots de passe ne correspondent pas';
                        }
                        return null;
                      },
                      // onSaved: (value) {
                      //   _confirmationMotDePasse = value!;
                      // },
                    ),
                    const SizedBox(height: 20),
                    const Text('Genre:'),
                    Row(
                      children: <Widget>[
                        Radio<String>(
                          value: 'garçon',
                          groupValue: _genre,
                          onChanged: (value) {
                            setState(() {
                              _genre = value;
                            });
                          },
                        ),
                        const Text('Garçon'),
                        Radio<String>(
                          value: 'fille',
                          groupValue: _genre,
                          onChanged: (value) {
                            setState(() {
                              _genre = value;
                            });
                          },
                        ),
                        const Text('Fille'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          print("dkhalna");
                          print(password.text);
                          final form = _formKey.currentState;
                          if (form != null &&
                              _formKey.currentState!.validate()) {
                            print("true");
                            form.save();
                            final succes = await ajouterEnfant(_pseudo,
                                _emailenfant, password.text, widget.userEmail);
                            // Utilisez la variable succes pour prendre des mesures appropriées en fonction du résultat de l'ajout d'enfant
                            print("await");
                            if (succes) {
                              print("succes");
                              afficherMessage(
                                  context, 'Enfant ajouté avec succès');
                            } else {
                              print("err");
                              afficherMessage(context,
                                  'Erreur lors de l\'ajout de l\'enfant à Firestore');
                            }
                          } else {
                            print("false");
                            print(form != null);
                            print(_formKey.currentState!.validate());
                          }
                        },
//                        onPressed: _validerFormulaire,
                        child: const Text('Valider'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _validerFormulaire() async {
    final form = _formKey.currentState;
    if (form != null && _formKey.currentState!.validate()) {
      form.save();
      final succes = await ajouterEnfant(
          _pseudo, _emailenfant, _motDePasse, widget.userEmail);
      if (succes) {
        setState(() {
          // Ajouter l'enfant à la liste d'enfants

          widget.enfants.add(Enfant(
            emailenfant: _emailenfant,
            motDePasse: _motDePasse,
            pseudo: _pseudo,
            emailParent: widget.userEmail,
          ));
        });

        // Afficher un message de succès
        afficherMessage(context, 'Enfant ajouté avec succès à Firestore !');
      } else {
        afficherMessage(
            context, 'Erreur lors de l\'ajout de l\'enfant à Firestore');
      }
    }
  }

  void afficherMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Succès"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<bool> ajouterEnfant(String pseudo, String emailenfant,
      String motDePasse, String emailParent) async {
    try {
      // Crée un nouvel ID de document
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('enfants').doc();

      // Ajouter l'enfant dans l'espace d'authentification
      FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailenfant, password: motDePasse);

      // Ajoute les données à Firestore
      await docRef.set({
        'uid': docRef.id, // Ajoute l'ID du document aux données
        'pseudo': pseudo,
        'emailenfant': emailenfant,
        'motDePasse': motDePasse,
        'emailParent': emailParent,
      });

      print('Enfant ajouté avec succès à Firestore avec l\'ID: ${docRef.id} !');
      return true; // Retourne vrai si l'enfant est ajouté avec succès
    } catch (error) {
      print('Erreur lors de l\'ajout de l\'enfant à Firestore : $error');
      return false; // Retourne faux en cas d'erreur
    }
  }
}