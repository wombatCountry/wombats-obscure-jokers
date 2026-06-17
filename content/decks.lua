SMODS.Back {
    key = 'meme_deck',
    atlas = 'decks',
    pos = {x = 0, y = 0},
    config = {
        discovered  = true
    },
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function() 
                SMODS.add_card{area = G.jokers, set = "Joker", key = get_meme_joker(), force_stickers = {"perishable"}}
                return true 
            end
        }))
    end,
    calculate = function(self, back, context)
        --https://github.com/nh6574/VanillaRemade/blob/2182f7c4370fc77ca7593fb640e8730f13ba1068/src/jokers.lua#L1813
        if context.end_of_round and context.beat_boss and not context.game_over and context.main_eval and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function() 
                    SMODS.add_card{area = G.jokers, set = "Joker", key = get_meme_joker(), force_stickers = {"perishable"}}
                    G.GAME.joker_buffer = 0
                    return true 
                end
            }))
        end
    end
}

SMODS.Back {
    key = 'music_deck',
    atlas = 'decks',
    pos = {x = 1, y = 0},
    config = {
        discovered  = true,
        dollars = 3,
        gone_off = false
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {self.config.dollars}}
    end,
    calculate = function(self, back, context)
        if context.create_shop_card and not back.effect.config.gone_off then
            back.effect.config.gone_off = true
            local music_joker = {
                set = 'Joker',
                key = get_music_joker(),
                area = G.shop_jokers
            }
            return {
                shop_create_flags = music_joker
            }
        end

        if context.ending_shop then
            back.effect.config.gone_off = false
        end
    end
}