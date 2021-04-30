class List < ApplicationRecord
  attachment :image
  # Refileを使うには、attachmentメソッドをモデルに追加する必要があります。
  # attachment（アタッチメント）メソッドとは、refileが指定のカラムにアクセスするために必要です。
end
