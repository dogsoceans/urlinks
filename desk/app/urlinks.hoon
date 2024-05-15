  ::  /app/urlinks
::::
::
/-  *urlinks 
/+  dbug,
    default-agent,
    *urlinks,
    verb,
    server,
    schooner
/*  styles  %css  /app/styles/css
/*  htmx  %js  /app/htmx/js

|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0
  $:  %0
      links=(list link)
      bio=@t
      name=@t
      image=@t
  ==
+$  card  card:agent:gall
--
%+  verb  &
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
=<
|_  =bowl:gall
+*  this     .
    default  ~(. (default-agent this %|) bowl)
    aux      ~(. +> bowl)
++  on-init
  ^-  [(list card) _this]
  ~&  >  "%urlinks initialized successfully."
  :-  :~  [%pass /eyre/connect %arvo %e %connect [~ /apps/[dap.bowl]] dap.bowl]
      ==
  this
++  on-save   !>(state)
++  on-load
  |=  old=vase
  ^-  [(list card) _this]
  :-  ^-  (list card)
      ~
  %=  this
    state  !<(state-0 old)
  ==
++  on-poke
  |=  [=mark =vase]
  ^-  [(list card) _this]
  =^  cards  state
    ?+    mark  (on-poke:default mark vase)
        %urlinks-action
      (action-handler !<(action vase))
        %handle-http-request
      (http-handler:aux !<([@ta inbound-request:eyre] vase))
    ==
  [cards this]
::
++  on-peek  on-peek:default
++  on-watch
   |=  =path
  ^-  (quip card _this)
  ?+    path
    (on-watch:default path)
      [%http-response *]
    %-  (slog leaf+"Eyre subscribed to {(spud path)}." ~)
    `this
  ==
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?+    sign-arvo  (on-arvo:default [wire sign-arvo])
      [%eyre %bound *]
    ?:  accepted.sign-arvo
      %-  (slog leaf+"/apps/{(trip dap.bowl)} bound successfully!" ~)
      [~ this]
    %-  (slog leaf+"Binding /apps/{(trip dap.bowl)} failed!" ~)
    [~ this]
  ==
++  on-leave  on-leave:default
++  on-agent  on-agent:default
++  on-fail   on-fail:default
--
::
::  Helper Core
::
|_  =bowl:gall
+*  this     .
    default  ~(. (default-agent this %|) bowl)
::
++  action-handler
|=  act=action
^-  [(list card) _state] ::removed list card cant poke  now
?+  -.act  `state
    %add-link
  =/  newlink=link  [label.act text.act]
  =/  newlinks=(list link)  (snoc links newlink)
  =/  new-state  state(links newlinks)
  `new-state
==
::
++  action-handler2
|=  act=action
^-  [_state]
?+  -.act  state
    %add-link
  =/  newlink=link  [label.act text.act]
  =/  newlinks=(list link)  (snoc links newlink)
  =/  new-state  state(links newlinks)
  new-state

==
::
++  action-parser
  |=  body=(unit octs)
  ^-  $@(null action)
  =/  args=(map @t @t)
    ?~(body ~ (frisk q.u.body))
  ?:  (~(has by args) 'send-add-link')
    [%add-link (~(got by args) 'label') (~(got by args) 'url')]
  ~
::
++  frisk  ::  parse url-encoded form args
  |=  body=@t
  %-  ~(gas by *(map @t @t))
  (fall (rush body yquy:de-purl:html) ~)
::
++  http-handler
|=  [eyre-id=@ta =inbound-request:eyre]
^-  [(list card) _state]
=/  body  body.request.inbound-request
=/  =request-line:server 
  (parse-request-line:server url.request.inbound-request)
=+  send=(cury response:schooner eyre-id)
::
?+    method.request.inbound-request  
  [(send [405 ~ [%stock ~]]) state]
  :: 
    %'GET'
  ?+    site.request-line  
      :_  state 
      (send [404 ~ [%plain "404 - Not Found"]])
    ::
    ::send css and js
    ::
      [%apps %urlinks %styles ~]
    :_  state
    (send [200 ~ [%text-css styles]])
      [%apps %urlinks %htmx ~]
    :_  state
    (send [200 ~ [%text-javascript htmx]])
    ::
      [%apps %urlinks ~]
    :_  state
    (send [200 ~ [%manx (page body-admin)]])
      [%apps %urlinks %add-link ~]
    :_  state
    (send [200 ~ [%manx link-maker]])
  ==
    %'POST'
  =/  action-parsed  (action-parser body)
  ?+    site.request-line  
    ?~  act-p  `state
    :_  (action-handler2 act-p)
      (send [202 ~ %json [%o p=[n=[p='message' q=[%s p='Post request successful']] l=~ r=~]]])
    [%apps %urlinks %add-link ~]
  =/  new-state  (action-handler2 action-parsed)
  :_  new-state
    (send [200 ~ [%manx (stateful-component newstate)]])
  
==
::
++  list
::
++  check-icon
^-  manx
;svg
  =fill  "#ffffff"
  =width  "32px"
  =height  "32px"
  =viewBox  "0 0 20 20"
  =xmlns  "http://www.w3.org/2000/svg"
    ;path
      =d  "M8.294 16.998c-.435 0-.847-.203-1.111-.553L3.61 11.724a1.392 1.392 0 0 1 .27-1.951 1.392 1.392 0 0 1 1.953.27l2.351 3.104 5.911-9.492a1.396 1.396 0 0 1 1.921-.445c.653.406.854 1.266.446 1.92L9.478 16.34a1.39 1.39 0 0 1-1.12.656c-.022.002-.042.002-.064.002z";
==
::
++  copy-icon
^-  manx
;svg
  =class  "copy-icon"
  =width  "32px"
  =height  "32px"
  =viewBox  "-2.4 -2.4 28.80 28.80"
  =fill  "none"
  =xmlns  "http://www.w3.org/2000/svg"
  =stroke  "#ffffff"
    ;path
      =d  "M14 7V7C14 6.06812 14 5.60218 13.8478 5.23463C13.6448 4.74458 13.2554 4.35523 12.7654 4.15224C12.3978 4 11.9319 4 11 4H8C6.11438 4 5.17157 4 4.58579 4.58579C4 5.17157 4 6.11438 4 8V11C4 11.9319 4 12.3978 4.15224 12.7654C4.35523 13.2554 4.74458 13.6448 5.23463 13.8478C5.60218 14 6.06812 14 7 14V14"
      =stroke  "#ffffff"
      =stroke-width  "2";
    ;rect
      =x  "10"
      =y  "10"
      =width  "10"
      =height  "10"
      =rx  "2"
      =stroke  "#ffffff"
      =stroke-width  "2";
==
::
++  settings-icon
;svg
  =width  "32px"
  =height  "32px"
  =viewBox  "0 0 24 24"
  =fill  "none"
  =xmlns  "http://www.w3.org/2000/svg"
    ;circle
      =cx  "12"
      =cy  "12"
      =r  "3"
      =stroke  "#ffffff"
      =stroke-width  "1.5";
    ;path
      =d  "M13.7654 2.15224C13.3978 2 12.9319 2 12 2C11.0681 2 10.6022 2 10.2346 2.15224C9.74457 2.35523 9.35522 2.74458 9.15223 3.23463C9.05957 3.45834 9.0233 3.7185 9.00911 4.09799C8.98826 4.65568 8.70226 5.17189 8.21894 5.45093C7.73564 5.72996 7.14559 5.71954 6.65219 5.45876C6.31645 5.2813 6.07301 5.18262 5.83294 5.15102C5.30704 5.08178 4.77518 5.22429 4.35436 5.5472C4.03874 5.78938 3.80577 6.1929 3.33983 6.99993C2.87389 7.80697 2.64092 8.21048 2.58899 8.60491C2.51976 9.1308 2.66227 9.66266 2.98518 10.0835C3.13256 10.2756 3.3397 10.437 3.66119 10.639C4.1338 10.936 4.43789 11.4419 4.43786 12C4.43783 12.5581 4.13375 13.0639 3.66118 13.3608C3.33965 13.5629 3.13248 13.7244 2.98508 13.9165C2.66217 14.3373 2.51966 14.8691 2.5889 15.395C2.64082 15.7894 2.87379 16.193 3.33973 17C3.80568 17.807 4.03865 18.2106 4.35426 18.4527C4.77508 18.7756 5.30694 18.9181 5.83284 18.8489C6.07289 18.8173 6.31632 18.7186 6.65204 18.5412C7.14547 18.2804 7.73556 18.27 8.2189 18.549C8.70224 18.8281 8.98826 19.3443 9.00911 19.9021C9.02331 20.2815 9.05957 20.5417 9.15223 20.7654C9.35522 21.2554 9.74457 21.6448 10.2346 21.8478C10.6022 22 11.0681 22 12 22C12.9319 22 13.3978 22 13.7654 21.8478C14.2554 21.6448 14.6448 21.2554 14.8477 20.7654C14.9404 20.5417 14.9767 20.2815 14.9909 19.902C15.0117 19.3443 15.2977 18.8281 15.781 18.549C16.2643 18.2699 16.8544 18.2804 17.3479 18.5412C17.6836 18.7186 17.927 18.8172 18.167 18.8488C18.6929 18.9181 19.2248 18.7756 19.6456 18.4527C19.9612 18.2105 20.1942 17.807 20.6601 16.9999C21.1261 16.1929 21.3591 15.7894 21.411 15.395C21.4802 14.8691 21.3377 14.3372 21.0148 13.9164C20.8674 13.7243 20.6602 13.5628 20.3387 13.3608C19.8662 13.0639 19.5621 12.558 19.5621 11.9999C19.5621 11.4418 19.8662 10.9361 20.3387 10.6392C20.6603 10.4371 20.8675 10.2757 21.0149 10.0835C21.3378 9.66273 21.4803 9.13087 21.4111 8.60497C21.3592 8.21055 21.1262 7.80703 20.6602 7C20.1943 6.19297 19.9613 5.78945 19.6457 5.54727C19.2249 5.22436 18.693 5.08185 18.1671 5.15109C17.9271 5.18269 17.6837 5.28136 17.3479 5.4588C16.8545 5.71959 16.2644 5.73002 15.7811 5.45096C15.2977 5.17191 15.0117 4.65566 14.9909 4.09794C14.9767 3.71848 14.9404 3.45833 14.8477 3.23463C14.6448 2.74458 14.2554 2.35523 13.7654 2.15224Z"
      =stroke  "#ffffff"
      =stroke-width  "1.5";
==

++  html-head
^-  manx
;head
  ;meta(charset "UTF-8");
  ;meta(name "viewport", content "width=device-width, initial-scale=1.0");
  ;title:"urLinks"
  ;link(rel "stylesheet", href "urlinks/styles.css");
  ;script(src "urlinks/htmx.js");
==
++  link-maker
^-  manx
;div(class "link-maker")
  ;div.inputs
    ;input(class "link-name", type "text", name "label", value "", placeholder "Name");
    ;input(class "link-url", type "text", name "url", value "", placeholder "URL");
  ==
  ;button(type "submit", hx-post "urlinks/link-maker", hx-include="closest .link-maker", name "send-add-link", value "send-add-link")
    ;+  check-icon
  ==
==

++  page
  |=  body=manx
  ^-  manx
  ;html
    ;+  html-head
    ;+  body
  ==

++  body-admin
^-  manx
;div.content-container
  ;header
    ;div.header-buttons
      ;div(class "copy-container", id "copyButton")
      copy sharable url
      ;+  copy-icon
      ==
      ;div(class "settings")
      ;+  settings-icon
      ==
    ==
    ;img(src "cannad PFP.png", alt "Profile Picture", class "profile-pic");
    ;div.profile-name: ~nospur-sontud
  ==
  ;div.link-container
    ;div(class "add-link", hx-trigger "click", hx-get "urlinks/add-link", hx-target ".link-list-target", hx-swap "beforeend")
      ; add link
    ==
    ;div.link-list-target;
  ==


==


--