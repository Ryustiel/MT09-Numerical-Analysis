
M = [24, 0, 0, 0; 24, 6, 0, 0; 12, 6, 2, 0; 4, 3, 2, 1;]
b = [24; 18; 8; 2]

// M = [1, 0, 0; 2, 1, 0; 3, 4, 1]
// b = [1; 2; 3]

// transformer en parametre de ...inf
tolerance = 1.d-16

solinf(M, b)

// test de la question 2

M = [3, 1, 2; 3, 2, 6; 6, 1, -1]
b = [2; 1; 4]

trisup(M, b)

// tests de la question 3

M = [1, 2, 3; 5, 2, 1; 3, -1, 1]
b = [2; 1; 4]

resolG(M, b)
M \ b

M = [2, 1, 5; 1, 2, 4; 3, 4, 10]
b = [5; 5; 6]

// inv(M)
// resolG(M, b)
// M \ b

// tests de la question 8

M = [1, 2, 3; 5, 2, 1; 3, -1, 1]

inverse(M)









