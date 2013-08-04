require "#{File.dirname(__FILE__)}/../normalize.rb"

describe "#normalize" do

	subject { normalize data }

	shared_examples 'parser' do
		it 'should properly parse data' do
			subject.should eq path: path, type: type, fragment: fragment, symbol: symbol
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
		let(:type)		{ 'Constructor' }
		let(:fragment)	{ '#DOMEvent:constructor' }
		let(:symbol)	{ 'DOMEvent' }

		it_should_behave_like 'parser'
	end

	context 'JSON Object' do
		let(:data) { 'mootools-core/Docs/Utilities/JSON.md:# Object: JSON {#JSON}' }

		let(:path)		{ 'mootools-core/Docs/Utilities/JSON.md' }
		let(:type)		{ 'Object' }
		let(:symbol)	{ 'JSON' }
		let(:fragment)	{ '#JSON' }

		it_should_behave_like 'parser'
	end

	context 'static methods' do
		let(:data)		{ 'mootools-core/Docs/Types/String.md:Function: String.from {#String:String-from}' }

		let(:path)		{ 'mootools-core/Docs/Types/String.md' }
		let(:type)		{ 'Function' }
		let(:symbol)	{ 'String.from' }
		let(:fragment)	{ '#String:String-from' }

		it_should_behave_like 'parser'
	end

	context 'Type guide' do
		let(:data)		{ 'mootools-core/Docs/Core/Core.md:### Type {#Type}' }
		let(:symbol)	{ 'Types' }
		let(:type)		{ 'Guide' }
		let(:path)		{ 'mootools-core/Docs/Core/Core.md' }
		let(:fragment)	{ '#Type' }

		it_should_behave_like 'parser'
	end

	context 'Generics guide' do
		let(:data)		{ 'mootools-core/Docs/Core/Core.md:## Generics {#Type:generics}' }
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

		let(:symbol)	{ 'Browser.Engine' }
		let(:type)		{ 'Object' }
		let(:path)		{ 'mootools-core/Docs/Browser/Browser.md' }
		let(:fragment)	{ '#Deprecated' }

		it_should_behave_like 'parser'
	end

	context 'Classes in class namespaces' do
		let(:data)		{ 'mootools-core/Docs/Request/Request.JSON.md:Class: Request.JSON {#Request-JSON}' }

		let(:symbol)	{ 'Request.JSON' }
		let(:type)		{ 'Class' }
		let(:path)		{ 'mootools-core/Docs/Request/Request.JSON.md' }
		let(:fragment)	{ '#Request-JSON' }

		it_should_behave_like 'parser'
	end

	context 'Fx.Transitions' do
		let(:data)		{ 'mootools-core/Docs/Fx/Fx.Transitions.md:Fx.Transitions Method: linear {#Fx-Transitions:linear}' }

		let(:symbol)	{ 'Fx.Transitions.linear' }
		let(:type)		{ 'Function' }
		let(:path)		{ 'mootools-core/Docs/Fx/Fx.Transitions.md' }
		let(:fragment)	{ '#Fx-Transitions:linear' }

		it_should_behave_like 'parser'
	end

	context 'Fx.Morph' do
		let(:data)		{ 'mootools-core/Docs/Fx/Fx.Morph.md:Class: Fx.Morph {#Fx-Morph}' }

		let(:symbol)	{ 'Fx.Morph' }
		let(:type)		{ 'Class' }
		let(:path)		{ 'mootools-core/Docs/Fx/Fx.Morph.md' }
		let(:fragment)	{ '#Fx-Morph' }

		it_should_behave_like 'parser'
	end

	context 'Fx.Morph.set' do
		let(:data)		{ 'mootools-core/Docs/Fx/Fx.Morph.md:Fx.Morph Method: set {#Fx-Morph:set}' }

		let(:symbol)	{ 'Fx.Morph.set' }
		let(:type)		{ 'Method' }
		let(:path)		{ 'mootools-core/Docs/Fx/Fx.Morph.md' }
		let(:fragment)	{ '#Fx-Morph:set' }

		it_should_behave_like 'parser'
	end

	context 'constructors' do
		let(:data) { 'mootools-core/Docs/Fx/Fx.Tween.md:Fx.Tween Method: constructor {#Fx-Tween:constructor}' }

		let(:symbol)	{ 'Fx.Tween' }
		let(:type)		{ 'Constructor' }
		let(:path)		{ 'mootools-core/Docs/Fx/Fx.Tween.md' }
		let(:fragment)	{ '#Fx-Tween:constructor' }

		it_should_behave_like 'parser'
	end

	context 'Object in a namespace' do
		let(:data)		{ 'mootools-core/Docs/Element/Element.Event.md:Object: Element.NativeEvents {#Element-NativeEvents}' }

		let(:symbol)	{ 'Element.NativeEvents' }
		let(:type)		{ 'Object' }
		let(:path)		{ 'mootools-core/Docs/Element/Element.Event.md' }
		let(:fragment)	{ '#Element-NativeEvents' }

		it_should_behave_like 'parser'
	end

	context 'Cookie options as a block of its own' do
		let(:data) { 'mootools-core/Docs/Utilities/Cookie.md:## Options: {#Cookie-options}' }

		it_should_behave_like 'rejected'
	end

	context 'Number Math aliases' do
		let(:data)		{ 'mootools-core/Docs/Types/Number.md:Math Methods {#Number-Math}' }

		let(:symbol)	{ 'Number.Math' }
		let(:type)		{ 'Guide' }
		let(:path)		{ 'mootools-core/Docs/Types/Number.md' }
		let(:fragment)	{ '#Number-Math' }

		it_should_behave_like 'parser'
	end

	context '$ function' do
		let(:data)		{ 'mootools-core/Docs/Element/Element.md:Function: $ {#Window:dollar}' }

		let(:symbol)	{ '$' }
		let(:type)		{ 'Function' }
		let(:path)		{ 'mootools-core/Docs/Element/Element.md' }
		let(:fragment)	{ '#Window:dollar' }

		it_should_behave_like 'parser'
	end

	context 'Window as a type' do
		let(:data) { 'mootools-core/Docs/Element/Element.md:Type: Window {#Window}' }

		it_should_behave_like 'rejected'
	end

	describe 'Slick' do

		context 'main object' do
			let(:data)		{ 'mootools-core/Docs/Slick/Slick.md:Slick {#Slick}' }

			let(:symbol)	{ 'Slick' }
			let(:type)		{ 'Guide' }
			let(:path)		{ 'mootools-core/Docs/Slick/Slick.md' }
			let(:fragment)	{ '#Slick' }

			it_should_behave_like 'parser'
		end

		context 'selectors without hyphens' do
			let(:data)		{ 'mootools-core/Docs/Slick/Slick.md:Selector: Next Siblings (\'~\') {#Slick:nextSiblings}' }

			let(:symbol)	{ 'Next Siblings (\'~\')' }
			let(:type)		{ 'Notation' }
			let(:path)		{ 'mootools-core/Docs/Slick/Slick.md' }
			let(:fragment)	{ '#Slick:nextSiblings' }

			it_should_behave_like 'parser'
		end

		context 'selectors with hyphens' do
			let(:data) { 'mootools-core/Docs/Slick/Slick.md:Selector: nth-child {#Slick:nth-child}' }

			let(:symbol) { 'nth-child' }
			let(:type) { 'Notation' }
			let(:path) { 'mootools-core/Docs/Slick/Slick.md' }
			let(:fragment) { '#Slick:nth-child' }

			it_should_behave_like 'parser'
		end

	end

	context 'Browser sub-objects' do
		let(:data)		{ 'mootools-core/Docs/Browser/Browser.md:Browser.Features {#Browser:Browser-Features}' }

		let(:symbol)	{ 'Browser.Features' }
		let(:type)		{ 'Object' }
		let(:path)		{ 'mootools-core/Docs/Browser/Browser.md' }
		let(:fragment)	{ '#Browser:Browser-Features' }

		it_should_behave_like 'parser'
	end

end