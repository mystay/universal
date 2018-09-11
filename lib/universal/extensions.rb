class String
  def sanitize(delimiter='-')
    self.gsub(/[^a-z0-9]+/i, delimiter).downcase.chomp('-')
  end
  def number?
    self.gsub!(',','')
    !!(self =~ /^[-+]?[0-9]+$/)
  end
  def self.random(length=8)
    SecureRandom.urlsafe_base64(length)[0,length]
  end
  def abbreviate
    self.split(' ').map{|a| a[0].upcase}.join('')
  end
  def to_array
    [self]
  end
end
class Float
  def round2
    (((((self*1000.00000001).round)/1000.00000001) * 100.00000001).round)/100.0
  end
  def round3
    (((self*1000.00000001).round)/1000.0)
  end
end
class Array
  def avg
    self.sum.to_f / self.length.to_f
  end
  def to_array
    self
  end
  def strip
    self.map{|s| s.strip if !s.blank?}.compact
  end
  def to_string
    self.map{|s| s.to_s}
  end
  def sanitize
    self.map{|v| v.to_s.strip.sanitize}
  end
end
class Symbol
  def titleize
    self.to_s.titleize
  end
end
class NilClass
  def titleize
    self.to_s.titleize
  end
  def upcase
    self.to_s.upcase
  end
  def html_safe
    self.to_s.html_safe
  end
  def sanitize
    self.to_s.sanitize
  end
  def name
    'Unknown'
  end
end
class Hash
  def sanitize
    self.transform_values{|a| a.sanitize}
  end
end
