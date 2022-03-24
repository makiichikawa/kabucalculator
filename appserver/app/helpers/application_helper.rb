# frozen_string_literal: true

module ApplicationHelper
   def default_meta_tags
    {
      site: 'KabuCalculator',
      title: 'KabuCalculator',
      reverse: true,
      charset: 'utf-8',
      description: '統計指標に基づいた株式比較、抽出ツール',
      viewport: 'width=device-width, initial-scale=1.0',
      og: {
        title: :title,
        type: 'website',
        site_name: :site,
        description: :description,
        image: 'https://kabucalculator.ml/ogp/ogp.png',
        url: 'https://kabucalculator.ml'
      },
      twitter: {
        title: :title,
        card: 'summary',
        site: '@kabucalculator',
        description: :description,
        image: 'https://kabucalculator.ml/ogp/ogp-twitter.png',
        domain: 'https://kabucalculator.ml'
      }
    }
  end
end
