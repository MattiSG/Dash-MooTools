require "#{File.dirname(__FILE__)}/../normalize.rb"

describe "#normalize" do

	subject { normalize data }

	shared_examples 'parser' do
		it 'should properly parse data' do
			subject.should eq path: path, namespace: namespace, type: type, fragment: fragment, symbol: symbol
		end
	end

	context 'DOMEvent constructor' do
		let(:data) { 'mootools-core/Docs/Types/DOMEvent.md:DOMEvent Method: constructor {#DOMEvent:constructor}' }

		let(:path)		{ 'mootools-core/Docs/Types/DOMEvent.md' }
		let(:namespace)	{ 'DOMEvent' }
		let(:type)		{ 'Method' }
		let(:fragment)	{ '#DOMEvent:constructor' }
		let(:symbol)	{ 'constructor' }

		it_should_behave_like 'parser'
	end

	context 'JSON Object' do
		let(:data) { 'mootools-core/Docs/Utilities/JSON.md:# Object: JSON {#JSON}' }

		let(:path)		{ 'mootools-core/Docs/Utilities/JSON.md' }
		let(:namespace)	{ nil }
		let(:type)		{ 'Object' }
		let(:symbol)	{ 'JSON' }
		let(:fragment)	{ '#JSON' }

		it_should_behave_like 'parser'
	end

	context 'static methods' do
		let(:data)		{ 'mootools-core/Docs/Types/String.md:Function: String.from {#String:String-from}' }

		let(:path)		{ 'mootools-core/Docs/Types/String.md' }
		let(:namespace)	{ nil }
		let(:type)		{ 'Function' }
		let(:symbol)	{ 'String.from' }	# this is not exact, it could be in the 'String' namespace, but in the end, you'll look for it the same way
		let(:fragment)	{ '#String:String-from' }

		it_should_behave_like 'parser'
	end

end