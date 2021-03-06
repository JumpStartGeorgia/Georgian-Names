$(function () {
  if (gon.chart_age_population) {
    var chart;
    $(document).ready(function() {
        var options = {
            chart: {
                renderTo: 'chart_age_population',
                backgroundColor: chartconfig.line.background,
                type: 'spline'
            },
            title: {
                text: gon.chart_age_pop_title,
                style: {
                  color: '#fff',
                  fontFamily: 'din',
                  fontSize: '18px'
                }
            },
            subtitle: {
                text: gon.chart_age_pop_subtitle,
                style: {
                  color: '#ffeaad',
                  fontFamily: 'skia',
                  fontSize: '14px'
                }
            },
            legend: {
                borderColor: '#fff',
                itemStyle: {
                    color: '#fff',
                    fontFamily: 'skia'
                }
            },
            xAxis: {
                title: {
                    text: gon.chart_age_pop_xaxis,
                    style: {
                      fontFamily: 'din',
                      color: '#ffeaad',
                      fontSize: '14px'
                    }
                },
                labels: {
                  formatter: function() {
                        return this.value + ' (' + (gon.static_year-this.value) + ')';
                  },
                  style: {
                    color: '#dce9dd',
                    fontFamily: 'skia',
                    fontSize: '12px',
                    letterSpacing: '-1px',
                    lineHeight: '13px'
                  }
                },
                lineColor: '#7ea387',
                tickColor: '#7ea387'
            },
            tooltip: {
                crosshairs: true,
                formatter: function() {
                    var x;
                    if (this.series.index == 1) {
                      // the values for count and rank have switched places
                      x = '<strong>' + gon.chart_age_pop_popup_birth_year + this.x + '</strong>'+ 
                          '<br />' + gon.chart_age_pop_popup_years_old + (gon.static_year-this.x) + 
                          '<br/>' + gon.chart_age_pop_popup_total + Highcharts.numberFormat(this.point.config[2],0,',') +
                          '<br />' + gon.chart_age_pop_popup_rank + this.y;
                    } else {
                      x = '<strong>' + gon.chart_age_pop_popup_birth_year + this.x + '</strong>'+ 
                          '<br />' + gon.chart_age_pop_popup_years_old + (gon.static_year-this.x) + 
                          '<br/>' + gon.chart_age_pop_popup_total + Highcharts.numberFormat(this.y,0,',');
                      if (this.point.config.length > 2){
                        x += '<br />' + gon.chart_age_pop_popup_rank + this.point.config[2];
                      }
                    }
                    return x;
                },
                backgroundColor: '#fff',
                borderWidth: 0,
                borderRadius: 0,
                shadow: false,
                style: {
                  color: '#494949',
                  padding: 8
                }
            },
            credits: {
                enabled: false
            },
            plotOptions: {
              series: {
                color: '#fff'
              }
            },
            exporting: chartconfig.exporting_population,
            lang: chartconfig.lang,
            navigation: chartconfig.navigation
        };
        
        // if secondary y axis/data is needed include it
        if (gon.chart_age_pop_yaxis2 && gon.chart_age_rank_data) {
          // set the y-axis
          options.yAxis = [{ // Primary yAxis
                labels: {
                    style: {
	                    color: '#fff',
                      fontFamily: 'skia',
                      fontSize: '12px',
                      letterSpacing: '-1px',
                      lineHeight: '13px'
                    }
                },
                title: {
                    text: gon.chart_age_pop_yaxis,
                    style: {
                      fontFamily: 'din',
	                    color: '#fff',
	                    fontWeight: 'normal',
                      fontSize: '14px'
                    }
                },
                gridLineColor: '#679372',
                min: 0
            }, { // Secondary yAxis
                labels: {
                    style: {
                        color: '#ffeaad',
                        fontFamily: 'skia',
                        fontSize: '12px',
                        letterSpacing: '-1px',
                        lineHeight: '13px'
                     }
                },
                title: {
                    text: gon.chart_age_pop_yaxis2,
                    style: {
                        fontFamily: 'din',
                        color: '#ffeaad',
                        fontSize: '14px'
                    }                    
                },
                gridLineColor: '#679372',
                min: 0,
                reversed: true,
                opposite: true
            }];
            
            // set the data series
            options.series = [{
                //showInLegend: false,
                name: gon.chart_age_pop_yaxis,
                cursor: 'pointer',
                color: '#fff',
                point: {
                        events: {
                            click: function() {
                                location.href = gon.year_path + this.x;
                            }
                        }
                    },
                data: gon.chart_age_pop_data
            }, {
                //showInLegend: false,
                name: gon.chart_age_pop_yaxis2,
                yAxis: 1,
                color: '#ffeaad',
                cursor: 'pointer',
                point: {
                        events: {
                            click: function() {
                                location.href = gon.year_path + this.x;
                            }
                        }
                    },
                data: gon.chart_age_rank_data
            }];

        } else {
          // set the y-axis
          options.yAxis = {
                title: {
                    text: gon.chart_age_pop_yaxis,
                    style: {
                      fontFamily: 'din',
	                    color: '#ffeaad',
	                    fontWeight: 'normal',
                      fontSize: '14px',
                    }
                },
                labels: {
                    style: {
	                    color: '#dce9dd',
                      fontFamily: 'skia',
                      fontSize: '12px',
                      letterSpacing: '-1px',
                      lineHeight: '13px'
                    }
                },
                gridLineColor: '#679372',
                min: 0
            };
            
            // set the data series
            options.series = [{
                showInLegend: false,
                cursor: 'pointer',
                point: {
                        events: {
                            click: function() {
                                location.href = gon.year_path + this.x;
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
