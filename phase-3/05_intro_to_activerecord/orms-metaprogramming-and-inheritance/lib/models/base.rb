class Base

  ## our all and initialize and attr accessors will be defined here
  def self.inherited(subclass)
    subclass.column_names.each do |column_name|
      subclass.attr_accessor(column_name)
    end
  end

  def self.all
    table_name_is_valid!
    rows = DB.execute("SELECT * FROM #{self.table_name}")
    rows.map do |row|
      attributes = row.reject{|k,v| k.is_a?(Integer)}
      self.new(attributes)
    end
  end

  def self.table_name
    self.name.tableize
  end

  def self.columns 
    table_name_is_valid!
    DB.execute("PRAGMA table_info(#{self.table_name})").map do |c|
      {
        name: c["name"],
        type: c["type"]
      }
    end
  end

  def self.column_names
    self.columns.map{|c| c[:name]}
  end

  def initialize(row)
    row.each do |column_name, value|
      self.send("#{column_name}=", value)
    end
  end

  private

  def self.table_name_is_valid!
    raise StandardError.new("#{self.table_name} table does not exist") unless DB.execute("SELECT * FROM sqlite_master WHERE type='table'").map {|t| t[1]}.include?(self.table_name)
  end

end