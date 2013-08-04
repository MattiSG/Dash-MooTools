require "#{File.dirname(__FILE__)}/../normalize.rb"

describe "#normalize" do

	subject { normalize data }

	shared_examples 'parser' do
		it 'should properly parse data' do
			subject.should eq path: path, namespace: namespace, type: type, fragment: fragment, symbol: symbol
		end
	end

	shared_examples 'rejected' do
		it 'should reject the entry' do
			subject.should be_nil
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

	context 'Type guide' do
		let(:data)		{ 'mootools-core/Docs/Core/Core.md:### Type {#Type}' }
		let(:namespace)	{ nil }
		let(:symbol)	{ 'Types' }
		let(:type)		{ 'Guide' }
		let(:path)		{ 'mootools-core/Docs/Core/Core.md' }
		let(:fragment)	{ '#Type' }

		it_should_behave_like 'parser'
	end

	context 'Generics guide' do
		let(:data)		{ 'mootools-core/Docs/Core/Core.md:## Generics {#Type:generics}' }
		let(:namespace)	{ nil }
		let(:symbol)	{ 'Generics' }
		let(:type)		{ 'Guide' }
		let(:path)		{ 'mootools-core/Docs/Core/Core.md' }
		let(:fragment)	{ '#Type:generics' }

		it_should_behave_like 'parser'
	end

	context 'Core' do
		let(:data) { 'mootools-core/Docs/Core/Core.md:# Type: Core {#Core}' }

		it_should_behave_like 'rejected'
	end

	context 'Deprecated functions headline' do
		let(:data) { 'mootools-core/Docs/Core/Core.md:Deprecated Functions {#Deprecated-Functions}' }

		it_should_behave_like 'rejected'
	end

	context 'Deprecated Browser.Engine' do
		let(:data)		{ 'mootools-core/Docs/Browser/Browser.md:Deprecated {#Deprecated}' }

		let(:namespace)	{ nil }
		let(:symbol)	{ 'Browser.Engine' }
		let(:type)		{ 'Object' }
		let(:path)		{ 'mootools-core/Docs/Browser/Browser.md' }
		let(:fragment)	{ '#Deprecated' }

		it_should_behave_like 'parser'
	end

	context 'Classes in class namespaces' do
		let(:data)		{ 'mootools-core/Docs/Request/Request.JSON.md:Class: Request.JSON {#Request-JSON}' }

		let(:namespace)	{ nil }	# this is not exact, it could be in the 'Request' namespace, but in the end, you'll look for it the same way
		let(:symbol)	{ 'Request.JSON' }
		let(:type)		{ 'Class' }
		let(:path)		{ 'mootools-core/Docs/Request/Request.JSON.md' }
		let(:fragment)	{ '#Request-JSON' }

		it_should_behave_like 'parser'
	end

end