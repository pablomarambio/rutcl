#coding: utf-8
require 'test_helper'

describe Rut do
  describe "validations" do
    it "should detect invalid ruts" do
      Rut.valid?(1).must_equal false
      Rut.valid?(123).must_equal false
      Rut.valid?("1040").must_equal false
      Rut.valid?("10005").must_equal false
      Rut.valid?("100003").must_equal false
      Rut.valid?("1000011").must_equal false
      Rut.valid?("79567729").must_equal false
      Rut.valid?("14569484k").must_equal false
    end
    it "should recognize valid ruts" do
      Rut.valid?(19).must_equal true
      Rut.valid?(124).must_equal true
      Rut.valid?("104k").must_equal true
      Rut.valid?("10006").must_equal true
      Rut.valid?("100005").must_equal true
      Rut.valid?("1000012").must_equal true
      Rut.valid?("79567728").must_equal true
      Rut.valid?("145694841").must_equal true
    end
  end
end
