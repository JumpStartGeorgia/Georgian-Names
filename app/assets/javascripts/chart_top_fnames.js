$(function () {
  if (gon.chart_top_fnames) {
    var chart;
    $(document).ready(function() {
        chart = new Highcharts.Chart({
            chart: {
                renderTo: 'chart_top_fnames',
                type: 'bar'
            },
            title: {
                text: 'Top 10 First Names'
            },
            subtitle: {
                text: 'Total First Names: 47,180'
            },
            xAxis: {
                categories: ['გიორგი', 'ნინო', 'დავით', 'მაია', 'თამარ', 'ნანა', 'მანანა', 'ნათელა', 'ნათია', 'ზურაბ'],
                title: {
                    text: null
                }
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Number of People with First Name',
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
                data: [115360, 81036, 48721, 44442, 43021, 37315, 33257, 31958, 30364, 28741]
            }]
        });
    });
   } 
});