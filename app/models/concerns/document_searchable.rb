# frozen_string_literal: true

module DocumentSearchable
  extend ActiveSupport::Concern

  included do
    include Searchable

    settings index: {
      analysis: {
        tokenizer: {
          kuromoji_tokenizer: {
            type: 'kuromoji_tokenizer',
            mode: 'search'
          }
        },
        filter: {
          pos_filter: {
            type: 'kuromoji_part_of_speech',
            stoptags: %w(助詞-格助詞-一般 助詞-終助詞)
          },
          greek_lowercase_filter: {
            type: 'lowercase',
            language: 'greek'
          }
        },
        char_filter: {
          custom_mapping: {
            type: 'mapping',
            mappings: %w(ｶ=>カ ｶﾞ=>ガ)
          }
        },
        analyzer: {
          kuromoji_analyzer: {
            type:      'custom',
            tokenizer: 'kuromoji_tokenizer',
            filter: %w(kuromoji_baseform pos_filter greek_lowercase_filter cjk_width),
            char_filter: %w(custom_mapping)
          }
        }
      }
    }

    mappings dynamic: 'false' do
      indexes :title, analyzer: 'kuromoji_analyzer', type: 'text'
      indexes :body, analyzer: 'kuromoji_analyzer', type: 'text'
    end
  end
end
