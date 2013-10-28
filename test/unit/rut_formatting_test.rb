#coding: utf-8
require 'test_helper'

describe Rut do
  describe "pretty" do
    describe "validations" do
      it "should detect empty ruts" do
        assert_raises(ArgumentError) { Rut.pretty "" }
        assert_raises(ArgumentError) { Rut.pretty nil }
      end
      it "should detect non-ruts" do
        assert_raises(ArgumentError) { Rut.pretty "hola" }
        assert_raises(ArgumentError) { Rut.pretty "14x569-484-1" }
        assert_raises(ArgumentError) { Rut.pretty "14569a484-1" }
        assert_raises(ArgumentError) { Rut.pretty "14569484/1" }
        assert_raises(ArgumentError) { Rut.pretty "14 569x484 1" }
      end
      it "should detect invalid ruts" do
        assert_raises(ArgumentError) { Rut.pretty "1-8" }
        assert_raises(ArgumentError) { Rut.pretty "100.001-1" }
        assert_raises(ArgumentError) { Rut.pretty "14.569.484-2" }
      end
    end
    describe "formatting" do
      it "should work with unformatted ruts" do
        Rut.pretty(19).must_equal "1-9"
        Rut.pretty(124).must_equal "12-4"
        Rut.pretty("104k").must_equal "104-k"
        Rut.pretty("10006").must_equal "1.000-6"
        Rut.pretty("100005").must_equal "10.000-5"
        Rut.pretty("1000012").must_equal "100.001-2"
        Rut.pretty("79567728").must_equal "7.956.772-8"
        Rut.pretty("145694841").must_equal "14.569.484-1"
      end
      it "should work with partially formatted ruts" do
        Rut.pretty("1000-6").must_equal "1.000-6"
        Rut.pretty("10000-5").must_equal "10.000-5"
        Rut.pretty("100001-2").must_equal "100.001-2"
        Rut.pretty("7956772-8").must_equal "7.956.772-8"
        Rut.pretty("14569484-1").must_equal "14.569.484-1"
      end
      it "should work with fully formatted ruts" do
        Rut.pretty("1.000-6").must_equal "1.000-6"
        Rut.pretty("10.000-5").must_equal "10.000-5"
        Rut.pretty("100.001-2").must_equal "100.001-2"
        Rut.pretty("7.956.772-8").must_equal "7.956.772-8"
        Rut.pretty("14.569.484-1").must_equal "14.569.484-1"
      end
      it "should work with ruts with spaces" do
        Rut.pretty("1 9").must_equal "1-9"
        Rut.pretty("  12 4").must_equal "12-4"
        Rut.pretty("104 k").must_equal "104-k"
        Rut.pretty("100 0 6").must_equal "1.000-6"
      end
    end
  end
end
