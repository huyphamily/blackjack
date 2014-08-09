#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on('stand', @dealerPlay)

  dealerPlay: =>
    dealer = @get 'dealerHand'
    if !dealer.at(0).get('revealed') then dealer.at(0).flip()

    if dealer.scores()[1]? and dealer.scores()[1] < 17 then dealer.hit(); @dealerPlay()
    else if dealer.scores()[0] < 17 then dealer.hit(); @dealerPlay()
    else @gameEnd()

  gameEnd: ->
    dealer = @get 'dealerHand'
    player = @get 'playerHand'
    if (dealer.scores(1) or dealer.scores()[0]) > (player.scores()[1] or player.scores()[0]) then console.log 'dealer wins'
    else console.log 'player wins'

