extensions [ csv profiler time table matrix]
globals[
; Count attributes
nb-basic-agents
nb-information-diss-agents
total-initial-IPs
nb-donovian-agents
nb-spokesperson-agents
nb-total-agents
]
turtles-own
[
  ;Info diss agent attribute to store IPs
  IPslist
;Donovian agents attribute
  AdditionalAttribute
;Basic agents attributes
key_value_table
in_key_value
in-keys
NATODonovia
TriadStackID
triad_id
county
country
Municipality
Coordinates
latitude
longitude
Age
Language
Nationality
PoliticalSpectrum
SocioeconomicStatus
EU
InformationDisseminationAgents
Document-ID
Information-Source-ID
agent-ID
;age-group
;geo
gender
agent-type
Related-IP; diss agent specific
temp-ip;
temp-in-ip; basic agent specific
temp-out-ip; basic agent specific
temp-in
agent-trying-to-send
Messages-allowed-per-clock-tick ; Limit to how many messages they can send in a virtual clock tick [value]
IdentitySignature; set of 0 or more Group memberships.
TriadStack;
nb-connections-in
nb-connections-out ;;should have in and out link connections
nb-group-affiliations?
nb-topics-read?
nb-interests?
Inbox
stance
track-list-test
Initial-Endorsement
connections?
in-trust ; represents row of an adjacency matrix. Turtle specific
out-trust
;  received-IP
received-IP-list
sent-IP-list
connected-to-diss-agent?
;;;;IP specific
target-group   ; Ip specific
source    ; Ip specific
Endorsement-of-IP ; Ip specific
Amplification-of-IP ; Ip specific
censure ; Ip specific
IP-id ;IP specific
DocumentID
InformationSourceID
Related-topic-id ;IP specific
Location ;IP specific
Ref_id_to_Info_Atrifact;;A reference ID to the original source information artifact.
Triad;;A Triad
group-prestige ;; group specific
group-id
topic-id ; Topic specific
;track specific
initial-stance
initial-received-IPs
initial-sent-IPs
controlling_identity
Key_issue
]

;;Reset the entire world
to clear-agents
clear-all
clear-all-plots
clear-globals
end

;;Method to setup the environment by creating agents and connections

to setup-agents

;;This calls the below methods and create respective agents.
create-nb-basic-agents
create-nb-spokesperson-agents
create-nb-information-diss-agents
;create-nb-donovian-agents

;assign-color
;clear-count
;create_adjacency_matrix
;if In-links?
;[make-network-in]
;if out-links?
;[make-network-out]
;write-initial-setup
;reset-ticks
end

to create-nb-basic-agents
file-close-all ; close all open files
if not file-exists? "../Input-files/basicAgentsInput.csv" [
user-message "No file '../Input-files/basicAgentsInput.csv' exists."
stop
]
file-open "../Input-files/basicAgentsInput.csv" ; open the file with the turtle data
let data csv:from-row file-read-line
; We'll read all the data in a single loop
set nb-basic-agents 0
while [ not file-at-end? ] [
set nb-basic-agents nb-basic-agents + 1
; here the CSV extension grabs a single line and puts the read data in a list
set data csv:from-row file-read-line
; now we can use that list to create a turtle with the saved properties
create-turtles 1 [
set shape "circle"
set size  0.3
set color blue
set agent-ID item 0 data
let xcor1 random-xcor
let ycor1 random-ycor
set xcor xcor1
set ycor ycor1
set agent-type item 1 data
set country item 2 data
set county item 3 data
;set latitude item 4 data
set Municipality item 4 data
set Coordinates item 5 data
set Gender item 6 data
set Age item 7 data
set Language item 8 data
set Nationality item 9 data
set PoliticalSpectrum item 10 data
set SocioeconomicStatus item 11 data
set EU item 12 data
set NATODonovia item 13 data
set InformationDisseminationAgents item 14 data
set TriadStackID word "TS-" item 0 data
]
]
print nb-basic-agents
set nb-total-agents nb-basic-agents
file-close
end


