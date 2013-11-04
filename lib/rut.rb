#coding: utf-8
module Rutcl
  class Rut

    VERSION = "1.1.0"

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

      def valid? rut_with_dv
        return true if format_rut_with_dv(rut_with_dv) rescue false
      end

      def format_rut_with_dv rut_with_dv, validate=true
        if rut_with_dv.is_a? String
          rut_with_dv.gsub! /[.\-\ ]/, ""
          raise ArgumentError, "El rut está vacío" unless rut_with_dv.length > 0
          raise ArgumentError, "El rut '#{rut_with_dv}' contiene caracteres inválidos" unless rut_with_dv =~ /^\d{1,8}[\dkK]$/
        end
        rut_with_dv = rut_with_dv.to_s.upcase
        thisdv = rut_with_dv[-1, 1]
        rut_without_dv = rut_with_dv[0, rut_with_dv.length - 1]
        formatted_rut = format_rut_without_dv(rut_without_dv)
        correct_dv = formatted_rut[-1, 1]
        raise ArgumentError, "El rut #{rut_without_dv}-#{thisdv} es inválido" if validate && thisdv != correct_dv
        formatted_rut
      end

      def format_rut_without_dv rut_without_dv
        if rut_without_dv.is_a? String
          rut_without_dv.gsub! /[.\ ]/, ""
          raise ArgumentError, "El rut está vacío" unless rut_without_dv.length > 0
          raise ArgumentError, "El rut '#{rut_without_dv}' contiene caracteres inválidos (use el método 'format_rut_with_dv' para RUTs que incluyan dígito veriicador)" unless rut_without_dv =~ /^\d{1,8}$/
        end
        rut_without_dv = rut_without_dv.to_s.upcase
        dv = dv(rut_without_dv).to_s.upcase
        rut_without_dv = rut_without_dv.reverse.gsub(/.{3}/, '\0.').gsub(/\.$/, '').reverse
        "#{rut_without_dv}-#{dv}"
      end
    end
  end
end
