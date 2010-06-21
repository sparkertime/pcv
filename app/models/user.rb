class User < ActiveRecord::Base
  include SimplestAuth::Model

  authenticate_by :name

  validates_uniqueness_of :name
  validates_presence_of :name, :password, :password_confirmation

  validates_confirmation_of :password

  CONTAINS_LETTER = '(?=.*[a-z])'
  CONTAINS_NUMBER = '(?=.*\d)'
  CONTAINS_SYMBOL = '(?=.*[^\s\da-z])'
  DOES_NOT_CONTAIN_SPACE = '(?!.*\s)'
  validates_format_of :password, :with => /#{CONTAINS_NUMBER}#{CONTAINS_LETTER}#{CONTAINS_SYMBOL}#{DOES_NOT_CONTAIN_SPACE}/
end
