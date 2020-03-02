function fuzzyeq(te, n, b, c)
    
    if c == nil then c = b end
    return te >= n-b and te <= n+c
    
end