extensions [ csv profiler time table matrix rnd]
breed [basic-agents basic-agent]
breed [information-diss-agents information-diss-agent]
breed [donovian-agents donovian-agent]
breed [spokesperson-agents spokesperson-agent]
breed [physical-event-agents physical-event-agent]
breed [live-agents live-agent]
breed [flow-manipulator-agents flow-manipulator-agent]
breed [IPs IP]

globals[
  tick-count
  simulation_id

  ; Count Attributes
  total-initial-IPs
  nb-basic-agents
  nb-donovian-agents
  nb-spokesperson-agents
  nb-information-diss-agents
  nb-physical-event-agents
  nb-live-agents
  nb-flow-manipulator-agents
  nb-total-agents

  actionid
  identityactionid
  relationship_action_id
  tempstance

  initial_track_list_IA
  Information_Action_list
  sub_list_IA

  initial_track_list_RA
  Relationship_Action_list
  sub_list_RA

  information_action_type
  change_in_amplification
;  IncreaseMagnitudeofTopicStance
;  DecreaseMagnitudeofTopicStance

  identity-list
  initial-track-list10
  sub-list10

  Flag_IP_File
]

basic-agents-own
[  ;;; Agent Attributes
  agent-ID
  agent-type
  county
  country
  municipality
  latitude
  longitude
  gender
  Age
  Language
  Nationality
  PoliticalSpectrum
  SocioeconomicStatus
  EU
  NATODonovia
  soldier_type ; Additional Attribute for All Agents to Match Donovians
  Inbox
  Outbox
  ;;; Attributes that Store All the Connected Agents for an Agent
  connected_agents_list
  trust_values_list
  Id_trust_table ; this is a combination of connected_agents_list and trust_values_list
  TriadStackID
  TriadStack
  triadtopics
]

spokesperson-agents-own
[  ;;; Agent Attributes
  agent-ID
  agent-type
  county
  country
  municipality
  latitude
  longitude
  gender
  Age
  Language
  Nationality
  PoliticalSpectrum
  SocioeconomicStatus
  EU
  NATODonovia
  soldier_type ; Additional Attribute for All Agents to Match Donovians
  Inbox
  Outbox
  ;;; Attributes that Store All the Connected Agents for an Agent
  connected_agents_list
  trust_values_list
  Id_trust_table ; this is a combination of connected_agents_list and trust_values_list
  TriadStackID
  TriadStack
  triadtopics
]

information-diss-agents-own
[
  ;;; Information Dissemination Agent Attributes
  source-type ; TV, newspaper, leaflet, etc.
  agent-ID
  agent-type
  latitude
  longitude
  ;;; Attributes that Store All the Connected Agents for an Agent
  connected_agents_list
  trust_values_list
  Id_trust_table ; this is a combination of connected_agents_list and trust_values_list
  IPslist
]

IPs-own[
  ;;; Information Packet Attributes
  agent-type ; e.g., IPs
  DocumentID
  InformationSourceID
  topic-id
  IP-id
  stance
]

;;Reset the entire world
to clear-agents
  clear-all
  clear-all-plots
  clear-globals
end

to export
  export-world "world.csv"
end

to import
  import-world "world.csv"
end

;;; Method to setup the environment by creating agents and connections
;;;
to setup-agents
  set simulation_id user-input "Enter the simulation ID: "
  set simulation_id word "Sim" simulation_id

  create-nb-basic-agents
  create-nb-spokesperson-agents
;  create-nb-donovian-agents
;  create-nb-flow-manipulator-agents
;  create-nb-live-agents
  create-nb-information-diss-agents
  set tick-count 0

  ;create_adjacency_matrix
  ;if In-links?
  ;[make-network-in]
  ;if out-links?
  ;[make-network-out]
  ;write-initial-setup
  ;reset-ticks
end

;;; Procedure to Create Basic Agents from an Agent Factory File of Population Demographics
;;;
to create-nb-basic-agents
  file-close-all ; close all open files
  ifelse not file-exists? "../Input-files/basicAgentsInput.csv" [
    user-message "No file '../Input-files/basicAgentsInput.csv' exists. Skipping to next agent type."
  ][
    file-open "../Input-files/basicAgentsInput.csv" ; open the file with the turtle data
    let data (csv:from-row file-read-line "~")
    ; We'll read all the data in a single loop
    set nb-basic-agents 0
    while [ not file-at-end? ] [
      set nb-basic-agents nb-basic-agents + 1
      ; here the CSV extension grabs a single line and puts the read data in a list
      set data (csv:from-row file-read-line "~")
      ; now we can use that list to create a turtle with the saved properties
      create-basic-agents 1 [
        set shape "circle"
        set size  0.3
        set color blue
        set xcor random-xcor
        set ycor random-ycor
        set agent-ID item 0 data
        set agent-type item 1 data
        set country item 2 data
        set county item 3 data
        set municipality item 4 data
        set latitude item 5 data
        set longitude item 6 data
        set gender item 7 data
        set Age item 8 data
        set Language item 9 data
        set Nationality item 10 data
        set PoliticalSpectrum item 11 data
        set SocioeconomicStatus item 12 data
        set EU item 13 data
        set NATODonovia item 14 data
        set soldier_type item 15 data

        set TriadStackID word "TS-" item 0 data
        set connected_agents_list []
        set trust_values_list []
        set Inbox []
        set Outbox []
        set triadstack []
        set triadtopics []
      ]
    ] ; end reading each line of the file
    type "Number of basic agents = "
    print nb-basic-agents
    set nb-total-agents nb-basic-agents
  ]
  file-close
