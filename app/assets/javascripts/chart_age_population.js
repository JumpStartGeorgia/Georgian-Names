$(function () {
  if (gon.chart_age_population) {
    var chart;
    $(document).ready(function() {
        chart = new Highcharts.Chart({
            chart: {
                renderTo: 'chart_age_population',
                type: 'spline'
            },
            title: {
                text: gon.chart_age_pop_title
            },
            subtitle: {
                text: gon.chart_age_pop_subtitle
            },
            xAxis: {
                title: {
                    text: gon.chart_age_pop_xaxis
                },
                labels: {
                  formatter: function() {
                        return this.value + '<br/> (' + (2012-this.value) + ')';
                  }
                }
            },
            yAxis: {
                title: {
                    text: gon.chart_age_pop_yaxis
                },
                min: 0
            },
            tooltip: {
                crosshairs: true,
                formatter: function() {
                    var x = '<strong>' + this.x +' years old (' + (2012-this.x) + ')</strong>'+ 
                        '<br/>Total: ' + Highcharts.numberFormat(this.y,0,',');
                    if (this.point.config.length > 2){
                      x += '<br />Rank: ' + this.point.config[2];
                    }
                    return x;
                }
            },
            series: [{
                showInLegend: false,
                cursor: 'pointer',
                point: {
                        events: {
                            click: function() {
                                location.href = gon.year_path + (2012-this.x);
                            }
                        }
                    },
                data: gon.chart_age_pop_data
            }]
        });
    });
  }    
});