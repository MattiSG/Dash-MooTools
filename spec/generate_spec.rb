require "#{File.dirname(__FILE__)}/../generate.rb"

describe "#normalize" do
	
	subject { normalize data }

	context 'DOMEvent constructor' do
		let(:data) { 'mootools-core/Docs/Types/DOMEvent.md:DOMEvent Method: constructor {#DOMEvent:constructor}' }

		it { should eq path: 'mootools-core/Docs/Types/DOMEvent.md', class_name: 'DOMEvent ', type: 'Method' }
	end
end