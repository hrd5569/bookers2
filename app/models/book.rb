class Book < ApplicationRecord

#optional: trueにするとPostテーブルの外部キーであるuser_idというカラムは、自動でNOT NULLになる。
  belongs_to :user

  validates :title, presence: { message: "can't be blank" }
  validates :body, presence: { message: "can't be blank" }, length: { maximum: 200 }
end
