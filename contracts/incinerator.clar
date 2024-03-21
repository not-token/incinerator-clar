;; Constants ;;
(define-constant ERR-ERROR-UNWRAP u400)
(define-constant ERR-ERROR-TRANSFER u401)
(define-constant ERR-YOU-POOR u402)  ;; for the culture
(define-constant CONTRACT_OWNER tx-sender)

;; Public variables ;;
(define-data-var nothing-burner-amount uint u0)

;; Functions ;;
(define-read-only (get-nothing-burner-amount) 
    ;; variables need to be read to be read 
    (ok (var-get nothing-burner-amount)))

(define-private (increase-nothing-burner-amount (amount uint))
    (var-set nothing-burner-amount (+ (var-get nothing-burner-amount) amount)))
;;   no need for ok true since this function is private
;; resopnse types like ok and err should only be preserved for 
;; public and readonly functions basically the interface of the contract
;;   (ok true))


(define-public (burn-nothing (amount uint))
    (begin 
        ;; unwrap should do the trick for response types unwrap can reformat the error
        ;; if work with boolean types
        ;; for the analyzer to know that the unwrap and burn amount operations do the checking for us
        ;; #[filter(amount)]
        (unwrap! (contract-call? 'SP32AEEF6WW5Y0NMJ1S8SBSZDAY8R5J32NBZFPKKZ.nope unwrap amount) (err ERR-ERROR-UNWRAP))
        (unwrap! (contract-call? 'SP32AEEF6WW5Y0NMJ1S8SBSZDAY8R5J32NBZFPKKZ.micro-nthng transfer (as-contract tx-sender) amount) (err ERR-ERROR-TRANSFER))
        (increase-nothing-burner-amount amount)
        (ok true)))
