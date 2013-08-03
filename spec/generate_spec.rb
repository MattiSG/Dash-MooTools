require "#{File.dirname(__FILE__)}/../normalize.rb"

describe "#normalize" do

	subject { normalize data }

	shared_examples 'parser' do
		it 'should properly parse data' do
			subject.should eq path: path, class_name: class_name, type: type, fragment: fragment, symbol: symbol
		end
	end

	context 'DOMEvent constructor' do
		let(:data) { 'mootools-core/Docs/Types/DOMEvent.md:DOMEvent Method: constructor {#DOMEvent:constructor}' }

		let(:path)			{ 'mootools-core/Docs/Types/DOMEvent.md' }
		let(:class_name)	{ 'DOMEvent' }
		let(:type)			{ 'Method' }
		let(:fragment)		{ '#DOMEvent:constructor' }
		let(:symbol)		{ 'constructor' }

		it_should_behave_like 'parser'
	end
end