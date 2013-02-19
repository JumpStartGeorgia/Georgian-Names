

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
      color: '#5b4e16'
    },
    subtitleStyle: {
      color: '#5b4e16'
    },
    yAxis: {
      titleStyle: {
        color: '#fceeb6'
      },
      labelStyle: {
        color: '#746727'
      }
    },
    xAxis: {
      labelStyle: {
        color: '#5b4e16'
      }
    }
  }

  

};
