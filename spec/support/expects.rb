module IsExpected
  def is_expected
    expect { subject }
  end
end

RSpec.configure do |c|
  c.include IsExpected
end
