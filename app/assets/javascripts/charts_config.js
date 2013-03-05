

var chartconfig = {

  bar: {
    plotOptions: {
      dataLabels: {
        enabled: true,
        formatter: function() {
            return Highcharts.numberFormat(this.y,0,',');
        },
        color: '#746727',
        style: {
          fontSize: '12px',
          fontFamily: 'skia'
        }
      },
      color: '#fff',
      borderWidth: 0,
      shadow: false
    },
    titleStyle: {
      color: '#5b4e16',
      fontFamily: 'din',
      fontSize: '18px'
    },
    subtitleStyle: {
      color: '#5b4e16',
      fontFamily: 'skia',
      fontSize: '14px'
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
        color: '#5b4e16',
        fontSize: '12px'
      },
      lineColor: '#5b4e16',
      tickColor: '#5b4e16'
    },
    tooltip: {
      formatter: function() {
        return this.x +': '+ Highcharts.numberFormat(this.y,0,',');
      },
      backgroundColor: '#5b4e16',
      borderWidth: 0,
      borderRadius: 0,
      shadow: false,
      style: {
        color: '#d6d3c5',
        padding: 8,
        fontSize: '13px',
        fontWeight: 'bold',
        fontFamily: 'skia',
        letterSpacing: '-1px'
      }
    }
  }

  

};
