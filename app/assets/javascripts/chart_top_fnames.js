$(function () {
  if (gon.chart_top_fnames) {
    var chart;
    $(document).ready(function() {
        chart = new Highcharts.Chart({
            chart: {
                renderTo: gon.chart_top_fnames_id,
                backgroundColor: chartconfig.bar.background,
                type: 'bar'
            },
            title: {
                text: gon.chart_top_fnames_title,
                style: chartconfig.bar.titleStyle
            },
            subtitle: {
                text: gon.chart_top_fnames_subtitle,
                style: chartconfig.bar.subtitleStyle
            },
            xAxis: {
                categories: gon.chart_top_fnames_yaxis_names,
                title: {
                    text: null
                },
                labels: {
                  style: chartconfig.bar.xAxis.labelStyle
                },
                tickColor: chartconfig.bar.xAxis.tickColor,
                lineColor: chartconfig.bar.xAxis.lineColor
            },
            yAxis: {
                min: 0,
                title: {
                    text: gon.chart_top_fnames_yaxis,
                    align: 'middle',
                    style: chartconfig.bar.yAxis.titleStyle
                },
                labels: {
                    overflow: 'justify',
                    style: chartconfig.bar.yAxis.labelStyle
                },
                gridLineColor: chartconfig.bar.yAxis.gridLineColor
            },
            tooltip: chartconfig.bar.tooltip,
            plotOptions: {
                bar: chartconfig.bar.plotOptions
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
            exporting: chartconfig.exporting_top_names,
            lang: chartconfig.lang,
            navigation: chartconfig.navigation,
            credits: {
                enabled: false
            },
            series: [{
                showInLegend: false,
                cursor: 'pointer',
                point: {
                        events: {
                            click: function() {
                                location.href = gon.first_name_path + gon.chart_top_fnames_link_names[this.x];
                            }
                        }
                    },
                data: gon.chart_top_fnames_yaxis_data
            }]
        });
    });
   } 
});
