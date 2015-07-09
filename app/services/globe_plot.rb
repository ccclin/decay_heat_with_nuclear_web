class GlobePlot
  TITLE_NAME = 'Decay Heat'
  X_NAME = 'X'
  Y_NAME = 'Y'

  class << self
    def plot_line(hash)
      chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.title({ text: "#{TITLE_NAME}" })
        f.options[:xAxis] = { title: { text: "#{X_NAME}" }, min: 0 }
        f.options[:yAxis] = { title: { text: "#{Y_NAME}" }, min: 0 }
        data_array = []

        hash[:ts].each_index do |i|
          # binding.pry
          data_array << [hash[:ts][i].to_f, hash[:p_p0][i].to_f]
        end
        f.series(type: 'line', name: "#{TITLE_NAME}", data: data_array)
      end
      chart
    end

    private
  end
end
