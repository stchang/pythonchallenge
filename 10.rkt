#lang lazy


;; return digits of number n in reverse order (lsb)
(define (get-digits n)
  (if (< n 10) 
      (list n)
      (cons (remainder n 10) (get-digits (quotient n 10)))))

;; list of digits (lsb) -> num
(define (un-digits digs)
  (let loop ([digs digs] [pos 0])
    (if (null? (cdr digs))
        (* (expt 10 pos) (car digs))
        (+ (* (expt 10 pos) (car digs)) (loop (cdr digs) (add1 pos))))))
      

(define (next n)
  (let ([digs (reverse (get-digits n))])
    (un-digits
     (reverse
      (let loop ([num (car digs)]
                 [digits (cdr digs)]
                 [count 1])
        (if (null? digits)
            (list count num)
            (if (= (car digits) num)
                (loop num (cdr digits) (add1 count))
                (append (list count num) (loop (car digits) (cdr digits) 1)))))))))
          
      
; (define a (list 1 11 21 1211 111221))

(define lst (cons 1 (map next lst)))

(!! (printf "length = ~a\n" (length (get-digits (list-ref lst 30)))))