$(function () {
  if (gon.chart_top_lnames) {
    var chart;
    $(document).ready(function() {
        chart = new Highcharts.Chart({
            chart: {
                renderTo: 'chart_top_lnames',
                type: 'bar'
            },
            title: {
                text: 'Top 10 Last Names'
            },
            subtitle: {
                text: 'Total Last Names: 74,481'
            },
            xAxis: {
                categories: ['ბერიძე', 'კაპანაძე', 'გელაშვილი', 'მაისურაძე', 'გიორგაძე', 'მამედოვი', 'წიკლაური', 'ლომიძე', 'მამედოვა', 'ბოლქვაძე'],
                title: {
                    text: null
                }
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Number of People with Last Name',
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
                bar: {
                    dataLabels: {
                        enabled: true,
                        formatter: function() {
                            return Highcharts.numberFormat(this.y,0,',');
                        }
                    }
                }
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
                data: [21033, 14449, 13912, 12586, 10827, 10250, 9977, 9977, 9184, 9152]
            }]
        });
    });
   } 
});