end ; end of procedure to create basic agents


;;; Procedure to Create Spokesperson Agents from an Agent Factory File
;;;
to create-nb-spokesperson-agents
  file-close-all ; close all open files
  ifelse not file-exists? "../Input-files/spokespersonAgentsInput.csv" [
    user-message "No file '../Input-files/spokesperson-agents-input.csv' exists. Skipping to next agent type."
  ][
    file-open "../Input-files/spokespersonAgentsInput.csv" ; open the file with the turtle data
    let data (csv:from-row file-read-line "~")
    ; We'll read all the data in a single loop
    set nb-spokesperson-agents 0
    while [ not file-at-end? ] [
      set nb-spokesperson-agents nb-spokesperson-agents + 1
      ; here the CSV extension grabs a single line and puts the read data in a list
      set data (csv:from-row file-read-line "~")
      ; now we can use that list to create a turtle with the saved properties
      create-spokesperson-agents 1 [
        set shape "circle"
        set size  0.3
        set color green
        set xcor random-xcor
        set ycor random-ycor
        set agent-ID item 0 data
        set agent-type item 1 data
        set country item 2 data
        set county item 3 data
        set municipality item 4 data
        set latitude item 5 data
        set longitude item 6 data
        set gender item 7 data
        set Age item 8 data
        set Language item 9 data
        set Nationality item 10 data
        set PoliticalSpectrum item 11 data
        set SocioeconomicStatus item 12 data
        set EU item 13 data
        set NATODonovia item 14 data
        set soldier_type item 15 data

        set TriadStackID word "TS-" item 0 data
        set connected_agents_list []
        set trust_values_list []
        set Inbox []
        set Outbox []
        set triadstack []
        set triadtopics []
      ]
    ]
    type "Number of spokesperson agents = "
    print nb-spokesperson-agents
    set nb-total-agents nb-spokesperson-agents + nb-total-agents
  ]
  file-close ;
end ; create-spokespersons


;;; Procedure to Create Donovian Agents from an Agent Factory File
;;;
to create-nb-donovian-agents
  file-close-all ; close all open files
  ifelse not file-exists? "../Input-files/donovianAgentsInput.csv" [
    user-message "No file '../Input-files/donovianAgentsInput.csv' exists. Skipping to next agent type."
  ][
    file-open "../Input-files/donovianAgentsInput.csv" ; open the file with the turtle data
    let data (csv:from-row file-read-line "~")
    ; We'll read all the data in a single loop
    set nb-donovian-agents 0
    while [ not file-at-end? ] [
      set nb-donovian-agents nb-donovian-agents + 1
      ; here the CSV extension reads a single line and puts the read data in a list
      set data (csv:from-row file-read-line "~")
      ; now we use that list to create a turtle with the saved properties
      create-donovian-agents 1 [
        set shape "face sad"
        set size  0.3
        set color red
        set xcor random-xcor
        set ycor random-ycor
        set agent-ID item 0 data
        set agent-type item 1 data
        set country item 2 data
        set county item 3 data
        set municipality item 4 data
        set latitude item 5 data
        set longitude item 6 data
        set gender item 7 data
        set Age item 8 data
        set Language item 9 data
        set Nationality item 10 data
        set PoliticalSpectrum item 11 data
        set SocioeconomicStatus item 12 data
        set EU item 13 data
        set NATODonovia item 14 data
        set soldier_type item 15 data

        set TriadStackID word "TS-" item 0 data
        set connected_agents_list []
        set trust_values_list []
        set Inbox []
        set Outbox []
        set triadstack []
        set triadtopics []
      ]
    ]
    type "Number of donovian agents = "
    print nb-donovian-agents
    set nb-total-agents nb-donovian-agents + nb-total-agents
  ]
  file-close ;
end ; create-donovians


