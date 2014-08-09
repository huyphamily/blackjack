#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on('stand', @dealerPlay)

  dealerPlay: =>
    dealer = @get 'dealerHand'
    if dealer.scores()[1]? and dealer.scores()[1] < 17 then dealer.hit(); @dealerPlay()
    else if dealer.scores()[0] < 17 then dealer.hit(); @dealerPlay()

