extensions [ nw array table ]
turtles-own [ ideas awesomeness ]
globals [arr-dict]

;; load and save a network

to save
  nw:save-matrix filename-to-save
  clear-all
end

to load
  clear-all
  nw:load-matrix filename-to-load turtles links
  layout-circle sort turtles 8
  ask turtle (count turtles - 1) [ setxy 0 0 ]
end

to prettify [ network ]
  file-open filename-to-prettify
  file-write network
  file-close
end


;; setup network

to pre-setup
  clear-all
  reset-ticks
  make-dict
end

to make-dict
  let arr1 [2 67 39]
  let arr2 [4 36]
  let arr3 [3 45 98 22]
  let dict table:make
  table:put dict arr1 .8
  table:put dict arr2 0
  table:put dict arr3 .36
  set arr-dict dict
  show arr-dict
end


to setup
  pre-setup
  nw:generate-random turtles links num-nodes connectivity [ set color node-color ]
  ask turtles [fd 6 set shape "circle" set size .5]
  layout-circle turtles radius
  create-ideas
  color-turtles
end

to preferential-attachment
  pre-setup
  nw:generate-preferential-attachment turtles links num-nodes [ set color node-color ]
  layout-circle turtles radius
  create-ideas
  color-turtles
end

to watts-strogatz
  pre-setup
  nw:generate-watts-strogatz turtles links num-nodes neighborhood-size connectivity [ fd 10 set color node-color ]
  layout-circle turtles radius
  create-ideas
  color-turtles
end

to small-world
  pre-setup
  nw:generate-small-world turtles links num-rows num-cols 2.0 True
  layout-circle turtles radius
  create-ideas
  color-turtles
end

to lattice
  pre-setup
  nw:generate-lattice-2d turtles links world-height world-width false [ set color node-color ]
  (foreach (sort turtles) (sort patches) [
    [t p] -> ask t [ move-to p ] ;; ask turtle to move to the specified patch
  ])
  create-ideas
  color-turtles
end

to ring
  pre-setup
  prettify "ring"
  nw:generate-ring turtles links num-nodes [ set color node-color ]
  layout-circle sort turtles radius
  create-ideas
  color-turtles
end

to star
  pre-setup
  prettify "star"
  nw:generate-star turtles links num-nodes [ set color node-color ]
  layout-radial turtles links (turtle 0)
  create-ideas
  color-turtles
end

to wheel
  pre-setup
  prettify "wheel"
  nw:generate-wheel turtles links num-nodes [ set color node-color ]
  layout-circle sort turtles 8
  ask turtle (count turtles - 1) [ setxy 0 0 ]
  create-ideas
  color-turtles
end


;; create ideas for each turtle

to create-ideas
  (foreach (sort turtles) [
    [t] -> ask t [ set ideas array:from-list n-values 8 [random 100] ]
  ])
  make-good-idea-set
end


;; recolor the turtles based on idea strength

to color-turtles
  ask turtles [
    set shape "circle" set size .5
    let result 0
    (foreach (array:to-list ideas) [
      [val] -> set result result + val
    ])
    set awesomeness result / 8
    set color scale-color node-color awesomeness 0 100
  ]
end


;; run the model

to go
  if ticks >= 50 [stop] ; spec says 50 iterations
  ask turtles [
    exchange-ideas
  ]
  tick
end

;; each turtle picks another turtle to exchange ideas with

to exchange-ideas
  output-show "comparing ideas"
  let to_compare 0
  let neighbor one-of nw:turtles-in-radius 1
  ask neighbor [
     set to_compare ideas
  ]

  let i 0
  while [ i < num-bits-to-share ] [
    ;show array:item ideas i
    ;show array:item to_compare i
    set i i + 1
  ]
  show ideas
  show to_compare
end





;; hardcoded good idea set

