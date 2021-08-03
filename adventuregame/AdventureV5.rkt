;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname AdventureV5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;Names:
;;Sarah Joyce
;;Kelly Mi
;;Zihan (Anna) Wu
;;Alex Donahue

(require 2htdp/image)
(require 2htdp/universe)

;upgrade the game to include states and a small inventory; ex: a number of keys??

;Path 1: go to defeat the space dragon. Path 2: Shoot something random out of your wand.

;DEFINED PAGES
(define page0 "Welcome to Choose Your Own Adventure. You are a wizard who lives on a cliff on the moon. You are lonely on the moon. You are going to find some friends. Press a to go left or c to shoot something random out of your wand.")
(define page1 "You see a Wanted poster about a space dragon. This space dragon is destroying everything! Press b to go on an adventure to defeat the space dragon. Press c to shoot something random out of your wand.")
(define page2 "You set out to find the dragon. You go back to your house to gather supplies. Press d to pick a sword and e to pick a bottle of water.")
(define page3 "You cast a spell and frogs appear. Press b to continue and press h to shoot something else.")
(define page4 "You pick up the ")
(define page4a " You enter the dragon's lair. The dragon comments on your large sword. You approach the dragon and it breathes fire at you and you die.")
(define page4b " You enter the dragon's lair. You find the space dragon in his lair. The dragon laughs at your water bottle. The dragon breathes fire and you throw the water bottle at it which saves you. Good job, you won!")
(define page5 "You cast a spell and frogs appear. Press a to continue and press i to shoot something else.")
(define page6 "You cast a spell and frogs appear. Press a to continue and press j to shoot something else.")
(define page7 "You cast a spell and frogs appear. Press a to continue.")



;Maps which keys/choices goes to which page
(define (handle-key previous new)
  (cond
    [(key=? new "s") (make-player page0 "")]
    [(key=? new "a") (make-player page1 "")]
    [(key=? new "b") (make-player page2 "")]
    [(key=? new "c") (make-player page3 "")]
    [(key=? new "d") (make-player page4 "sword")]  ;does not work; can't create multiple actions for cond??
    [(key=? new "e") (make-player page4 "water")]  ;does not work; can't create multiple actions for cond??
   ; [(key=? new "v")
    ; (cond [(string=? (player-item aplayer)"sword") page4a] 
    ;       [(string=? (player-item aplayer)"water") page4b]  ;does not work; can't refer back to inventory because it does not have a set name when made          
    ; )] 
    [(key=? new "h") (make-player page5 "")]
    [(key=? new "i") (make-player page6 "")]
    [(key=? new "j") (make-player page7 "")]
    ))


(define (player-draw ourplayer)
  (cond [(string=? (player-page ourplayer) page0) (text/font page0 12 "black" "Gill Sans" 'decorative 'normal 'bold #f)]
        [(string=? (player-page ourplayer) page1) (text/font page1 12 "black" "Gill Sans" 'decorative 'normal 'bold #f)]
        [(string=? (player-page ourplayer) page2) (text/font page2 12 "black" "Gill Sans" 'decorative 'normal 'bold #f)]
        [(string=? (player-page ourplayer) page3)(text/font page3 12 "black" "Gill Sans" 'decorative 'normal 'bold #f)]
        
        [(and (string=? (player-page ourplayer) page4)
           (string=? (player-item ourplayer) "sword"))

         (text/font (string-append page4 "sword." page4a) 12 "black" "Gill Sans" 'decorative 'normal 'bold #f)]
        
        [(and (string=? (player-page ourplayer) page4)
           (string=? (player-item ourplayer) "water"))

         (text/font (string-append page4 "waterbottle." page4b) 12 "black" "Gill Sans" 'decorative 'normal 'bold #f)]
        
        [(string=? (player-page ourplayer) page5) (text/font page5 12 "black" "Gill Sans" 'decorative 'normal 'bold #f)]
        [(string=? (player-page ourplayer) page6) (text/font page6 12 "black" "Gill Sans" 'decorative 'normal 'bold #f)]
        [(string=? (player-page ourplayer) page7) (text/font page7 12 "black" "Gill Sans" 'decorative 'normal 'bold #f)]
        ))

;Renders the text/pages as images on screen
;(define (render-text playerpos)
;  (text/font  12 "black" "Gill Sans" 'decorative 'normal 'bold #f))

;One item inventory
(define-struct player (page item))

(define aplayer (make-player page4b "howdoyousetthisstring"))



(define (main init)
  (big-bang (handle-key "s" "s")
            (to-draw player-draw)
            (on-key handle-key)))

(main page0)


;(cond[ sword(define PLAYERINV1 (make-inventory "sword"))]
;(define PLAYERINV1 (make-inventory "waterbottle"))

;Give character small inventory -> a number of keys? / single number
;(define playerinventory (make-inventory "" "" ""))

;(define (grabitem item)
;  (make-inventory(player item)))

;(define-struct sword(element length))
;(define-struct waterbottle(size))



