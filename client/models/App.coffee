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

    if player.scores()[1] <= 21 then playerScore = player.scores()[1]
    else playerScore = player.scores()[0]

    if dealer.scores()[1] <= 21 then dealerScore = dealer.scores()[1]
    else dealerScore = dealer.scores()[0]

    if dealerScore > 21 then alert 'dealer bust you win'
    else if dealerScore > playerScore then alert 'dealer wins'
    else if playerScore > dealerScore then alert 'player wins'
    else alert 'draw'
