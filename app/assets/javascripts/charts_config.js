

var chartconfig = {

  bar: {
    plotOptions: {
      dataLabels: {
        enabled: true,
        formatter: function() {
            return Highcharts.numberFormat(this.y,0,',');
        },
        color: '#746727'
      },
      color: '#fff',
      borderWidth: 0,
      shadow: false
    },
    titleStyle: {
      color: '#5b4e16',
      fontFamily: 'din'
    },
    subtitleStyle: {
      color: '#5b4e16',
      fontFamily: 'skia'
    },
    yAxis: {
      titleStyle: {
        fontFamily: 'din',
        color: '#fceeb6'
      },
      labelStyle: {
        fontFamily: 'skia',
        color: '#746727'
      },
      gridLineColor: '#b7aa55'
    },
    xAxis: {
      titleStyle: {
        fontFamily: 'din'
      },
      labelStyle: {
        fontFamily: 'skia',
        color: '#5b4e16'
      },
      lineColor: '#5b4e16',
      tickColor: '#5b4e16'
    }
  }

  

};
