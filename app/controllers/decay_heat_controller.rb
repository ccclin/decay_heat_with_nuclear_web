require 'json'

class DecayHeatController < ApplicationController
  def index
  end

  def calculate
    hash = upload_to_hash(params[:text]) || demo_data(params[:demo]) || nil
    if output = decay_heat_calculate(hash) || check_hash(params[:output])
      write_output(output) if params[:first]
      @output = output.to_json
      @chart = LinePlot.plot_line(output, log: params[:log].present?)
      @option = { log: params[:log].present? }
    else
      render :index
    end
  end

  def download
    send_file("#{Rails.root}/public/uploads/temp.txt")
  end

  private

  def upload_to_hash(params)
    ts = []
    t0 = []
    power = []
    params.read.each_line do |line|
      a, b, c = line.split("\t")
      ts << a.to_f
      t0 << b.to_f
      power << c.to_f
    end
    # ts, t0 = ts.zip(t0).sort.transpose
    { ts: ts, t0: t0 }
  rescue
    false
  end

  def demo_data(option)
    if option
      ts = Array.new(20) { |i| (i + 1) * 365 * 24 * 3600 }
      {
        ts: ts,
        t0: Array.new(ts.size) { 63 * 30 * 24 * 3600 }
      }
    else
      false
    end
  end

  def check_hash(params)
    if JSON.parse(params).is_a?(Hash)
      JSON.parse(params)
    else
      false
    end
  end

  def decay_heat_calculate(hash)
    DecayHeatWithNuclear.run(hash)
  rescue
    false
  end

  def write_output(hash)
    File.open(Rails.root.join('public', 'uploads', 'temp.txt'), 'wb') do |file|
      file.printf("ts\tANS-1979\tANS-1973\tASB9-2\tASB9-2withoutK\n")
      hash[:ans1979][:ts].each_index do |i|
        file.printf("%.1f\t%.12f\t%.12f\t%.12f\t%.12f\n",
                    hash[:ans1979][:ts][i],
                    hash[:ans1979][:p_p0][i],
                    hash[:ans1973][:p_p0][i],
                    hash[:asb9_2][:p_p0][i],
                    hash[:asb9_2][:p_p0_without_k][i]
                   )
      end
    end
  end
end
