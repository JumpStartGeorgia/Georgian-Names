$(function () {
  if (gon.chart_age_population) {
    var chart;
    $(document).ready(function() {
        var options = {
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
            tooltip: {
                crosshairs: true,
                formatter: function() {
                    var x;
                    if (this.series.index == 1) {
                      // the values for count and rank have switched places
                      x = '<strong>' + this.x +' years old (' + (2012-this.x) + ')</strong>'+ 
                          '<br/>Total: ' + Highcharts.numberFormat(this.point.config[2],0,',') +
                          '<br />Rank: ' + this.y;
                    } else {
                      x = '<strong>' + this.x +' years old (' + (2012-this.x) + ')</strong>'+ 
                          '<br/>Total: ' + Highcharts.numberFormat(this.y,0,',');
                      if (this.point.config.length > 2){
                        x += '<br />Rank: ' + this.point.config[2];
                      }
                    }
                    return x;
                }
            },
            series: [{
                showInLegend: false,
                cursor: 'pointer',
                color: '#4572A7',
                point: {
                        events: {
                            click: function() {
                                location.href = gon.year_path + (2012-this.x);
                            }
                        }
                    },
                data: gon.chart_age_pop_data
            }, {
                showInLegend: false,
                yAxis: 1,
                color: '#AA4643',
                data: gon.chart_age_rank_data
            }]
        };
        
        // if secondary y axis/data is needed include it
        if (gon.chart_age_pop_yaxis2 && gon.chart_age_rank_data) {
          // set the y-axis
          options.yAxis = [{ // Primary yAxis
                labels: {
                    style: {
                        color: '#4572A7'
                    }
                },
                title: {
                    text: gon.chart_age_pop_yaxis,
                    style: {
                        color: '#4572A7'
                    }
                },
                min: 0
            }, { // Secondary yAxis
                labels: {
                    style: {
                        color: '#AA4643'
                    }
                },
                title: {
                    text: gon.chart_age_pop_yaxis2,
                    style: {
                        color: '#AA4643'
                    }                    
                },
                min: 0,
                reversed: true,
                opposite: true
            }];
            
            // set the data series
            options.series = [{
                //showInLegend: false,
                name: gon.chart_age_pop_yaxis,
                cursor: 'pointer',
                color: '#4572A7',
                point: {
                        events: {
                            click: function() {
                                location.href = gon.year_path + (2012-this.x);
                            }
                        }
                    },
                data: gon.chart_age_pop_data
            }, {
                //showInLegend: false,
                name: gon.chart_age_pop_yaxis2,
                yAxis: 1,
                color: '#AA4643',
                data: gon.chart_age_rank_data
            }];

        } else {
          // set the y-axis
          options.yAxis = {
                title: {
                    text: gon.chart_age_pop_yaxis,
                },
                min: 0
            };
            
            // set the data series
            options.series = [{
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

        }

        chart = new Highcharts.Chart(options);
        
    });
  }    
});