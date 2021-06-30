require 'pg'

class Space 
    attr_reader :name, :description, :price 
    
    def initialize(name:, description:, price:)
      @name = name
      @description = description
      @price = price
    end

    def self.all
    end

    def self.create(name:, description:, price:)
      if ENV['ENVIRONMENT'] =='test'
        connection = PG.connect(dbname: 'bnb_users_test')      
      else
        connection = PG.connect(dbname: 'bnb_users')   
      end

      result = connection.exec("INSERT INTO space (name, description, price) VALUES('#{name}', '#{description}', '#{price}') RETURNING name, description, price;")
      Space.new(name: result[0]['name'], description: result[0]['description'], price: result[0]['price'])
    end
end



