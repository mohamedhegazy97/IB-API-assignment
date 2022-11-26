module Searchable
    extend ActiveSupport::Concern
  
    included do
      include Elasticsearch::Model
      include Elasticsearch::Model::Callbacks

      Elasticsearch::Model.client = Elasticsearch::Client.new(host:'es')
      mapping do
        # mapping definition goes here
        indexes :content, type: :string
      end
  
      def self.search(query, chat_id = nil)
        params = {
          query: {
            bool: {
              must: [
                {
                  multi_match: {
                    query: query, 
                    fields: [ :content ] 
                  }
                },
              ],
              filter: [
                {
                  term: { chat_id: chat_id }
                }
              ]
            }
          }
        }
    
        self.__elasticsearch__.search(params)
      end
    end
  end