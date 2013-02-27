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


// compute the scale for the map based on the window width
function map_scale(){
  var w = $(window).width();
  if (w > 1530) {
    scale = 0.67;
  } else if (w > 1115) {
    scale = 0.5;
  } else {
    scale = 0.33;
  }
  return scale;
}
function map_popout_scale(){
  var w = $(window).width();
  if (w > 1530) {
    scale = 1;
  } else if (w > 1115) {
    scale = 0.67;
  } else {
    scale = 0.5;
  }
  return scale;
}

function adjust_map_scales(){
  (function (g) {
    var scale = map_scale();
    g.attr('transform', 'translate(' + (+g.data('translate-x') * scale) + ', ' + (+g.data('translate-y') * scale) + ') scale(' + scale + ')');
  })($('#map_districts svg g'));


  (function (g) {
    var scale = map_popout_scale();
    g.attr('transform', 'translate(' + (+g.data('translate-x') * scale) + ', ' + (+g.data('translate-y') * scale) + ') scale(' + scale + ')');
  })($('#map_district_popouts svg g'));
}
