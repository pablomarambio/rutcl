#coding: utf-8
require "rut/version"

class Rut
  class << self
    def dv rut
      raise ArgumentError, "El rut es nulo" if rut.nil?
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

    def valid? rut
      return true if pretty(rut) rescue false
    end

    def pretty rut, validate=true
      if rut.is_a? String
        rut.gsub! /[.\-\ ]/, ""
        raise ArgumentError, "El rut está vacío" unless rut.length > 0
        raise ArgumentError, "El rut '#{rut}' contiene caracteres inválidos" unless rut =~ /^\d{1,8}[\dkK]$/
      end
      rut = rut.to_s
      thisdv = rut[-1, 1]
      rut = rut[0, rut.length - 1]
      raise ArgumentError, "El rut #{rut}-#{thisdv} es inválido" if validate && dv(rut).to_s.upcase != thisdv.upcase
      rut = rut.reverse.gsub(/.{3}/, '\0.').gsub(/\.$/, '').reverse
      "#{rut}-#{thisdv}"
    end
  end
end
