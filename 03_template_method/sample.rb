# 各Report用の抽象クラス
class Report
  def initialize
    @title = '月次報告'
    @text = %w(順調 最高)
  end

  def output_report
    output_start
    output_head
    output_body_start
    output_body
    output_body_end
    output_end
  end

  def output_start
  end

  def output_head
    output_line(@title)
  end

  def output_body_start
  end

  def output_body
    @text.each do |line|
      output_line(line)
    end
  end

  def output_line(line)
    raise 'Called abstract method: output_line'
  end

  def output_body_end
  end

  def output_end
  end
end

# HTML用のReportクラス
class HTMLReport < Report
  def output_start
    puts('<html>')
  end

  def output_head
    puts('  <head>')
    puts("    <title>#{@title}</title>")
    puts('  </head>')
  end

  def output_body_start
    puts('  <body>')
  end

  def output_line(line)
    puts("  <p>#{line}</p>")
  end

  def output_body_end
    puts('  </body>')
  end

  def output_end
    puts('</html>')
  end
end

# Text用のReportクラス
class PlainTextReport < Report
  def output_head
    puts("*** #{@title} ***")
    puts
  end

  def output_line(line)
    puts(line)
  end
end

# 実行
report = HTMLReport.new
report.output_report

puts ('------')

report = PlainTextReport.new
report.output_report
