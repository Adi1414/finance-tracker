class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def stock_already_tracked?(ticker_symbol)
    stock = Stock.check_db(ticker_symbol)
    return false unless stock
    stocks.where(id: stock.id).exists?    
  end
  
  def under_stock_limit?
    stocks.count < 10
  end

  def can_track_stock?(ticker_symbol)
    under_stock_limit? && !stock_already_tracked?(ticker_symbol)
  end
  
  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Annonymous"
  end

  def self.search(param)
    param.strip!
    match_result = (first_name(param) + last_name(param) + email(param)).uniq
    return nil unless match_result
    match_result
  end 

  def self.first_name(param)
    match('first_name',param)
  end

  def self.last_name(param)
    match('last_name',param)
  end 

 def self.email(param)
    match('email',param)
 end

  def self.match(field_name,param)
     User.where("#{field_name} like ?","%#{param}%")
  end

  def except_self(users)
      users.reject{ |user| user.id == self.id }
  end 

  def not_friends_with?(id_of_friend)
     ! self.friends.where(id: id_of_friend).exists?
  end 

end
