;; Alternate Reality Tracking Contract

(define-data-var next-reality-id uint u0)

(define-map alternate-realities
  { reality-id: uint }
  {
    name: (string-ascii 64),
    divergence-point: uint,
    description: (string-utf8 500),
    creator: principal
  }
)

(define-public (create-reality (name (string-ascii 64)) (divergence-point uint) (description (string-utf8 500)))
  (let
    ((reality-id (+ (var-get next-reality-id) u1)))
    (var-set next-reality-id reality-id)
    (ok (map-set alternate-realities
      { reality-id: reality-id }
      {
        name: name,
        divergence-point: divergence-point,
        description: description,
        creator: tx-sender
      }
    ))
  )
)

(define-read-only (get-reality (reality-id uint))
  (map-get? alternate-realities { reality-id: reality-id })
)

