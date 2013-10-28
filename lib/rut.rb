#coding: utf-8
require "rut/version"

class Rut
  def self.dv rut
    if rut.is_a? String
      raise ArgumentError, "El rut #{rut} debe ser un número" unless rut =~ /^\d{1,8}$/
    end
    rut = rut.to_s
    x=9
    t=0
    rut.reverse.split(//).each do |d|
      t+=d.to_i*x
      x=(x==4) ? 9 : x - 1
    end
    r= t % 11
    (r==10) ? "k" : r
  end
end