to create-nb-spokesperson-agents
 file-close-all ; close all open files
if not file-exists? "../Input-files/spokespersonAgentsInput.csv" [
user-message "No file '../Input-files/spokesperson-agents-input.csv' exists."
stop
]
file-open "../Input-files/spokespersonAgentsInput.csv" ; open the file with the turtle data
let data csv:from-row file-read-line
; We'll read all the data in a single loop
set nb-spokesperson-agents 0
while [ not file-at-end? ] [
set nb-spokesperson-agents nb-spokesperson-agents + 1
; here the CSV extension grabs a single line and puts the read data in a list
set data csv:from-row file-read-line
; now we can use that list to create a turtle with the saved properties
create-turtles 1 [
  set size  1
  set agent-ID item 0 data
  let xcor1 random-xcor
  let ycor1 random-ycor
    if xcor1 <= 11 and xcor1 >= -11
    [set xcor xcor1]
    if ycor1 <= 11 and ycor1 >= -11
    [set ycor ycor1]
  set agent-type item 1 data
 set country item 2 data
 set county item 3 data
 ;set latitude item 4 data
 set Municipality item 4 data
 set Coordinates item 5 data
 set Gender item 6 data
 set Age item 7 data
 set Language item 8 data
 set Nationality item 9 data
 set PoliticalSpectrum item 10 data
 set SocioeconomicStatus item 11 data
 set EU item 12 data
 set NATODonovia item 13 data
 set InformationDisseminationAgents item 14 data
 set shape "circle"
 set size  0.3
 set color violet
]
]
print nb-spokesperson-agents
set nb-total-agents nb-spokesperson-agents + nb-total-agents
file-close ;
end


to create-nb-information-diss-agents
file-close-all ; close all open files
if not file-exists? "../Input-files/InfoDissAgents.csv" [
user-message "No file '../Input-files/InfoDissAgents.csv' exists."
stop
]
file-open "../Input-files/InfoDissAgents.csv" ; open the file with the turtle data
let data csv:from-row file-read-line
; We'll read all the data in a single loop
set nb-information-diss-agents 0
while [ not file-at-end? ] [
set nb-information-diss-agents nb-information-diss-agents + 1
; here the CSV extension grabs a single line and puts the read data in a list
set data csv:from-row file-read-line
; now we can use that list to create a turtle with the saved properties
create-turtles 1 [
  set size  1
  set color yellow
  set agent-ID item 0 data
  let xcor1 random-xcor
  let ycor1 random-ycor
    if xcor1 <= 11 and xcor1 >= -11
    [set xcor xcor1]
    if ycor1 <= 11 and ycor1 >= -11
    [set ycor ycor1]
  set agent-type item 1 data
  set Coordinates "0 0"
  set shape "circle"
  set size  0.3
  set IPslist []
]
]
print nb-information-diss-agents
set nb-total-agents nb-information-diss-agents + nb-total-agents
print nb-total-agents
file-close ;
end



to setup-IP
file-close-all ; close all open files
if not file-exists? "../Input-files/IPsInput.csv" [
user-message "No file '../Input-files/IPsInput.csv' exists."
stop
]
file-open "../Input-files/IPsInput.csv" ; open the file with the turtle data
; We'll read all the data in a single loop
  ; We will read first line which is attribute names, but will not perform any action.
  let data csv:from-row file-read-line
while [not file-at-end?] [
; here the CSV extension grabs a single line and puts the read data in a list
set data csv:from-row file-read-line
; now we can use that list to create a turtle with the saved properties
create-turtles 1 [
  set color orange
  set size  0.4
    set xcor -12
    let ycor1 random-xcor
    if ycor1 <= 11 and ycor1 >= -11
    [set ycor ycor1]
  set agent-type item 0 data
  set DocumentID item 1 data
  set InformationSourceID item 2 data
  set Related-topic-id item 3 data
  set IP-id item 4 data
  set stance item 4 data
  set shape "square"
  ;Logic for updating the Info dissimination agents IPslist attribute with related IPs
  ;Creating a temp variable to store info agent id
  let IPsInformationSourceID InformationSourceID
  let IPsIP-id IP-id
   foreach sort turtles [ t ->
    ask t [if agent-type = "information-diss-agents" and agent-ID = IPsInformationSourceID[
    set IPslist lput IPsIP-id IPslist
    ]
   ]
  ]
]
]
  ;Code to test
