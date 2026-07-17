typedef GetValue = bool Function();
typedef SetValue = Future<void> Function(bool);

class BoolControler {
  
  bool value;

  BoolControler(this.value);
  setTrue(){
    value=true;
  }
  setFalse(){
    value=false;
  }
  change(){
    value=!value;
  }
}