;;; Procedure to Create Information Dissemination Agents from an Agent Factory File
;;;
to create-nb-information-diss-agents
  file-close-all ; close all open files
  ifelse not file-exists? "../Input-files/InfoDissAgents.csv" [
    user-message "No file '../Input-files/InfoDissAgents.csv' exists. Skipping Information Dissemination Agents."
  ][
    file-open "../Input-files/InfoDissAgents.csv" ; open the file with the turtle data
    let data (csv:from-row file-read-line "~")
    ; We'll read all the data in a single loop
    set nb-information-diss-agents 0
    while [ not file-at-end? ] [
      set nb-information-diss-agents nb-information-diss-agents + 1
      ; here the CSV extension grabs a single line and puts the read data in a list
      set data (csv:from-row file-read-line "~")
      ; now we can use that list to create a turtle with the saved properties
      create-information-diss-agents 1 [
        set shape "plant"
        set size  0.6
        set color yellow
        set xcor random-xcor
        set ycor random-ycor
        set agent-ID item 0 data
        set agent-type item 1 data
        set source-type item 2 data
        set latitude 54.684
        set longitude 25.289871 ; this assumes all information dissemination agents are in Vilnius
        set IPslist []
        set connected_agents_list []
        set trust_values_list []
      ]
    ]
    type "Number of information-dissemination agents = "
    print nb-information-diss-agents
    set nb-total-agents nb-information-diss-agents + nb-total-agents
    print word "Total number of agents = " nb-total-agents
  ]
  file-close ;
end ; create-info-diss-agents


;;; Procedure to Create Flow Manipulator Agents from an Agent Factory File
;;;
to create-nb-flow-manipulator-agents
  file-close-all ; close all open files
  ifelse not file-exists? "../Input-files/flowManipulatorAgentsInput.csv" [
    user-message "No file '../Input-files/flowManipulatorAgentsInput.csv' exists. Skipping Flow Manipulator Agents."
  ][
    file-open "../Input-files/flowManipulatorAgentsInput.csv" ; open the file with the turtle data
    let data (csv:from-row file-read-line "~")
    ; We'll read all the data in a single loop
    while [ not file-at-end? ] [
      ; here the CSV extension reads a single line and puts the read data in a list
      set data (csv:from-row file-read-line "~")
      ; now we use that list to create a turtle with the saved properties
      create-flow-manipulator-agents 1 [
        set shape "wheel"
        set size  1
        set color white
        set xcor random-xcor
        set ycor random-ycor
        set agent-ID item 0 data
        set agent-type item 1 data
      ]
    ]
    print "Flow Manipulator Agents Created"
  ]
  file-close ;
end ; create-flow-manipulators


;;; Procedure to Create Live Agents from an Agent Factory File
;;;
to create-nb-live-agents
  file-close-all ; close all open files
  ifelse not file-exists? "../Input-files/liveAgentsInput.csv" [
    user-message "No file '../Input-files/liveAgentsInput.csv' exists. Skipping Flow Manipulator Agents."
  ][
    file-open "../Input-files/liveAgentsInput.csv" ; open the file with the turtle data
    let data (csv:from-row file-read-line "~")
    ; We'll read all the data in a single loop
    set nb-live-agents 0
    while [ not file-at-end? ] [
      set nb-live-agents nb-live-agents + 1
      ; here the CSV extension reads a single line and puts the read data in a list
      set data (csv:from-row file-read-line "~")
      ; now we use that list to create a turtle with the saved properties
      create-live-agents 1 [
        set shape "person"
        set size  1
        set color orange
        set xcor random-xcor
        set ycor random-ycor
        set agent-ID item 0 data
        set agent-type item 1 data
      ]
    ]
    type "Number of live agents = "
    print nb-live-agents
    set nb-total-agents nb-live-agents + nb-total-agents
    print word "Total number of agents = " nb-total-agents
  ]
  file-close ;
end

;; Read the Initial Set of Information Packets and Create Turtles for Them
;; Assign the Information Packets to Information Dissemination Agents
;;
to setup-IP
  file-close-all ; close all open files
  if not file-exists? "../Input-files/IPsInput_tick_0.csv" [
    print "No file '../Input-files/IPsInput_tick_0.csv' exists."
    stop
  ]
  file-open "../Input-files/IPsInput_tick_0.csv" ; open the file with the turtle data
  ; Read all the data in a single loop
  ; Read the first line, which consists of attribute names, but don't perform any action
  let data csv:from-row file-read-line
  set total-initial-IPs 0
  while [not file-at-end?] [
    set total-initial-IPs total-initial-IPs + 1
    ; here the CSV extension grabs a single line and puts the read data in a list
    set data csv:from-row file-read-line
    ; now we can use that list to create a turtle with the saved properties
    create-IPs 1 [
      set shape "square"
      set color orange
      set size 0.4
      set xcor -12
      set ycor random-ycor
      set agent-type item 0 data
      set DocumentID item 1 data
      set InformationSourceID item 2 data
      set topic-id item 3 data
      set IP-id item 4 data
      set stance item 5 data
      ; Put the new IP into the IPslist attribute  of the appropriate Info Dissimination agents
      ; Use a temp variable to store info agent id
      let IPsInformationSourceID InformationSourceID
      let IPsIP-id IP-id
      let current_agents information-diss-agents with [agent-ID = IPsInformationSourceID]
      ask current_agents [
        set IPslist lput IPsIP-id IPslist
      ]
    ]
  ]
  print word "Number of baseline information packets = " total-initial-IPs
  ; Code to test
