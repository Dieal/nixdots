return {
    {
        'ggandor/leap.nvim',
        enable = false,
        dependencies = {
            'tpope/vim-repeat',
        },
        config = function()
            -- Leap
            require('leap').add_default_mappings()
        end
    },

}
