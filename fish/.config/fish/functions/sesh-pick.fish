function sesh-pick
    sesh connect $(sesh list | fzf)
end