to make-good-idea-set
  let goodideas table:make

  ;;for all permutations of 3
  table:put goodideas [1 2 3] random 100;
  table:put goodideas [1 2 4] random 100;
  table:put goodideas [1 2 5] random 100;
  table:put goodideas [1 2 6] random 100;
  table:put goodideas [1 2 7] random 100;
  table:put goodideas [1 2 8] random 100;
  table:put goodideas [1 2 9] random 100;
  table:put goodideas [1 2 10] random 100;

  table:put goodideas [1 3 4] random 100;
  table:put goodideas [1 3 5] random 100;
  table:put goodideas [1 3 6] random 100;
  table:put goodideas [1 3 7] random 100;
  table:put goodideas [1 3 8] random 100;
  table:put goodideas [1 3 9] random 100;
  table:put goodideas [1 3 10] random 100;

  table:put goodideas [1 4 5] random 100;
  table:put goodideas [1 4 6] random 100;
  table:put goodideas [1 4 7] random 100;
  table:put goodideas [1 4 8] random 100;
  table:put goodideas [1 4 9] random 100;
  table:put goodideas [1 4 10] random 100;

  table:put goodideas [1 5 6] random 100;
  table:put goodideas [1 5 7] random 100;
  table:put goodideas [1 5 8] random 100;
  table:put goodideas [1 5 9] random 100;
  table:put goodideas [1 5 10] random 100;

  table:put goodideas [1 6 7] random 100;
  table:put goodideas [1 6 8] random 100;
  table:put goodideas [1 6 9] random 100;
  table:put goodideas [1 6 10] random 100;

  table:put goodideas [1 7 8] random 100;
  table:put goodideas [1 7 9] random 100;
  table:put goodideas [1 7 10] random 100;

  table:put goodideas [1 8 9] random 100;
  table:put goodideas [1 8 10] random 100;

  table:put goodideas [1 9 10] random 100;


  table:put goodideas [2 3 4] random 100;
  table:put goodideas [2 3 5] random 100;
  table:put goodideas [2 3 6] random 100;
  table:put goodideas [2 3 7] random 100;
  table:put goodideas [2 3 8] random 100;
  table:put goodideas [2 3 9] random 100;
  table:put goodideas [2 3 10] random 100;

  table:put goodideas [2 4 5] random 100;
  table:put goodideas [2 4 6] random 100;
  table:put goodideas [2 4 7] random 100;
  table:put goodideas [2 4 8] random 100;
  table:put goodideas [2 4 9] random 100;
  table:put goodideas [2 4 10] random 100;

  table:put goodideas [2 5 6] random 100;
  table:put goodideas [2 5 7] random 100;
  table:put goodideas [2 5 8] random 100;
  table:put goodideas [2 5 9] random 100;
  table:put goodideas [2 5 10] random 100;

  table:put goodideas [2 6 7] random 100;
  table:put goodideas [2 6 8] random 100;
  table:put goodideas [2 6 9] random 100;
  table:put goodideas [2 6 10] random 100;

  table:put goodideas [2 7 8] random 100;
  table:put goodideas [2 7 9] random 100;
  table:put goodideas [2 7 10] random 100;

  table:put goodideas [2 8 9] random 100;
  table:put goodideas [2 8 10] random 100;

  table:put goodideas [2 9 10] random 100;

  table:put goodideas [3 4 5] random 100;
  table:put goodideas [3 4 6] random 100;
  table:put goodideas [3 4 7] random 100;
  table:put goodideas [3 4 8] random 100;
  table:put goodideas [3 4 9] random 100;
  table:put goodideas [3 4 10] random 100;

  table:put goodideas [3 5 6] random 100;
  table:put goodideas [3 5 7] random 100;
  table:put goodideas [3 5 8] random 100;
  table:put goodideas [3 5 9] random 100;
  table:put goodideas [3 5 10] random 100;

  table:put goodideas [3 6 7] random 100;
  table:put goodideas [3 6 8] random 100;
  table:put goodideas [3 6 9] random 100;
  table:put goodideas [3 6 10] random 100;

  table:put goodideas [3 7 8] random 100;
  table:put goodideas [3 7 9] random 100;
  table:put goodideas [3 7 10] random 100;

  table:put goodideas [3 8 9] random 100;
  table:put goodideas [3 8 10] random 100;

  table:put goodideas [3 9 10] random 100;

  table:put goodideas [4 5 6] random 100;
  table:put goodideas [4 5 7] random 100;
  table:put goodideas [4 5 8] random 100;
  table:put goodideas [4 5 9] random 100;
  table:put goodideas [4 5 10] random 100;

  table:put goodideas [4 6 7] random 100;
  table:put goodideas [4 6 8] random 100;
  table:put goodideas [4 6 9] random 100;
  table:put goodideas [4 6 10] random 100;

  table:put goodideas [4 7 8] random 100;
  table:put goodideas [4 7 9] random 100;
  table:put goodideas [4 7 10] random 100;

  table:put goodideas [4 8 9] random 100;
  table:put goodideas [4 8 10] random 100;

  table:put goodideas [4 9 10] random 100;

  table:put goodideas [5 6 7] random 100;
  table:put goodideas [5 6 8] random 100;
  table:put goodideas [5 6 9] random 100;
  table:put goodideas [5 6 10] random 100;

  table:put goodideas [5 7 8] random 100;
  table:put goodideas [5 7 9] random 100;
  table:put goodideas [5 7 10] random 100;

  table:put goodideas [5 8 9] random 100;
  table:put goodideas [5 8 10] random 100;

  table:put goodideas [5 9 10] random 100;

  table:put goodideas [6 7 8] random 100;
  table:put goodideas [6 7 9] random 100;
  table:put goodideas [6 7 10] random 100;

  table:put goodideas [6 8 9] random 100;
  table:put goodideas [6 8 10] random 100;

  table:put goodideas [6 9 10] random 100;

  table:put goodideas [7 8 9] random 100;
  table:put goodideas [7 8 10] random 100;

  table:put goodideas [7 9 10] random 100;

  table:put goodideas [8 9 10] random 100;

  ;;print goodideas