foreach sort turtles [ t ->
    ask t [if agent-type = "information-diss-agents" and IPslist != [][
    print agent-ID
    print IPslist
    ]
   ]
  ]
end


to create_adjacency_matrix
  file-close-all ; close all open files

if not file-exists? "adjacency_matrix.csv" [
  user-message "No file 'adjacency_matrix.csv' exists."
  stop
]
  file-open "adjacency_matrix.csv"

  let i 0
  let row-list []
  while [i < nb-basic-agents + 1] [
    let data csv:from-row file-read-line
    ;print data
    let column-list []
    let j 0
    ; k is the column at which spokesperson agents start
    let Start_column_of_spokesperson 2002

    while [j < nb-basic-agents + 1] [

      set column-list lput item j data column-list
      set j j + 1


    ]
    while[Start_column_of_spokesperson < nb-spokesperson-agents + 2002]
      [
        set column-list lput item Start_column_of_spokesperson data column-list
        set Start_column_of_spokesperson Start_column_of_spokesperson + 1
      ]

    set row-list lput column-list row-list
    ;print column-list
    set i i + 1
  ]
  ;2002 is the Row at which spokesperson start
  if 2002 - (nb-basic-agents + 1) > 0[
  let countdif 2002 - (nb-basic-agents + 1)
    ;print countdif
    repeat countdif[
      let data csv:from-row file-read-line

    ]
  ]
  ;Row at which spokesperson start
  let i1 0
  while [i1 < nb-spokesperson-agents ] [
    let data csv:from-row file-read-line
    ;print data
    let column-list []
    let j1 0
    ; Start_column_of_spokesperson is the column at which spokesperson agents start
    let Start_column_of_spokesperson 2002

    while [j1 < nb-basic-agents + 1] [

      set column-list lput item j1 data column-list
      set j1 j1 + 1


    ]
    while[Start_column_of_spokesperson < nb-spokesperson-agents + 2002]
      [
        set column-list lput item Start_column_of_spokesperson data column-list
        set Start_column_of_spokesperson Start_column_of_spokesperson + 1
      ]

    set row-list lput column-list row-list
    ;print column-list
    set i1 i1 + 1
  ]

  ;2045 is the Row at which info diss start
  if 2045 - (2001 + nb-spokesperson-agents + 1) > 0[
  let countdif1 2045 - (2001 + nb-spokesperson-agents + 1)
    ;print countdif1
    repeat countdif1 [
      let data csv:from-row file-read-line
     ; print data

    ]
  ]

  ;Row at which info diss start
  let i2 0
  while [i2 < nb-information-diss-agents ] [
    let data csv:from-row file-read-line
   ; print data
    let column-list []
    let j2 0
    ; Start_column_of_spokesperson is the column at which spokesperson agents start
    let Start_column_of_spokesperson 2002

    while [j2 < nb-basic-agents + 1] [

      set column-list lput item j2 data column-list
      set j2 j2 + 1


    ]
    while[Start_column_of_spokesperson < nb-spokesperson-agents + 2002]
      [
        set column-list lput item Start_column_of_spokesperson data column-list
        set Start_column_of_spokesperson Start_column_of_spokesperson + 1
      ]

    set row-list lput column-list row-list
    ;print column-list
    set i2 i2 + 1
  ]




   csv:to-file "Adjacency_matrix_created.csv" row-list

end


to make-network-in

file-close-all ; close all open files

if not file-exists? "Adjacency_matrix_created.csv" [
  user-message "No file 'Example_in_adjacency_matrix.csv' exists."
  stop
]
  let keys_list []
  ;let in_trust_list []
  let key_value_list []

file-open "Adjacency_matrix_created.csv" ; open the file with the links data

