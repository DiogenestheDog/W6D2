require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @columns if @columns
    @columns ||= DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
      LIMIT
        1
    SQL

    @columns = @columns[0].map! { |col| col.to_sym }
 
   
  end

  def self.finalize!
    # Now we can finally write ::finalize!. It should iterate through all 
    # the ::columns, using define_method (twice) to create a getter and 
    # setter method for each column, just like my_attr_accessor. But this 
    # time, instead of dynamically creating an instance variable, store 
    # everything in the #attributes hash.

    self.columns.each do |col|
    
      define_method("#{col}=") do |new_val|
      
      self.attributes[col] = new_val
        
      end
      define_method("#{col}") do
        self.attributes[col]
      end
    end
  end

  def self.table_name=(table_name)
    @name = table_name
  end

  def self.table_name
    @name ||= "#{self}".tableize
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    # params.each do |k, v|
    #   if attributes[k.to_sym].nil?
    #     raise "unknown attribute '#{attr_name}'"
    #   else

    # end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
