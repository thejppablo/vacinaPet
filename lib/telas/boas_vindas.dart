import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vacina_pet/telas/home_page.dart';
import 'package:vacina_pet/telas/login_page.dart';

class BoasVindasPage extends StatefulWidget {
  const BoasVindasPage({Key? key}) : super(key: key);

  @override
  _BoasVindasPageState createState() => _BoasVindasPageState();
}

class _BoasVindasPageState extends State<BoasVindasPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verificarToken().then((value) {
      if(value){
  /*pushReplacement apaga a pagina anterior (nesse caso boas vindas)
  e substitue pela especificada na rota */
        Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => HomePage(),
        ),
        );
      }else{
        Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => LoginPage(),
          ),
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<bool> verificarToken() async{
 ///verifica se o app tem um token de api/instance ja salva no app
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    if(sharedPreference.getString('accessToken') != null){
      print('ACCESS TOKEN SALVO LOCALMENTE: ');
      print(sharedPreference.getString('accessToken'));
      return true;
    }else{
      return false;
    }
  }

}
