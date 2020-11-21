class Table
  attr_reader :column_labels, :row_data
  def initialize(column_labels, row_data)
    @column_labels = column_labels
    @row_data = row_data
  end

  def column_data
    @column_labels.each_with_object({}) do |(col, label), hash|
      hash[col] = {
        label: label,
        width: [@row_data.map { |row| row[col].size }.max, label.size].max}
    end
  end

  def header
    "| #{ column_data.map { |_,col| col[:label].ljust(col[:width]) }.join(' | ') } |"
  end

  def divider
    "+-#{column_data.map { |_,col| "-"*col[:width] }.join('-+-') }-+"
  end

  def format_row_data
    row = @row_data.keys.map { |key| @row_data[key].ljust(column_data[key][:width]) }.join(' | ')
    puts "| #{row} |"
  end
end