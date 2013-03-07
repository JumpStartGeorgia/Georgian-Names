$(function () {
  if (gon.map_name_json_svg) {
    var proj = d3.geo.mercator().translate([-4000,5050]).scale(37000);
    var path = d3.geo.path().projection(proj);

    if (gon.is_ie == true){
      var w = 960, h = 500;

      var map = d3.select("#map_districts")
        .append("svg:svg")
        .attr("id", "svg_map")
        .attr("width", w + 40)
        .attr("height", h + 20);

      var districts = map.append("g")
        .attr("id", "district");

      districts.selectAll("path")
        .data(gon.map_name_json_svg.features)
        .enter().append("path")
          .attr("d", path)
          .attr("class",function(d){
            return d["properties"]["classname"]
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

      // turn of popup section
      $('#map_district_popouts').css('display', 'none');

      // fix css if responsive css is being used
      $('#map_container').css('min-height', '602px');
      $('#map_svg_container #map_districts').css('width', '960px');
      $('#map_svg_container #map_districts svg#svg_map').css('width', '960px');
      $('#map_svg_container #map_districts svg#svg_map').css('height', '500px');
      $('#map_legend').css('top', '225px');
      $('#map_legend').css('left', '100px');
      $('#map_info_box').css('top', '150px');
      $('#map_info_box').css('left', '675px');
      
    }else{
      // resize the map as the window resizes
      $(window).bind('load resize', adjust_map_scales);

      d3.xml("/districts.svg", "image/svg+xml", function(xml) {
        var w = 960, h = 500;
        var district = document.importNode(xml.getElementById('district'), true);
        var scale = map_scale();

        var map = d3.select("#map_districts")
          .append("svg:svg")
          .attr("id", "svg_map")
          .attr("width", w*scale + 40)
          .attr("height", h*scale + 20);

        map.node().appendChild(district);

        // add values for each path from json
        $('#map_districts svg#svg_map g path').each(function(){
          assign_data_to_svg(this, gon.map_name_json_svg)
        });

        // show map info box when rollover district
        $('g#district path').hover(
            function(){
              $('#map_info_box #map_district_name').html($(this).attr('district_name') === undefined ? gon.no_data : $(this).attr('district_name'));
              $('#map_info_box #map_district_rank').html($(this).attr('rank_formatted') === undefined ? gon.no_data : $(this).attr('rank_formatted'));
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

        adjust_map_scales();
      });

      // district pop out map
      d3.xml("/district_popouts.svg", "image/svg+xml", function(xml) {
        var w = 370, h = 500;
        var district = document.importNode(xml.getElementById('district_popouts'), true);
        var scale = map_popout_scale();

        var map = d3.select("#map_district_popouts")
          .append("svg:svg")
          .attr("id", "svg_map_popouts")
          .attr("width", w*scale + 40)
          .attr("height", h*scale + 20);

        map.node().appendChild(district);

        // add values for each path from json
        $('#map_district_popouts svg#svg_map_popouts g path').each(function(){
          assign_data_to_svg(this, gon.map_name_json_svg)
        });
     
        // show map info box when rollover district
        $('g#district_popouts path').hover(function(){
            $('#map_info_box #map_district_name').html($(this).attr('district_name') === undefined ? gon.no_data : $(this).attr('district_name'));
            $('#map_info_box #map_district_rank').html($(this).attr('rank_formatted') === undefined ? gon.no_data : $(this).attr('rank_formatted'));
            $('#map_info_box #map_district_count').html($(this).attr('count_formatted') === undefined ? gon.no_data : $(this).attr('count_formatted'));
            $('#map_info_box').show();
          },
          function(){
            $('#map_info_box').hide();
          }
        );

        // when click on district, load district page
        $('g#district_popouts path').click(function(){
          if ($(this).attr('url') !== undefined)
          window.location.href = $(this).attr('url');
        });

        adjust_map_scales();
     });
    }
  }
});