; We'll read all the data in a single loop
let i 0 ; initializing the row number of the adjacency matrix
let count-agents nb-basic-agents + nb-spokesperson-agents + nb-information-diss-agents
  ;print count-agents
let data1 csv:from-row file-read-line

set keys_list data1
set keys_list remove-item 0 keys_list

;print data1
while [ i < count-agents ] [
    set key_value_list []
    set key_value_list lput keys_list key_value_list
    ask turtle i [set in-trust []]
    let in_trust_list []

  ; here the CSV extension grabs a single line and puts the read data in a list
  let data csv:from-row file-read-line
  ;print data
  ; now we can use that list to create a turtle with the saved properties
  let j 1 ; cloumn number of the adjacency matrix
  let k 0
  let l 1


  repeat count-agents - nb-information-diss-agents [ ; repeating hundred times for each row i bcz we have hundred columns

    let value item j data
    ;let key item l data1


      ;; Code to convert string to list
    let temp-string value
    let list-of-numbers (list)

while [position " " temp-string != FALSE] [
 let next-number-as-string  (substring temp-string 0 position " " temp-string)
 set list-of-numbers lput (read-from-string next-number-as-string) (list-of-numbers)

 repeat (position " " temp-string + 1) [
   set temp-string (but-first temp-string)
 ]
]

set list-of-numbers lput (read-from-string temp-string) (list-of-numbers)





      ;print item 0 list-of-numbers

      set value item 0 list-of-numbers

      ;print value
      ask turtle i [
        set in-trust lput value in-trust
        ;set in_trust_list lput value in_trust_list
        ;set in-keys data1
        ;print in-keys
        ;print in-trust
      ]
    if value != 0[
      ask turtle i [
;          set out-trust? lput value out-trust?
         if agent-type  = "information-diss-agents"  and temp-in-ip != 0 [
        ifelse member? temp-in-ip received-IP-list [
        ][set received-IP-list lput temp-in-ip received-IP-list]
        ]
;         if In-links?
;          [ let another_turtle j - 1
;            create-link-with turtle another_turtle]
         ; ask links [set color red + 2]
           ; This draws a line between the agents it's just for representation

        set k k + 1
        set nb-connections-in k
      ]
    ]
;   if value = 0[ask turtle i [set out-trust? lput value out-trust?]]
    set j j + 1
    set l l + 1
  ]

	;set key_value_list lput in_trust_list key_value_list
    ask turtle i [set in_key_value []
      set in_key_value lput keys_list in_key_value
      ;print length(keys_list)
      ;print keys_list
      set in_key_value lput in-trust in_key_value
      ;print length(in-trust)
      ;print in-trust
      set key_value_table table:from-list in_key_value

      ;set key_value_list lput in-trust key_value_list
      let temp_length 0
      let temp_in_key_value_list []
      while [temp_length < length(keys_list)]
      [
        let temp_inside_key_val_list []
        set temp_inside_key_val_list lput item temp_length(item 0(in_key_value)) temp_inside_key_val_list
        set temp_inside_key_val_list lput item temp_length(item 1(in_key_value)) temp_inside_key_val_list
        set temp_in_key_value_list lput temp_inside_key_val_list temp_in_key_value_list
        set temp_length temp_length + 1
      ]
     ; csv:to-file "track-key-values.csv" temp_in_key_value_list
      set key_value_table table:from-list temp_in_key_value_list

      ;print m
    ;set key_value_table table:from-list in_key_value
      ;print key_value_table
    ]
	
	
  set i i + 1

]
;   print k
file-close ; make sure to close the file
end





































@#$#@#$#@
GRAPHICS-WINDOW
210
10
543
344
-1
-1
13.0
1
10
1
1
1
0
1
1
1
-12
12
-12
12
0
0
1
ticks
30.0

BUTTON
62
54
168
87
NIL
setup-agents\n
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
84
214
149
247
Reset
clear-agents
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
76
110
156
143
NIL
Setup-IP\n
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

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
NetLogo 6.3.0
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
