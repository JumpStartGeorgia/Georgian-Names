$(function () {
  if (gon.map_population_json_svg) {
    var proj = d3.geo.mercator().translate([-4000,5050]).scale(37000);
    var path = d3.geo.path().projection(proj);

var w = 960,
    h = 500;

    d3.xml("/districts_20130204.svg", "image/svg+xml", function(xml) {
      var svg_node = document.importNode(xml.getElementById('layer1'), true);
//      var map = d3.select("#map");
//      map.node().appendChild(svg_node);
//console.log(map);          


    var map = d3.select("#map")
      .append("svg:svg")
      .attr("id", "svg_map")
      .attr("width", w + 40)
      .attr("height", h + 20);

    map.node().appendChild(svg_node);
      
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

    });
/*
var map = d3.select("#map")
  .append("svg:svg")
    .attr("id", "svg_map")
    .attr("width", w + 40)
    .attr("height", h + 20);

    var districts = map.append("g")
      .attr("id", "district");


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

    districts.selectAll("path")
    .data(gon.map_population_json.features)
    .enter().append("path")
      .attr("d", path)
      .attr("fill",function(d){
        return d["properties"]["color"]
      }).attr("district_name",function(d){
        return d["properties"]["district_name"]
      }).attr("url",function(d){
        return d["properties"]["url"]
      }).attr("count",function(d){
        return d["properties"]["count"]
      }).attr("count_formatted",function(d){
        return d["properties"]["count_formatted"]
      });

    // show map info box when rollover district
    $('g#district path').hover(
        function(){
          $('#map_info_box #map_district_name').html($(this).attr('district_name') === undefined ? gon.no_data : $(this).attr('district_name'));
          $('#map_info_box #map_district_count').html($(this).attr('count_formatted') === undefined ? gon.no_data : $(this).attr('count_formatted'));
          $('#map_info_box').show();
        },
        function(){
          $('#map_info_box').hide();
        }
      );

    // when click on district, load district page
    $('g#district path').click(
        function(){
          if ($(this).attr('url') !== undefined)
          window.location.href = $(this).attr('url');
      });
  
*/  
  }
});