;  foreach sort information-diss-agents [ t ->
;    ask t [
;      ;    print agent-ID
;      ;    print IPslist
;    ]
;  ]
end

to make-connections
  file-close-all ; close all open files
  if not file-exists? "../Input-files/adjacency_matrix.csv" [
    user-message "No file '../Input-files/adjacency_matrix.csv' exists."
    stop
  ]
  let ids_list []
  file-open "../Input-files/adjacency_matrix.csv" ; open the file with the links data
                                                  ; We'll read all the data in a single loop
  let i 0 ; initializing the row number of the adjacency matrix
  let id_data (csv:from-row file-read-line "~")
  set ids_list id_data
  set ids_list remove-item 0 ids_list
  ;print ids_list
  ;print data1
  while [ i < nb-total-agents ] [
    let row_data (csv:from-row file-read-line "~")
    ;print row_data
    let row_agent_id item 0 row_data
    set row_data remove-item 0 row_data
    let j 0 ;cloumn number of the adjacency matrix
    repeat nb-total-agents - nb-information-diss-agents [
      let trust_value item j row_data
      if trust_value != 0[
        ;print trust_value
        ;set trust

        let current_agent turtles with [ breed != IPs and agent-id = row_agent_id]
        ask current_agent [
          let temp item j ids_list
          set trust_values_list lput trust_value trust_values_list
          set connected_agents_list lput temp connected_agents_list
        ]
      ]
      set j j + 1
    ]
    let current_agent turtles with [breed != IPs and agent-id = row_agent_id]
    ask current_agent [
      set Id_trust_table table:make ; create an empty table
      foreach connected_agents_list [
        k ->
        let index position k connected_agents_list
        let value item index trust_values_list
        table:put Id_trust_table k value
      ]
      ;   print Id_trust_table
      ;   print agent-id
      ;   print connected_agents_list
      ;   print trust_values_list
      ;   print IPslist
    ]
    set i i + 1

  ]
end


;;; Procedure for Reading a File of Information Packets for the Current Tick
;;;   and Inserting the IPs in the Inboxes of the Referenced info-diss-agent
to get-next-IPs
  print word "Reading File of IPs for tick " tick-count
  file-close-all ; close all open files
  let ipfile word "../Input-files/IPsInput_tick_" tick-count
  set ipfile word ipfile ".csv"
  ifelse not file-exists? ipfile [
    set Flag_IP_File 1
    print word "No file (new IPs) " ipfile
  ][
    set Flag_IP_File 0
    file-open ipfile ; open the file with the new IPs
    ; Read the first line, which consists of IP attribute names
    let data csv:from-row file-read-line
    ; Read all the data in a single loop
    let IPs-read 0
    while [not file-at-end?] [
      set IPs-read IPs-read + 1
      ; Read one IP and put its parameters in a list
      set data csv:from-row file-read-line
      create-IPs 1 [
        set shape "square"
        set color orange
        set size 0.4
        set xcor -12
        set ycor random-ycor
        set agent-type item 0 data
        set DocumentID item 1 data
        set InformationSourceID item 2 data
        set topic-id item 3 data
        set IP-id item 4 data
        set stance item 5 data
        ; Update the IPslist of the appropriate Info dissimination agents with the new IPs
        ;   using a temp variable to store info agent id
        let IPsInformationSourceID InformationSourceID
        let IPsIP-id IP-id
        let current_agents information-diss-agents with [agent-ID = IPsInformationSourceID]
        ask current_agents [
          set IPslist lput IPsIP-id IPslist
        ]
      ]
    ]
    print word "Number of additional information packets = " IPs-read
  ]
end

;;; Procedure to Send ...
;;;
to send

  set Information_Action_list []
  set initial_track_list_IA []
  set initial_track_list_IA ["information_action_id" "information_action_type" "sending_agent_id" "receiving_agent_id" "information_packet_id" "endorsed_agent_id" "change_in_amplification" "tick" "simulation_id"]

  set Information_Action_list lput initial_track_list_IA Information_Action_list

  if (tick-count = 1 or Flag_IP_File = 0) [
    info_agent_send_func
  ]

  if tick-count > 1[
    other_agent_send_func
  ]

;    let infoAct  word "../Output-files/information-actions-tick-" tick-count
;    set infoAct (word infoAct "_" simulation_id)
;    (csv:to-file word infoAct".csv" Information_Action_list "~")
end

