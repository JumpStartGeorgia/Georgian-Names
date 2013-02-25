function assign_data_to_svg(ths, json){
  if ($(ths).attr('district_id') == "0"){
    if (I18n.locale == 'ka'){
      $(ths).attr('district_name', $(ths).attr('district_name_geo'));
    } else if (I18n.locale == 'en'){
      $(ths).attr('district_name', $(ths).attr('district_name_eng'));
    }
  } else {
    var found = false;
    for (var i=0; i < json.length; i++){
      var feature = json[i];

      if (feature.district_id.toString() == $(ths).attr('district_id')){
        found = true;
        $(ths).attr('district_name', feature.district_name);
        //$(ths).attr('fill', feature.color);
        $(ths).attr('class', feature.classname);
        $(ths).attr('url', feature.url);
        $(ths).attr('count', feature.count);
        $(ths).attr('count_formatted', feature.count_formatted);
        $(ths).attr('rank', feature.rank);
        $(ths).attr('rank_formatted', feature.rank_formatted);
        break;
      }
    }

    if (!found){
      console.log('district ' + $(ths).attr('district_id') + ' not found in json; geo name = ' + $(ths).attr('district_name_geo'));
      if (I18n.locale == 'ka'){
        $(ths).attr('district_name', $(ths).attr('district_name_geo'));
      } else if (I18n.locale == 'en'){
        $(ths).attr('district_name', $(ths).attr('district_name_eng'));
      }
    }
  }
}

