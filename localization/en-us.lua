return {
    descriptions = {
        Back = {
            b_womsobsc_meme_deck = {
                name = "SaltyDKDeck",
                text = {
                    "Creates a {C:attention}Perishable{}",
                    "{C:attention}Meme Joker{} at the",
                    "start of the run and",
                    "after each boss blind"
                }
            },
            b_womsobsc_music_deck = {
                name = "Record Store Deck",
                text = {
                    "The first card in every",
                    "shop is a {C:attention}Music Joker{},",
                    "Start with an extra {C:money}$#1#{}"
                }
            }
        },
        Joker = {
            j_womsobsc_dorphis = {
                name = 'The Dorphis',
                text = {
                    "{X:mult,C:white}x#1#{} Mult, {X:chips,C:white}x#2#{} Chips"
                }
            },
            j_womsobsc_vegeta = {
                name= "The Vegeta",
                text = {
                    "This Joker gains {C:chips}#2#{} Chips", "for each card destroyed",
                    "and loses {C:chips}#3#{} Chips for each", "card added to your deck",
                    "{C:inactive}(Currently {C:chips}#1#{C:inactive} Chips)"
                }
            },
            j_womsobsc_couscous = {
                name= "Couscous Madame",
                text = {
                    "When blind is selected,",
                    "creates a random meme",
                    "joker and self destructs"
                }
            },
            j_womsobsc_jimbunculus = {
                name= "Jimbunculus",
                text = {
                    "{X:chips,C:white}x#1#{} Chips when a poker",
                    "hand is played for the", "first time this run"
                }
            },
            j_womsobsc_mall = {
                name= "Mall Wins For Now",
                text = {
                    "Half off in shop, {C:green}#1# in #2#{}",
                    "chance to self destruct",
                    "and create a {C:attention}Splash{} at",
                    "the end of the shop"
                }
            },
            j_womsobsc_brandon = {
                name= "Gambling City",
                text = {
                    "{C:chips}+#1#{} Chips and earn {C:money}$#2#{}",
                    "if played hand contains",
                    "exactly 2 cards"
                }
            },
            j_womsobsc_femboy = {
                name= "Peak Gambler Performance",
                text = {
                    "Each scoring {C:attention}Jack{} goes up {C:attention}1{} rank,",
                    "each scoring {C:attention}King{} goes down {C:attention}1{} rank"
                }
            },
            j_womsobsc_speen = {
                name= "Power Of SPEEN",
                text = {
                    "gains {C:mult}+#2#{} Mult when any",
                    "card is flipped, resets",
                    "at the end of the round",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
                }
            },
            j_womsobsc_charming = {
                name = 'Limited 3d',
                text = {
                    "Retrigger {C:attention}second{} played",
                    "card, {C:green}#1# in #2#{} chance to", 
                    "create a {C:dark_edition}negative{} {C:attention}copy{} at",
                    "the start of each round"
                }
            },
            j_womsobsc_boratTepig = {
                name = 'Bikes Do So Much!',
                text = {
                    "{X:mult,C:white}x#1#{} Mult if scoring", "hand contains a pair,",
                    "{X:mult,C:white}x#2#{} Mult if scoring", "hand contains two pair",
                    "{C:inactive}(doesn't stack){}"
                }
            },
            j_womsobsc_cradle = {
                name = 'Jimbo\'s Cradle',
                text = {
                    "Swings between retriggering",
                    "leftmost and rightmost Joker",
                    "after each retrigger given if",
                    "you have exactly {C:attention}5{} jokers",
                    "{C:inactive}(Next: #1#)"
                }
            },
            j_womsobsc_lily = {
                name= "The World Gone Beautiful",
                text = {
                    "{X:mult,C:white}x#1#{} Mult and {X:chips,C:white}x#2#{} Chips,",
                    "Mult becomes {C:attention}negative{}",
                    "at the end of scoring",
                    "after defeating the boss blind",
                    "{C:inactive}(Currently {C:attention}#3#{}{C:inactive})"
                }
            },
            j_womsobsc_lilico = {
                name= "Lilico",
                text = {
                    "Creates a {C:attention}negative tag{}",
                    "after {C:attention}#2# shop rerolls",
                    "{C:inactive}(Currently {C:attention}#1#/#2#{}{C:inactive})"
                }
            },
            j_womsobsc_swords = {
                name= "Swords",
                text = {
                    "This Joker gains {X:mult,C:white}x#2#{} Mult for",
                    "each {C:spades}Spades{} card held in hand",
                    "or in played hand, Resets",
                    "at the end of the round",
                    "{C:inactive}(Currently {X:mult,C:white}x#1#{C:inactive} Mult)"
                }
            },
            j_womsobsc_limbo = {
                name= "Limbo",
                text = {
                    "Each Joker gives",
                    "{C:chips}+#1#{} Chips"
                }
            },
            j_womsobsc_ends = {
                name = 'Ends',
                text = {
                    "Each base edition {C:clubs}Club{} card held",
                    "in hand gains a random edition,",
                    "{C:green}#1# in #2#{} chance to destroy each",
                    "scoring {C:clubs}Club{} card with an edition"
                }
            },
            j_womsobsc_last_man = {
                name = 'Last Man Standing',
                text = {
                    "{C:green}#1# in #2#{} chance to",
                    "destroy each scored",
                    "{C:hearts}Heart{} and store its Chips",
                    "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chips)"
                }
            },
            j_womsobsc_every = {
                name = 'Every Emotion',
                text = {
                    "{C:chips}+#1#{} Chips if played hand",
                    "contains only diamonds,",
                    "gains {C:chips}#2#{} Chips for each",
                    "scoring enhanced card"
                }
            },
        }
    },
    misc = {
        -- thanks cryptid https://github.com/SpectralPack/Cryptid/blob/bb7b75ff399e3420efcef8aa1305458c275ecb55/localization/en-us.lua#L5126
        dictionary = {
            womsobsc_dorphis = 'Heck Yeah!',
            womsobsc_drat = 'Drat!',
            womsobsc_couscous = 'Couscous Madame!',
            womsobsc_baby_b = 'It\'s A Boy!',
            womsobsc_baby_g = 'It\'s A Girl!',
            womsobsc_mall = 'Water Always Comes Out On Top!',
            womsobsc_speen = 'SPEEEEEN!',
            womsobsc_charm = 'So Charming!',
            womsobsc_wow = 'Wow!',
            womsobsc_wife = 'My Wife!',
            womsobsc_wawa = 'Wawa Wuwa!',
            womsobsc_lilico = 'I Wanna Go Out With A Bang!',
            womsobsc_ends = 'Everything Ends!',
            
            womsobsc_config_13 = 'Add 13 Jokers to music pool',
            womsobsc_config_dorphis = 'Enable The Dorphis',
            womsobsc_config_restart = 'All changes require restart',
        
        }
    }
}