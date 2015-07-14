class LinePlot
  TITLE_NAME = 'Decay Heat'
  X_NAME = 'ts (sec)'
  Y_NAME = 'P/P0'

  class << self
    def plot_line(hash, option = {})
      chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: "#{TITLE_NAME}")
        if option[:log]
          f.options[:xAxis] = { title: { text: "#{X_NAME}" }, type: 'logarithmic' }
        else
          f.options[:xAxis] = { title: { text: "#{X_NAME}" } }
        end
        f.options[:yAxis] = { title: { text: "#{Y_NAME}" } }
        data_array = {}
        hash.each_key do |key|
          data_array[key] = []
          data_array[:asb9_2_without_K] = []
          hash_tiem = {
            ts:             hash[key][:ts] || hash[key]['ts'],
            p_p0:           hash[key][:p_p0] || hash[key]['p_p0'],
            p_p0_without_k: hash[key][:p_p0_without_k] || hash[key]['p_p0_without_k'] || nil
          }

          hash_tiem[:ts].each_index do |i|
            data_array[key] << [hash_tiem[:ts][i].to_f, hash_tiem[:p_p0][i].to_f]
            data_array[:asb9_2_without_K] << [hash_tiem[:ts][i].to_f, hash_tiem[:p_p0_without_k][i].to_f] if hash_tiem[:p_p0_without_k][i]
          end
          f.series(type: 'spline', name: "#{key}".upcase, data: data_array[key], dashStyle: 'longdash')
          f.series(type: 'spline', name: "#{key}_without_k".upcase, data: data_array[:asb9_2_without_K], dashStyle: 'longdash') unless data_array[:asb9_2_without_K].empty?
        end
      end
      chart
    end
  end
end
