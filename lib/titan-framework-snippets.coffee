TitanFrameworkSnippetsView = require './titan-framework-snippets-view'
{CompositeDisposable} = require 'atom'

module.exports = TitanFrameworkSnippets =
  titanFrameworkSnippetsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @titanFrameworkSnippetsView = new TitanFrameworkSnippetsView(state.titanFrameworkSnippetsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @titanFrameworkSnippetsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'titan-framework-snippets:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @titanFrameworkSnippetsView.destroy()

  serialize: ->
    titanFrameworkSnippetsViewState: @titanFrameworkSnippetsView.serialize()

  toggle: ->
    console.log 'TitanFrameworkSnippets was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
