class User < ApplicationRecord
  before_save { self.email.downcase! } #保存前に小文字に変換
  validates :name, presence: true, length: { maximum: 50 } #null NG, ~50 characters
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, #正規表現指定
                    uniqueness: { case_sensitive: false } #重複不可
  has_secure_password
  
  has_many :tasks
end

