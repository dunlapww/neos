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
    "| #{ column_data.map { |_,col| col[:label].ljust(col[:width]) }.join(' | ') } |\n"
  end

  def divider
    "+-#{column_data.map { |_,col| "-"*col[:width] }.join('-+-') }-+\n"
  end


  def create_rows
    @row_data.map { |row_detail| display_row(row_detail) }
  end

  def display_table
    layout = ""
    layout << divider
    layout << header
    create_rows.each {|row| layout << row}
    layout << divider
  end
  
  private

  def format_row_data(row_detail)
    row_detail.keys.map { |key| row_detail[key].ljust(column_data[key][:width]) }.join(' | ')
  end

  def display_row(row_detail)
    "| #{format_row_data(row_detail)} |\n"
  end

end