end





@#$#@#$#@
GRAPHICS-WINDOW
216
10
653
448
-1
-1
13.0
1
10
1
1
1
0
0
0
1
-16
16
-16
16
0
0
1
ticks
30.0

BUTTON
12
42
100
75
random
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
37
167
187
200
preferential attachment
preferential-attachment
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
37
208
187
241
watts-strogatz
watts-strogatz
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
12
82
100
115
small world
small-world
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
701
192
873
225
num-nodes
num-nodes
1
100
10.0
1
1
NIL
HORIZONTAL

SLIDER
701
232
873
265
connectivity
connectivity
0
1
0.5
.1
1
NIL
HORIZONTAL

SLIDER
703
152
875
185
radius
radius
1
15
10.0
1
1
NIL
HORIZONTAL

SLIDER
700
312
872
345
num-rows
num-rows
2
10
2.0
1
1
NIL
HORIZONTAL

SLIDER
701
349
873
382
num-cols
num-cols
2
10
2.0
1
1
NIL
HORIZONTAL

INPUTBOX
703
81
858
141
node-color
65.0
1
0
Color

BUTTON
108
83
197
116
star
star
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
108
122
197
155
wheel
wheel
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
701
270
873
303
neighborhood-size
neighborhood-size
0
10
0.0
1
1
NIL
HORIZONTAL

TEXTBOX
884
155
1034
173
Applies to all
11
0.0
1

TEXTBOX
885
199
1035
241
Applies to all except small world. Minimum of 5 works for all.
11
0.0
1

TEXTBOX
885
237
1035
265
Applies to random, watts-strogatz
11
0.0
1

TEXTBOX
887
275
1037
317
Applies to watts-strogatz\nMUST BE LESS THAN 1/2 of NUM-NODES
11
0.0
1

TEXTBOX
883
354
1033
372
small-world creates a matrix
11
0.0
1

BUTTON
12
122
100
155
ring
ring
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
108
43
197
76
lattice
lattice
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

INPUTBOX
702
13
803
73
filename-to-save
network.txt
1
0
String

INPUTBOX
809
13
913
73
filename-to-load
network.txt
1
0
String

BUTTON
11
294
95
327
load network
load
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
106
295
189
328
save network
save
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

INPUTBOX
919
13
1035
73
filename-to-prettify
pretty.txt
1
0
String

BUTTON
71
366
134
399
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

TEXTBOX
88
14
119
32
setup
11
0.0
1

TEXTBOX
75
271
138
289
load/save
11
0.0
1

TEXTBOX
91
344
116
362
run
11
0.0
1

SLIDER
701
392
873
425
num-bits-to-share
num-bits-to-share
0
8
8.0
1
1
NIL
HORIZONTAL

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.0.2
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
