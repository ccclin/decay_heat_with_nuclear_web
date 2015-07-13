class DecayHeatController < ApplicationController
  def index
  end

  def calculate
    if hash = upload_to_hash(params[:text])
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
end
