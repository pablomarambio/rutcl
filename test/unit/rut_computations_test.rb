#coding: utf-8
require 'test_helper'

describe Rut do
  describe "dv" do
    it "should only accept numbers" do
      assert_raises(ArgumentError) { Rut.dv "hola" }
      assert_raises(ArgumentError) { Rut.dv "1234a5678" }
    end
    describe "calculations" do
      describe "for numeric ruts" do
        it "should work with short ruts" do
          Rut.dv(1).must_equal 9
          Rut.dv(2).must_equal 7
          Rut.dv(12).must_equal 4
          Rut.dv(104).must_equal "k"
          Rut.dv(1000).must_equal 6
          Rut.dv(10000).must_equal 5
          Rut.dv(100001).must_equal 2
        end
        it "should work with large ruts" do
          Rut.dv(7956772).must_equal 8
          Rut.dv(8457638).must_equal 7
          Rut.dv(5954893).must_equal "k"
          Rut.dv(16365637).must_equal "k"
          Rut.dv(18439790).must_equal 0
          Rut.dv(11111111).must_equal 1
          Rut.dv(14569484).must_equal 1
        end
      end
      describe "for string ruts" do
        it "should work correct dvs" do
          Rut.dv("1").must_equal 9
          Rut.dv("2").must_equal 7
          Rut.dv("12").must_equal 4
          Rut.dv("104").must_equal "k"
          Rut.dv("1000").must_equal 6
          Rut.dv("10000").must_equal 5
          Rut.dv("100001").must_equal 2
        end
        it "should work with large ruts" do
          Rut.dv("7956772").must_equal 8
          Rut.dv("8457638").must_equal 7
          Rut.dv("5954893").must_equal "k"
          Rut.dv("16365637").must_equal "k"
          Rut.dv("18439790").must_equal 0
          Rut.dv("11111111").must_equal 1
          Rut.dv("14569484").must_equal 1
        end
      end
    end
  end
end
