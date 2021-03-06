RSpec.describe Mutant::Actor::Sender do
  let(:object)   { described_class.new(condition_variable, mutex, messages) }

  let(:condition_variable) { double('Condition Variable') }
  let(:mutex)              { double('Mutex')              }
  let(:messages)           { double('Messages')           }
  let(:type)               { double('Type')               }
  let(:payload)            { double('Payload')            }
  let(:_message)           { message(type, payload)       }

  describe '#call' do
    subject { object.call(_message) }

    before do
      expect(mutex).to receive(:synchronize).ordered.and_yield
      expect(messages).to receive(:<<).with(_message).ordered
      expect(condition_variable).to receive(:signal).ordered
    end

    it_should_behave_like 'a command method'
  end
end
