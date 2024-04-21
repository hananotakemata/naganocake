class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy

    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  def full_address
    "#{postal_code} #{address}"
  end

  def full_name
    "#{last_name} #{first_name}"
  end


  def customer_status
    if is_deleted
      "退会"
    else
      "有効"
    end
  end

end
