class DecayHeatController < ApplicationController
  def index
  end

  def calculate
    hash = upload_to_hash(params[:text])
    output = DecayHeatWithNuclear.run(hash)
    @chart = GlobePlot.plot_line(output[:ans1979])
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
    { ts: ts, t0: t0 }
  end
end
