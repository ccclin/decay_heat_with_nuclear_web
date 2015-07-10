class DecayHeatController < ApplicationController
  def index
  end

  def calculate
    hash = upload_to_hash(params[:text])
    output = DecayHeatWithNuclear.run(hash)
    @chart1 = LinePlot.plot_line(output[:ans1979], 'ASN 1979')
    @chart2 = LinePlot.plot_line(output[:ans1973], 'ASN 1973')
    @chart3 = LinePlot.plot_line(output[:asb9_2], 'ASB 9-2')
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
