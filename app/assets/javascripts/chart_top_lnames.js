$(function () {
  if (gon.chart_top_lnames) {
    var chart;
    $(document).ready(function() {
        chart = new Highcharts.Chart({
            chart: {
                renderTo: gon.chart_top_lnames_id,
                type: 'bar'
            },
            title: {
                text: gon.chart_top_lnames_title
            },
            subtitle: {
                text: gon.chart_top_lnames_subtitle
            },
            xAxis: {
                categories: gon.chart_top_lnames_yaxis_names,
                title: {
                    text: null
                }
            },
            yAxis: {
                min: 0,
                title: {
                    text: gon.chart_top_lnames_yaxis,
                    align: 'middle'
                },
                labels: {
                    overflow: 'justify'
                }
            },
            tooltip: {
                formatter: function() {
                    return this.x +': '+ Highcharts.numberFormat(this.y,0,',');
                }
            },
            plotOptions: {
                bar: chartconfig.barPlotOptions
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'top',
                x: -100,
                y: 100,
                floating: true,
                borderWidth: 1,
                backgroundColor: '#FFFFFF',
                shadow: true
            },
            credits: {
                enabled: false
            },
            series: [{
                showInLegend: false,
                cursor: 'pointer',
                point: {
                        events: {
                            click: function() {
                                location.href = gon.last_name_path + gon.chart_top_lnames_link_names[this.x];
                            }
                        }
                    },
                data: gon.chart_top_lnames_yaxis_data
            }]
        });
    });
   } 
});
