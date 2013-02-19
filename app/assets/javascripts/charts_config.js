

var chartconfig = {

  barPlotOptions: {
    dataLabels: {
      enabled: true,
      formatter: function() {
          return Highcharts.numberFormat(this.y,0,',');
      }
    },
    color: '#fff',
    borderWidth: 0,
    shadow: false
  }

};
