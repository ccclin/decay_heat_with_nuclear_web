class DecayHeatController < ApplicationController
  def index
  end

  def calculate
    if hash = upload_to_hash(params[:text]) || demo_data(params[:demo])
      output = DecayHeatWithNuclear.run(hash)
      @chart = LinePlot.plot_line(output, log: true)
    else
      render :index
    end
  end

  private

  def upload_to_hash(params)
    begin
      ts = []
      t0 = []
      power = []
      params.read.each_line do |line|
        a, b, c = line.split("\t")
        ts << a.to_f
        t0 << b.to_f
        power << c.to_f
      end
      ts, t0 = ts.zip(t0).sort.transpose
      { ts: ts, t0: t0 }
    rescue
      false
    end
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
end
