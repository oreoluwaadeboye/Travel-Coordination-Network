;; Temporal Ethics Compliance Contract

(define-data-var next-rule-id uint u0)

(define-map ethical-rules
  { rule-id: uint }
  {
    description: (string-utf8 500),
    penalty: uint
  }
)

(define-map violations
  { violation-id: uint }
  {
    rule-id: uint,
    traveler: principal,
    description: (string-utf8 500)
  }
)

(define-data-var next-violation-id uint u0)

(define-public (add-ethical-rule (description (string-utf8 500)) (penalty uint))
  (let
    ((rule-id (+ (var-get next-rule-id) u1)))
    (var-set next-rule-id rule-id)
    (ok (map-set ethical-rules
      { rule-id: rule-id }
      {
        description: description,
        penalty: penalty
      }
    ))
  )
)

(define-public (report-violation (rule-id uint) (description (string-utf8 500)))
  (let
    ((violation-id (+ (var-get next-violation-id) u1)))
    (var-set next-violation-id violation-id)
    (ok (map-set violations
      { violation-id: violation-id }
      {
        rule-id: rule-id,
        traveler: tx-sender,
        description: description
      }
    ))
  )
)

(define-read-only (get-ethical-rule (rule-id uint))
  (map-get? ethical-rules { rule-id: rule-id })
)

(define-read-only (get-violation (violation-id uint))
  (map-get? violations { violation-id: violation-id })
)

