

var chartconfig = {

  bar: {
    background: '#bfb35a',
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
  },
  line: {
    background: '#5e8c6a'
  },
  exporting_population: {
    buttons: {
      exportButton: {
        symbol: 'url(/assets/chart_icons/download_age_chart.png)',
        backgroundColor: null,
        borderColor: null,
        hoverBorderColor: null,
        y: 25
      },
      printButton: {
        symbol: 'url(/assets/chart_icons/print_age_chart.png)',
        backgroundColor: null,
        borderColor: null,
        hoverBorderColor: null,
        y: 25
      }
    }
  },
  exporting_top_names: {
    buttons: {
      exportButton: {
        symbol: 'url(/assets/chart_icons/download_names_chart.png)',
        backgroundColor: null,
        borderColor: null,
        hoverBorderColor: null,
        y: 25
      },
      printButton: {
        symbol: 'url(/assets/chart_icons/print_names_chart.png)',
        backgroundColor: null,
        borderColor: null,
        hoverBorderColor: null,
        y: 25
      }
    }
  },
  navigation: {
    menuItemStyle: {
      padding: '5px',
    	background: null,
	    color: '#494949'
    },
    menuItemHoverStyle: {
    	backgroundColor: '#D95B43',
	    color: '#fff'
    }
  },
  lang: {
    downloadPNG: gon.highcharts_downloadPNG,
    downloadJPEG: gon.highcharts_downloadJPEG,
    downloadPDF: gon.highcharts_downloadPDF,
    downloadSVG: gon.highcharts_downloadSVG,
    exportButtonTitle: gon.highcharts_exportButtonTitle,
    printButtonTitle: gon.highcharts_printButtonTitle
  }
};
