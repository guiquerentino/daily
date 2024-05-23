class DataUtils {

  static String formatDate(String date){

    if(date == "Monday"){
      return "Seg";
    }

    if(date == "Tuesday"){
      return "Ter";
    }

    if(date == "Wednesday"){
      return "Qua";
    }

    if(date == "Thursday"){
      return "Qui";
    }

    if(date == "Friday"){
      return "Sex";
    }

    if(date == "Saturday"){
      return "Sáb";
    }

    if(date == "Sunday"){
      return "Dom";
    }

    return "aa";

  }

}