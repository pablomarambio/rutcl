#coding: utf-8
require 'test_helper'

describe Rutcl::Rut do
  describe "complete RUT" do
    describe "validations" do
      it "should detect empty ruts" do
        assert_raises(ArgumentError) { Rutcl::Rut.format_rut_with_dv "" }
        assert_raises(ArgumentError) { Rutcl::Rut.format_rut_with_dv nil }
      end
      it "should detect non-ruts" do
        assert_raises(ArgumentError) { Rutcl::Rut.format_rut_with_dv "hola" }
        assert_raises(ArgumentError) { Rutcl::Rut.format_rut_with_dv "14x569-484-1" }
        assert_raises(ArgumentError) { Rutcl::Rut.format_rut_with_dv "14569a484-1" }
        assert_raises(ArgumentError) { Rutcl::Rut.format_rut_with_dv "14569484/1" }
        assert_raises(ArgumentError) { Rutcl::Rut.format_rut_with_dv "14 569x484 1" }
      end
      it "should detect invalid ruts" do
        assert_raises(ArgumentError) { Rutcl::Rut.format_rut_with_dv "1-8" }
        assert_raises(ArgumentError) { Rutcl::Rut.format_rut_with_dv "100.001-1" }
        assert_raises(ArgumentError) { Rutcl::Rut.format_rut_with_dv "14.569.484-2" }
      end
      it "should dismiss invalid ruts if told so" do
        Rutcl::Rut.format_rut_with_dv("1-8", false).must_be_instance_of String
        Rutcl::Rut.format_rut_with_dv("100.001-1", false).must_be_instance_of String
        Rutcl::Rut.format_rut_with_dv("14.569.484-2", false).must_be_instance_of String
      end
    end
    describe "formatting" do
      it "should work with unformatted ruts" do
        Rutcl::Rut.format_rut_with_dv(19).must_equal "1-9"
        Rutcl::Rut.format_rut_with_dv(124).must_equal "12-4"
        Rutcl::Rut.format_rut_with_dv("104k").must_equal "104-K"
        Rutcl::Rut.format_rut_with_dv("10006").must_equal "1.000-6"
        Rutcl::Rut.format_rut_with_dv("100005").must_equal "10.000-5"
        Rutcl::Rut.format_rut_with_dv("1000012").must_equal "100.001-2"
        Rutcl::Rut.format_rut_with_dv("79567728").must_equal "7.956.772-8"
        Rutcl::Rut.format_rut_with_dv("145694841").must_equal "14.569.484-1"
      end
      it "should work with partially formatted ruts" do
        Rutcl::Rut.format_rut_with_dv("1000-6").must_equal "1.000-6"
        Rutcl::Rut.format_rut_with_dv("10000-5").must_equal "10.000-5"
        Rutcl::Rut.format_rut_with_dv("100001-2").must_equal "100.001-2"
        Rutcl::Rut.format_rut_with_dv("7956772-8").must_equal "7.956.772-8"
        Rutcl::Rut.format_rut_with_dv("14569484-1").must_equal "14.569.484-1"
      end
      it "should work with fully formatted ruts" do
        Rutcl::Rut.format_rut_with_dv("1.000-6").must_equal "1.000-6"
        Rutcl::Rut.format_rut_with_dv("10.000-5").must_equal "10.000-5"
        Rutcl::Rut.format_rut_with_dv("100.001-2").must_equal "100.001-2"
        Rutcl::Rut.format_rut_with_dv("7.956.772-8").must_equal "7.956.772-8"
        Rutcl::Rut.format_rut_with_dv("14.569.484-1").must_equal "14.569.484-1"
      end
      it "should work with ruts with spaces" do
        Rutcl::Rut.format_rut_with_dv("1 9").must_equal "1-9"
        Rutcl::Rut.format_rut_with_dv("  12 4").must_equal "12-4"
        Rutcl::Rut.format_rut_with_dv("104 k").must_equal "104-K"
        Rutcl::Rut.format_rut_with_dv("100 0 6").must_equal "1.000-6"
      end
    end
  end
  describe "incomplete RUT" do
    describe "validations" do
      it "should detect empty ruts" do
        assert_raises(ArgumentError) { Rutcl::Rut.format_rut_without_dv "" }
        assert_raises(ArgumentError) { Rutcl::Rut.format_rut_without_dv nil }
      end
      it "should detect non-ruts" do
        assert_raises(ArgumentError) { Rutcl::Rut.format_rut_without_dv "hola" }
        assert_raises(ArgumentError) { Rutcl::Rut.format_rut_without_dv "14x569-484" }
        assert_raises(ArgumentError) { Rutcl::Rut.format_rut_without_dv "14569a484" }
        assert_raises(ArgumentError) { Rutcl::Rut.format_rut_without_dv "14569484/1" }
        assert_raises(ArgumentError) { Rutcl::Rut.format_rut_without_dv "14 569x484 1" }
      end
      it "should reject already formatted ruts" do
        assert_raises(ArgumentError) { Rutcl::Rut.format_rut_without_dv "15.776.844-1" }
        assert_raises(ArgumentError) { Rutcl::Rut.format_rut_without_dv "14.569.484-1" }
        assert_raises(ArgumentError) { Rutcl::Rut.format_rut_without_dv "12-4" }
        assert_raises(ArgumentError) { Rutcl::Rut.format_rut_without_dv "104-K" }
        assert_raises(ArgumentError) { Rutcl::Rut.format_rut_without_dv "104-k" }
      end
    end
    describe "formatting" do
      it "should work with unformatted ruts" do
        Rutcl::Rut.format_rut_without_dv("1").must_equal "1-9"
        Rutcl::Rut.format_rut_without_dv("12").must_equal "12-4"
        Rutcl::Rut.format_rut_without_dv("104").must_equal "104-K"
        Rutcl::Rut.format_rut_without_dv("1000").must_equal "1.000-6"
        Rutcl::Rut.format_rut_without_dv("10000").must_equal "10.000-5"
        Rutcl::Rut.format_rut_without_dv("100001").must_equal "100.001-2"
        Rutcl::Rut.format_rut_without_dv("7956772").must_equal "7.956.772-8"
        Rutcl::Rut.format_rut_without_dv("14569484").must_equal "14.569.484-1"
        Rutcl::Rut.format_rut_without_dv(1).must_equal "1-9"
        Rutcl::Rut.format_rut_without_dv(12).must_equal "12-4"
        Rutcl::Rut.format_rut_without_dv(104).must_equal "104-K"
        Rutcl::Rut.format_rut_without_dv(1000).must_equal "1.000-6"
        Rutcl::Rut.format_rut_without_dv(10000).must_equal "10.000-5"
        Rutcl::Rut.format_rut_without_dv(100001).must_equal "100.001-2"
        Rutcl::Rut.format_rut_without_dv(7956772).must_equal "7.956.772-8"
        Rutcl::Rut.format_rut_without_dv(14569484).must_equal "14.569.484-1"
      end
    end
  end
end
