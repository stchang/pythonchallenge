#lang racket

(require srfi/13)

(define test-string
  "g fmnc wms bgblr rpylqjyrc gr zw fylb. rfyrq ufyr amknsrcpq ypc dmp. bmgle gr gl zw fylb gq glcddgagclr ylb rfyr'q ufw rfgq rcvr gq qm jmle. sqgle qrpgle.kyicrpylq() gq pcamkkclbcb. lmu ynnjw ml rfc spj.")

(define ascii-z (char->integer #\z))
(define ascii-a (char->integer #\a))
(define ascii-Z (char->integer #\Z))
(define ascii-A (char->integer #\A))

(define (char+ c n)
  (let* ([ascii-char (char->integer c)]
         [new-ascii-char (if (or (<= ascii-a ascii-char ascii-z)
                                 (<= ascii-A ascii-char ascii-Z))
                             (+ ascii-char n)
                             ascii-char)])
    (integer->char
     (cond [(and (<= ascii-char ascii-z)
                 (> new-ascii-char ascii-z)) (+ ascii-a (- new-ascii-char ascii-z 1))]
           [else new-ascii-char]))))

(define (rot n)
  (λ (str)
    (apply string (build-list (string-length str) (λ (k) (char+ (string-ref str k) n))))))

(define rot2 (rot 2))
    