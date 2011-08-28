#lang racket


(define (4bytes->num bs)
  (+ (first bs)
     (* (second bs) 255)
     (* (third bs) 255 255)
     (* (fourth bs) 255 255 255)))

(define (read-chunk p)
  (printf "chunk: ")
  (define length-bytes (reverse (bytes->list (read-bytes 4 p))))
  (for-each displayln length-bytes)
  (define length (+ (first length-bytes)
                    (* (second length-bytes) 255)
                    (* (third length-bytes) 255 255)
                    (* (fourth length-bytes) 255 255 255)))
  (printf "~a bytes, " length)
  (define type-bytes (bytes->list (read-bytes 4 p)))
  (define type (apply string (map integer->char type-bytes)))
  (printf "type: ~a\n" type)
  (define data-bytes (bytes->list (read-bytes length p)))
  (read-bytes 4 p))
  

(define p (open-input-file "7/oxygen.bmp" #:mode 'binary))

(define header-field (read-bytes 2 p))
(define header-size (read-bytes 4 p))
(define size (4bytes->num (bytes->list header-size)))
(define header-reserved (read-bytes 4 p))
(define header-data-offset (read-bytes 4 p))
(define offset (4bytes->num (bytes->list header-data-offset)))
(define stuff-between-data (read-bytes offset p))

(bytes->list (read-bytes size p))



(close-input-port p)      