to read
  set identity-list []
  set initial-track-list10 ["identity_action_id" "agent_id" "identity_action_type" "triad_id" "change_in_stance" "change_in_latitude" "change_in_longitude" "tick" "simulation_id"]
  set identity-list lput initial-track-list10 identity-list

  set Relationship_Action_list []
  set initial_track_list_RA ["relationship_action_id" "source_agent_id" "target_agent_id" "action" "change_in_trust" "tick" "simulation_id"]
  set Relationship_Action_list lput initial_track_list_RA Relationship_Action_list

  let triadno 1
  let agents_with_IPs (turtle-set basic-agents spokesperson-agents) with [Inbox != []]
  ;; Process the contents of each agent's inbox, unless the inbox is empty
  ask agents_with_IPs [
    let tempIpslist []
    let reading_agent_id agent-id ; reading agent id
    let triad_topics triadtopics
    if length(inbox) > 0 [
      set tempIpslist inbox
      let j 0
      while [j < length(tempIpslist)] [
        ;;;; Process the jth item in an Inbox
        ;;     If the topic is new, maybe add it to the triadstack and create/update the relationship
        ;;     If the topic already exists, update the triad's stance and update the relationship
        ;;     If the stance is strong enough, forward the IP by putting it in the Outbox
        ;;     If the new stance matches the original stance for an existing topic, amplify the IP by putting it in the Outbox
        ;;     If ???, create an endorsement and put it in the Outbox
        let temp item j tempIpslist
        let current_IP IPs with [IP-id = item 0 temp]
        let sending_agent_id item 1 temp
        ask current_IP [
          let current_IP_stance stance
          let Ip_Id_log IP-id ; information_packet_id VARCHAR(25)
          let Ip_topic topic-id
          let reading_agent turtles with [breed != IPs and agent-id = reading_agent_id]
          ask reading_agent[


            ifelse member? Ip_topic triadtopics [
              ; The topic already exists, so maybe update the triad's stance and update the relationship with the sender
              ; Look through the stack to find the triad
              let len 0
              while [len < length(triadstack)] [
                let indexed_triad item len triadstack
                let change_stance 0
                let triad_id_to_log 0
                if item 1 indexed_triad = Ip_topic [
                  ; The triad with the matching topic is found
                  let itm2 (item 2 indexed_triad) ; get the stance of the triad
                  let stance_difference (current_IP_stance - itm2)
                  if ( abs(stance_difference) < 0.5 ) [
                    set change_stance (0.002 * stance_difference)
                    let new_stance_calculated (itm2 + change_stance) ; MNH fixed 4/5/2023
                    if new_stance_calculated > 3 [
                      set new_stance_calculated 3
                      set change_stance ( 3 - itm2 )
                    ]
                    if new_stance_calculated < -3 [
                      set new_stance_calculated -3
                      set change_stance ( -3 - itm2 )
                    ]

                      if change_stance != 0[
                      set triadstack (replace-item len triadstack(replace-item 2  (item len  triadstack) new_stance_calculated ))
                      set triad_id_to_log (item 0 (item len(triadstack)) )
                      ;identity_action_func reading_agent_id "MODIFY_STANCE" triad_id_to_log change_stance "0" "0" tick-count simulation_id
                    ]
                      information_action_func "RECEIVE" sending_agent_id reading_agent_id item 0 temp 0 "0" tick-count simulation_id

                  ]
                  if ( abs(stance_difference) < 0.25 ) [
                    ; there is sufficient stance agreement for forwarding
                    ifelse member? Ip_Id_log outbox []
                    [
                      set outbox lput Ip_Id_log outbox
                      set color brown
                    ]
                  ]
                  ; this potentially updates the relationship
                  if ( abs(stance_difference) < 0.05 ) [
                    if (table:has-key? Id_trust_table sending_agent_id) [
                      let trust_value table:get Id_trust_table sending_agent_id
                      table:put Id_trust_table sending_agent_id trust_value + 0.1
                      relationship_action_func reading_agent_id sending_agent_id "INCREASE_TRUST" 0.1 tick-count simulation_id
                    ]
                  ]
                  ; this potentially updates the relationship
                  if ( abs(stance_difference) > 5.0 ) [
                    if (table:has-key? Id_trust_table sending_agent_id) [
                      let trust_value table:get Id_trust_table sending_agent_id
                      table:put Id_trust_table sending_agent_id trust_value - 0.1
                      relationship_action_func reading_agent_id sending_agent_id "DECREASE_TRUST" -0.1 tick-count simulation_id
                    ]
                  ]

                  ]
                 if change_stance != 0[

                      identity_action_func reading_agent_id "MODIFY_STANCE" triad_id_to_log change_stance "0" "0" tick-count simulation_id 0
                    ]
                  ; If the 0.5 <= abs(stance_difference) <= 5.0, then the received IP is ignored
                  ;set len length(triadstack) ; In any case, the received IP has been considered, so stop searching the triadstac
                 set len len + 1
                ]

                ]

              [ ; Else, the topic is new, so maybe update the triad's stance and update the relationship with the sender
              let sending_agents turtles with [breed != IPs and agent-id = sending_agent_id]
              ask sending_agents [
                if agent-type = "information-diss-agents" [
                  ; The new topic was received from an information-dissemination agent, so add a triad to the stack
                  let temptriad []

                  let temptopic 0

                  ;if temptriad != [] [
                    ;print temptriad
                    ask reading_agent[
;                    ifelse member? Ip_topic triadtopics []
;                    [
                    let triad_to_log 0
                    let test_triadtopics triadtopics
                    ask current_IP[
                    let temp_t_name word "_" triadno
                    let new_triad_id word "Triad_ID_" triadno
                    let temp_triad_name word tick-count temp_t_name
                    set temptriad lput word "Triad_ID_" temp_triad_name temptriad
                    set temptriad lput topic-id temptriad
                    set temptriad lput stance temptriad
                    ;let stance_to_log stance
                    set triad_to_log word "Triad_ID_" temp_triad_name
                    set temptopic topic-id
                      ]
                    identity_action_func reading_agent_id "CREATE_by_info" triad_to_log 0 "0" "0" tick-count simulation_id Ip_topic
                    set triadstack lput temptriad triadstack
                    set triadtopics lput Ip_topic triadtopics
                    set triadno triadno + 1
                    ;]
                  ]
                  ask reading_agent[

                    ifelse member? Ip_Id_log outbox []
                    [
                      set outbox lput Ip_Id_log outbox
                      set color brown
                    ]
                  information_action_func "RECEIVE" sending_agent_id reading_agent_id Ip_Id_log 0 "0" tick-count simulation_id
                  ]
                ]
                if (agent-type = "spokesperson" or agent-type = "basic") [
                  ; The new topic was received from a basic or spokespeerson agent,
                  ;   so add a triad to the stack if the sender is trusted
                  let trust_value table:get Id_trust_table reading_agent_id
                  if trust_value > 0.8 [
                  let temptriad []

                  let temptopic 0
                  ;let current_IP IPs with [IP-id = item 0 temp]
                  ask reading_agent[
;                      ifelse member? Ip_topic triadtopics []
;\                    [
                    let triad_to_log 0
                    let test_triadtopics triadtopics
                    ask current_IP[
                    let temp_t_name word "_" triadno
                    let new_triad_id word "Triad_ID_" triadno
                    let temp_triad_name word tick-count temp_t_name
                    set temptriad lput word "Triad_ID_" temp_triad_name temptriad
                    set temptriad lput topic-id temptriad
                    set temptriad lput stance temptriad

                    ;let stance_to_log stance
                    set triad_to_log word "Triad_ID_" temp_triad_name
                    set temptopic topic-id
                    ]
                    identity_action_func reading_agent_id "CREATE_by_other" triad_to_log 0 "0" "0" tick-count simulation_id Ip_topic
                    set triadstack lput temptriad triadstack
                    set triadtopics lput Ip_topic triadtopics
                    set triadno triadno + 1
                      ;]
                    ]
                    ask reading_agent[
                      ifelse member? Ip_Id_log outbox []
                      [
                        set outbox lput Ip_Id_log outbox
                        set color brown
                      ]
                      information_action_func "RECEIVE" sending_agent_id reading_agent_id Ip_Id_log 0 "0" tick-count simulation_id
                    ]
                  ]
                ]
              ]
            ]
          ]

        ]
        set j j + 1
      ]

    ]
    set inbox []
  ]

end


to track_agents
  let track-list []
  let sub-list []
  let initial-track-list ["agent_id" "agent_type" "country" "county" "municipality" "latitude" "longitude" "gender" "age" "language" "nationality" "political_spectrum" "socioeconomic_status" "eu" "nato_donovia" "soldier_type" "triad_stack_id" "tick" "simulation_id"]
  ;print(initial-track-list)
  set track-list lput initial-track-list track-list
  foreach sort (turtle-set basic-agents spokesperson-agents) [ t ->
    ask t [
      set sub-list [ (list agent-id agent-type country county municipality latitude longitude  Gender Age Language Nationality PoliticalSpectrum SocioeconomicStatus EU NATODonovia soldier_type TriadStackID tick-count simulation_id)] of t
      set track-list lput sub-list track-list
    ]
  ]
  let agent_track_file  word "../Output-files/track_agents_" tick-count
  set agent_track_file (word agent_track_file "_" simulation_id)
  (csv:to-file word agent_track_file ".csv" track-list "~")
end

to track_triads
  let Triad-list []
  let sub-list12 []
  ; Create the header row ...
  let initial-track-list12 ["triad_id" "triad_stack_id" "topic_id" "stance" "tick" "simulation_id"]

  set Triad-list lput initial-track-list12 Triad-list
  foreach sort (turtle-set basic-agents spokesperson-agents) [ t ->
    ask t [
      let len 0
      while [len < length(triadstack)] [

        let temp_triad_id item 0 (item len(triadstack))
        let temp_topic_id item 1 (item len(triadstack))
        let temp_stance item 2 (item len(triadstack))

        set sub-list12 [ (list temp_triad_id triadstackid temp_topic_id temp_stance tick-count simulation_id)] of t
        set Triad-list lput sub-list12 Triad-list

        set len len + 1
      ]
     ]
   ]

  let triad_track_file  word "../Output-files/track_triads_" tick-count
  set triad_track_file (word triad_track_file "_" simulation_id)
  (csv:to-file word triad_track_file ".csv" Triad-list "~")

end



to go
  ; set tick-count  0 ;; this should be done during setup
  set actionid 0
  set identityactionid 0
  set relationship_action_id 0
  ;;get new IPs at each tick - setup IPs
  repeat Select_no_of_Ticks [

    set tick-count tick-count + 1
    get-next-IPs
    send
    read
    create_logs

  ]
end


;to setup_list
;  clear-all
;  let original-list ["IP-192" "IP-193" "IP-194" "IP-195" "IP-196" "IP-197" "IP-198" "IP-199" "IP-200" "IP-201"]
;  let random-list []
;  repeat 4 [
;    let random-index random length(original-list)
;    let random-item item random-index original-list
;    set random-list lput random-item random-list
;    set original-list remove-item random-index original-list
;  ]
;  print random-list
;end

to information_action_func [info_action_type sending_agent_id receiving_agent_id information_packet_id endorsed_agent_id change_in_amplif tick_no sim_id]
  set sub_list_IA []
            set actionid actionid + 1
            set sub_list_IA lput word "InfoAct_id_" actionid sub_list_IA
            set sub_list_IA lput info_action_type sub_list_IA
            set sub_list_IA lput sending_agent_id sub_list_IA
            set sub_list_IA lput receiving_agent_id sub_list_IA
            set sub_list_IA lput information_packet_id sub_list_IA
            set sub_list_IA lput endorsed_agent_id sub_list_IA
            set sub_list_IA lput change_in_amplif  sub_list_IA
            set sub_list_IA lput tick_no sub_list_IA
            set sub_list_IA lput sim_id sub_list_IA
            set Information_Action_list lput sub_list_IA Information_Action_list
end

to identity_action_func [agent_id identity_action_type triad_id_no change_in_stance change_in_latitude change_in_longitude tick_no sim_id temp_top_id ]
   set sub-list10 []
          set identityactionid identityactionid + 1
          set sub-list10 lput word "Identity_Act_id_" identityactionid sub-list10
          set sub-list10 lput agent_id sub-list10
          set sub-list10 lput identity_action_type sub-list10

          ;ifelse identity_action_type = "MODIFY_STANCE"[set sub-list10 lput triad_id_no sub-list10][
;          set sub-list10 lput triad_id_no sub-list10
;  ;]

          set sub-list10 lput triad_id_no sub-list10
          set sub-list10 lput change_in_stance sub-list10
          set sub-list10 lput change_in_latitude sub-list10
          set sub-list10 lput change_in_longitude sub-list10
          set sub-list10 lput tick_no sub-list10
          set sub-list10 lput sim_id sub-list10
    ;      set sub-list10 lput ts_test sub-list10
          set sub-list10 lput temp_top_id sub-list10
          ;set sub-list10 lput date-and-time sub-list10
          set identity-list lput sub-list10 identity-list
end

to relationship_action_func [source_agent_id target_agent_id action change_in_trust tick_no sim_id]
   set sub_list_RA[]
          set relationship_action_id relationship_action_id + 1
          set sub_list_RA lput word "Relation_Act_id_" relationship_action_id  sub_list_RA
          set sub_list_RA lput source_agent_id sub_list_RA
          set sub_list_RA lput target_agent_id sub_list_RA
          set sub_list_RA lput action sub_list_RA
          set sub_list_RA lput change_in_trust sub_list_RA
          set sub_list_RA lput tick_no sub_list_RA
          set sub_list_RA lput sim_id sub_list_RA
          ;set sub-list10 lput date-and-time sub-list10
          set Relationship_Action_list lput sub_list_RA Relationship_Action_list
end

to info_agent_send_func

  let info_agents_with_IPs information-diss-agents with [IPslist != [] and connected_agents_list != []]
  ask info_agents_with_IPs [
  let i 0
  let tempIpslist []
  let sending_agent_id agent-id ; sending agent id
    set tempIpslist IPslist ; list of Ips that are being sent
    while [i < length(connected_agents_list)] [
      let receiving_agent_id item i connected_agents_list
      let current_agent turtles with [breed != IPs and agent-id = receiving_agent_id]
      ask current_agent [
        let j 0
        while [j < length(tempIpslist)] [
          let temp []
          set temp lput item j tempIpslist temp; temp stores the current IP id and sending agent id
          set temp lput sending_agent_id temp
             ifelse member? item 0 temp inbox[
              ]
              [
               set inbox lput temp inbox
               information_action_func "SEND" sending_agent_id receiving_agent_id item 0 temp 0 "0" tick-count simulation_id
              ]
          set color red
          set j j + 1

        ]
;        print agent-id
;        print triadstack ; to see the current agent's triadstack
      ]
      set i i + 1
    ]
    set IPslist []
    ]
end

to other_agent_send_func
  print word "inside other_agent_send_func, tick-count = " tick-count
  let sending_agents_with_IPs (turtle-set basic-agents spokesperson-agents) with [Outbox != [] and connected_agents_list != []]
  ask sending_agents_with_IPs [

  let i 0
  let tempIpslist []
  let selected_random_IPs []
  let sending_agent_id agent-id ; sending agent id
  set tempIpslist Outbox

  while [i < length(connected_agents_list)] [
      ;set change_in_amplification 0
      let receiving_agent_id item i connected_agents_list ; reveiving agent id
      let trust_value table:get Id_trust_table receiving_agent_id ; checking the trust value between the sending agent(basic_agent_id) and receiving agent(search_id)
          ;print trust_value
      if trust_value > 0.7 [ ; MNH changed 0.4 to 0.7, so that fewer IPs are forwarded
              ;logic for information actions that will be performed on some of the Ips that our current basic agents is sending to the receiver
        ; logic for amplification of IPs
        let amplif_IPslist []
        let ampno 0
;        let AmplifyanInformationPacket false
        while [ampno < length(tempIpslist)] [
          let temp item ampno tempIpslist
          let current_IP IPs with [IP-id = temp]
          ask current_IP[
           let current_IP_stance stance
           let Ip_Id_log IP-id ; information_packet_id VARCHAR(25)
           let Ip_topic topic-id
           let current_sending_agent turtles with [breed != IPs and agent-id = sending_agent_id]
           ask current_sending_agent[
            let len 0
                while [len < length(triadstack)] [
                if item 1 (item len(triadstack)) = Ip_topic[
              if (( abs((item 2 (item len(triadstack))) - current_IP_stance)  < 0.01 ) and (current_IP_stance < 3 and current_IP_stance > -3))[
                     ask current_IP[
                    set stance stance + 0.1
                    ]
                    set amplif_IPslist lput Ip_Id_log amplif_IPslist
                  ]
                ]
                set len len + 1
              ]
          ]

          ]
          set ampno ampno + 1
        ] ; end of amplification logic

     ;logic for sending the IPs
        let current_agent turtles with [ breed != IPs and agent-id = receiving_agent_id]
     ask current_agent [
        let j 0
        while [j < length(tempIpslist)] [
          let triad_topics triadtopics

          let temp []
          set temp lput item j tempIpslist temp ; temp stores the current IP id and sending agent id
          set temp lput sending_agent_id temp
          ifelse member? item 0 temp inbox [
            ]
            [
               set inbox lput temp inbox
               ifelse member? item 0 temp amplif_IPslist [
                information_action_func "SEND" sending_agent_id receiving_agent_id item 0 temp 0 0.1 tick-count simulation_id
                 ]
                [
                information_action_func "SEND" sending_agent_id receiving_agent_id item 0 temp 0 0 tick-count simulation_id
                ]
              ]

              set j j + 1
            ]
     ] ;end of sending logic

        ]
        set i i + 1
    ]

      set Outbox []
]
end

to create_logs
  let infoAct  word "../Output-files/information-actions-tick-" tick-count
    set infoAct (word infoAct "_" simulation_id)
    (csv:to-file word infoAct".csv" Information_Action_list "~")
    let trackID  word "../Output-files/identity_action_tick_" tick-count
    set trackID (word trackID "_" simulation_id)
    (csv:to-file word trackID ".csv" identity-list "~")
    let relAct  word "../Output-files/realtionship_action_tick_" tick-count
    set relAct (word relAct "_" simulation_id)
    (csv:to-file word relAct ".csv" Relationship_Action_list "~")
    track_agents
    track_triads
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
58
10
164
43
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
621
110
686
143
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

SLIDER
17
180
189
213
Select_no_of_Ticks
Select_no_of_Ticks
0
10
5.0
1
1
NIL
HORIZONTAL

BUTTON
42
90
176
123
NIL
make-connections
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
227
139
260
NIL
go
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
604
167
708
200
export-world
export
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
605
225
709
258
import-world
import
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
