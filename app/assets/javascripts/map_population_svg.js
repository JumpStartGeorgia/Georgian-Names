$(function () {
  if (gon.map_population_json_svg) {
    var proj = d3.geo.mercator().translate([-4000,5050]).scale(37000);
    var path = d3.geo.path().projection(proj);

var w = 960,
    h = 500;

    d3.xml("/districts.svg", "image/svg+xml", function(xml) {
      var district = document.importNode(xml.getElementById('district'), true);

      var map = d3.select("#map")
        .append("svg:svg")
        .attr("id", "svg_map")
        .attr("width", w + 40)
        .attr("height", h + 20);

      map.node().appendChild(district);

      // add values for each path from json
      $('svg#svg_map g path').each(function(){
        if ($(this).attr('district_id') == "0"){
          console.log('district has id 0; geo name = ' + $(this).attr('district_name_geo'));
          if (I18n.locale == 'ka'){
            $(this).attr('district_name', $(this).attr('district_name_geo'));
          } else if (I18n.locale == 'en'){
            $(this).attr('district_name', $(this).attr('district_name_eng'));
          }
        } else {
          var found = false;
          for (var i=0; i < gon.map_population_json_svg.length; i++){
            var feature = gon.map_population_json_svg[i];

            if (feature.district_id.toString() == $(this).attr('district_id')){
              found = true;
              $(this).attr('district_name', feature.district_name);
              //$(this).attr('fill', feature.color);
              $(this).attr('class', feature.classname);
              $(this).attr('url', feature.url);
              $(this).attr('count', feature.count);
              $(this).attr('count_formatted', feature.count_formatted);
              break;
            }
          }

          if (!found){
            console.log('district ' + $(this).attr('district_id') + ' not found in json; geo name = ' + $(this).attr('district_name_geo'));
            if (I18n.locale == 'ka'){
              $(this).attr('district_name', $(this).attr('district_name_geo'));
            } else if (I18n.locale == 'en'){
              $(this).attr('district_name', $(this).attr('district_name_eng'));
            }
          }
        }
      });
/*        
      map.append("svg:text")
      .attr("x", function(d, i) { return w / 2; })
      .attr("y", 40)
      .attr("dx", -3)
      .attr("dy", "-.5em")
      .attr("text-anchor", "middle")
      .text(gon.map_title);

      map.append("svg:text")
      .attr("class", "sub_title")
      .attr("x", function(d, i) { return w / 2; })
      .attr("y", 60)
      .attr("dx", -3)
      .attr("dy", "-.5em")
      .attr("text-anchor", "middle")
      .text(gon.map_sub_title1);

      map.append("svg:text")
      .attr("class", "sub_title")
      .attr("x", function(d, i) { return w / 2; })
      .attr("y", 80)
      .attr("dx", -3)
      .attr("dy", "-.5em")
      .attr("text-anchor", "middle")
      .text(gon.map_sub_title2);
*/

      // show map info box when rollover district
      $('g#district path').hover(function(){
          $('#map_info_box #map_district_name').html($(this).attr('district_name') === undefined ? gon.no_data : $(this).attr('district_name'));
          $('#map_info_box #map_district_count').html($(this).attr('count_formatted') === undefined ? gon.no_data : $(this).attr('count_formatted'));
          $('#map_info_box').show();
        },
        function(){
          $('#map_info_box').hide();
        }
      );

      // when click on district, load district page
      $('g#district path').click(function(){
        if ($(this).attr('url') !== undefined)
        window.location.href = $(this).attr('url');
      });

    });
  }
});
