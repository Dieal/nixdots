local function get_date_time()
    return { os.date('%Y-%m-%d %H:%M') }
end

return {
    s(
        'scheduled', -- trigger
        {
            t('[scheduled]: <'),
            t(get_date_time()), -- Calls the function to insert the time
            t('> '),
            i(0), -- Puts your cursor here
        }
    ),
}
