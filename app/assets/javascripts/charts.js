google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawCharts);

function drawCharts() {
  // 過去一週間の学習時間
  if (typeof weeklyLearningHours !== 'undefined') {
    var data = new google.visualization.DataTable();
    data.addColumn('string', '日付');
    data.addColumn('number', '学習時間');
    data.addRows(weeklyLearningHours);

    var options = {
      title: '過去一週間の学習時間',
      curveType: 'function',
      legend: { position: 'bottom' }
    };

    var chart = new google.visualization.LineChart(document.getElementById('weekly-learning-chart'));
    chart.draw(data, options);
  }

  // 学習項目別の学習時間の合計
  if (typeof chartData !== 'undefined') {
    var data = google.visualization.arrayToDataTable(chartData);

    var options = {
      title: '学習項目別の学習時間の合計',
      legend: { position: 'none' },
    };

    var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
    chart.draw(data, options);
  }
}