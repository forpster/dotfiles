;; set window positioning
;(add-to-list 'default-frame-alist '(height . 63))
;(add-to-list 'default-frame-alist '(width . 120))
;(add-to-list 'default-frame-alist '(top . 0))
;(add-to-list 'default-frame-alist '(left . 795))
;(add-to-list 'default-frame-alist '(left . 950))

;; set font
;(if (eq window-system 'w32)
;    (set-face-font 'default "-*-Lucida Console-normal-*-*-*-15-*-*-*-*-*-*-*"))
;(set-face-font 'default "-*-DejaVu Sans Mono-normal-normal-normal-*-15-*-*-*-m-0-iso10646-1")
;; set default font in initial window and for any new window
(cond
 ((string-equal system-type "windows-nt") ; Microsoft Windows
  (when (member "DejaVu Sans Mono" (font-family-list))
    (add-to-list 'initial-frame-alist '(font . "DejaVu Sans Mono-10"))
    (add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-10"))))
 ((string-equal system-type "darwin") ; macOS
  (when (member "Menlo" (font-family-list))
    (add-to-list 'initial-frame-alist '(font . "Inconsolata"))
    (add-to-list 'default-frame-alist '(font . "Inconsolata"))))
 ((string-equal system-type "gnu/linux") ; linux
  (when (member "DejaVu Sans Mono" (font-family-list))
    (add-to-list 'initial-frame-alist '(font . "DejaVu Sans Mono-12"))
    (add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-12")))))

;; cursor
;(set-cursor-color "white")
(blink-cursor-mode -1) ; used to be to nil

;; colours
(invert-face 'default)

;; mouse behaviour
(setq mouse-wheel-mode t)

; Dont do big scroll jumps when moving past the last line on top/bottom of screen
(setq
  scroll-margin 0
  scroll-conservatively 100000
  scroll-preserve-screen-position 1)

; wrong side emacs!
(set-scroll-bar-mode 'right)

;; only split vertically by default
(setq split-width-threshold nil)

; hide startup screen
(setq inhibit-startup-screen t)
