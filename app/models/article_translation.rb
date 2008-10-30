class ArticleTranslation < GstDb
  belongs_to :localedb
  belongs_to :article
end
