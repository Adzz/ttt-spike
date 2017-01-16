RSpec.describe CursesWrapper::Screen do
# TEST BEHAVIOUR NOT CONFIGURATION
# SO MAYBE WE TEST EACH OF THE SCREENS FOR THEIR BEHAVIOUR.
# NOT THE WRAPPER CLASS, AS THAT IS ALMOST JUST A DELEGATOR.  
  describe "#silent_keys" do
    subject { described_class.new }

    before do
      allow_any_instance_of(Curses).to receive(:noecho).and_return(true)
    end

    it "calls noecho" do
      subject.display { 
        expect(subject.silent_keys).to eq true
      }
    end
  end
end
