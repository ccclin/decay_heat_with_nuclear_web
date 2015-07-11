class LinePlot
  TITLE_NAME = 'Decay Heat'
  X_NAME = 'ts (sec)'
  Y_NAME = 'P/P0'

  class << self
    def plot_line(hash)
      chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.title({ text: "#{TITLE_NAME}" })
        f.options[:xAxis] = { title: { text: "#{X_NAME}" }, min: 0 }
        f.options[:yAxis] = { title: { text: "#{Y_NAME}" }, min: 0 }
        data_array = {}
        hash.each_key do |key|
          if key == :asb9_2
            data_array[key] = []
            data_array[:asb9_2_without_K] = []
            hash[key][:ts].each_index do |i|
              data_array[key] << [hash[key][:ts][i].to_f, hash[key][:p_p0][i].to_f]
              data_array[:asb9_2_without_K] << [hash[key][:ts][i].to_f, hash[key][:p_p0_without_k][i].to_f]
            end
            f.series(type: 'line', name: "#{key}", data: data_array[key])
            f.series(type: 'line', name: "#{key}_without_k", data: data_array[key])            
          else
            data_array[key] = []
            hash[key][:ts].each_index do |i|
              data_array[key] << [hash[key][:ts][i].to_f, hash[key][:p_p0][i].to_f]
            end
            f.series(type: 'line', name: "#{key}", data: data_array[key])
          end
        end
      end
      chart
    end
  end
end
