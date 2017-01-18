RSpec.describe CursesWrapper::Keyboard do
  describe "#keys" do
    it "maps the number 1 to its ASCII number" do
      expect(subject.keys[:one]).to eq 49
    end

    it "maps the up_arrow to its ASCII number" do
      expect(subject.keys[:up_arrow]).to eq 259
    end
    
    it "maps the down_arrow to its ASCII number" do
      expect(subject.keys[:down_arrow]).to eq 258
    end
    
    it "maps the left_arrow to its ASCII number" do
      expect(subject.keys[:left_arrow]).to eq 260
    end
    
    it "maps the right_arrow to its ASCII number" do
      expect(subject.keys[:right_arrow]).to eq 261
    end
    
    it "maps the x key to its ASCII number" do
      expect(subject.keys[:x]).to eq 120
    end
    
    it "maps the q to its ASCII number" do
      expect(subject.keys[:q]).to eq 113
    end
    
    it "maps the r to its ASCII number" do
      expect(subject.keys[:r]).to eq 114
    end
    
    it "maps the d to its ASCII number" do
      expect(subject.keys[:d]).to eq 100
    end

    it "maps the o to its ASCII number" do
      expect(subject.keys[:o]).to eq 111
    end

    it "maps the O to its ASCII number" do
      expect(subject.keys[:O]).to eq 79
    end

    it "maps the return_key to its ASCII number" do
      expect(subject.keys[:return_key]).to eq [343, 10, 13]
    end
  end
end