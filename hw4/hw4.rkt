
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;prob1
(define (sequence low high stride)
  (if (> low high) null
      (cons low (sequence (+ low stride) high stride))))

;prob2
(define (string-append-map xs suffix)
  (map (lambda (x)
         (string-append x suffix))
       xs))

;prob3
(define (list-nth-mod xs n)
  (cond [(< n 0) (error "list-nth-mod: negative number")]
        [(null? xs) (error "list-nth-mod: empty list")]
        [#t (let ([len-xs (length xs)])
         (car (list-tail xs (remainder n len-xs))))]))

;prob4
(define (stream-for-n-steps s n)
  (if (= n 0) null
      (let ([next (s)])
        (cons (car next) (stream-for-n-steps (cdr next) (- n 1))))))

;prob5
(define funny-number-stream
  (letrec ([f (lambda(x)
              (cons (if (= (remainder x 5) 0) (- x) x) 
                   (lambda () (f (+ x 1)))))])
    (lambda () (f 1))))

;prob6
(define dan-then-dog
  (letrec ([dog (lambda () (cons "dog.jpg" dan))]
           [dan (lambda () (cons "dan.jpg" dog))])
    dan))

;prob7
(define stream-add-zero (lambda (s)
                          (lambda()
                            (let ([next (s)])
                              (cons (cons 0 (car next))
                                  (stream-add-zero (cdr next)))))))

;prob8
(define (cycle-lists xs ys)
  (letrec ([ f (lambda (n)
               (cons (cons (list-nth-mod xs n) (list-nth-mod ys n))
                       (lambda () (f (+ n 1)))))])
    (lambda () (f 0))))

;prob9
(define (vector-assoc v vec)
  (letrec ([f (lambda (n)
                (if (< n (vector-length vec))
                    (let ([pr (vector-ref vec n)])
                      (cond [(not (pair? pr)) (f (+ n 1))]
                            [(equal? (car pr) v) pr]
                            [#t (f (+ n 1))]))
                    #f))])
    (f 0)))
  
;prob10
(define (cached-assoc xs n)
  (letrec ([cache (make-vector n #f)]
           [point 0]
           [f (lambda(v)
              (let ([cache-ans (vector-filter (lambda(x)
                                                (if (pair? x) (equal? (car x) v) #f)) cache)])
                (if (= (vector-length cache-ans) 0)
                    (let ([ans (assoc v xs)])
                      (if ans
                          (begin (vector-set! cache point ans)
                                 (set! point (if (< point (- n 1)) (+ point 1) 0))
                                 ans)
                           #t))
                    (vector-ref cache-ans 0))))])
    f))

;prob11
(define-syntax while-less
  (syntax-rules (do)
    [(while-less e1 do e2)
     (letrec ([a e1]
              [f (lambda()
                 (let ([b e2])
                   (if (< b a)
                       (f)
                       #t)))])
       (f))]))

                                               