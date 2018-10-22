(global-font-lock-mode 1)
(transient-mark-mode 1)
(column-number-mode 1)
(line-number-mode 1)
(size-indication-mode t)
(show-paren-mode t)
(setq-default show-trailing-whitespace t)

;; auto-open compressed files
(auto-compression-mode 1)

(setq untranslated-filesystem-list '("z:" "r:" "p:" "q:") )

(setq default-directory "~/rapid7/")

; winpoint remembers buffer position per window rather than just per buffer
; doesn't work with 26.x
;(require 'winpoint)
;(window-point-remember-mode 1)

; use plink as default tramp mode
;(setq tramp-default-method "plink"
;      tramp-default-user "rok"
;      tramp-default-host "orion")

; auto revert files if detected they changed on disk (svn id work around:)
(global-auto-revert-mode 1)

; Buffer cleanup
(require 'midnight)
(midnight-delay-set 'midnight-delay "7:30am")
(setq clean-buffer-list-delay-general 3)
(add-to-list 'clean-buffer-list-kill-buffer-names
             '("*buffer-selection*"
               "notes.txt"
               "TAGS"))

; use wcgrep by default
(require 'grep)
(grep-apply-setting 'grep-command "wcgrep ")
(setq grep-highlight-matches t)

;; If at beginning of a line, don't make me C-k twice.
(setq kill-whole-line t)

; Server-mode!
(server-start)

; raise window from an emacsclient call
(defadvice raise-frame (after make-it-work (&optional frame) activate)
    "Work around some bug? in raise-frame/Emacs/GTK/Metacity/something.
     Katsumi Yamaoka posted this in
     http://article.gmane.org/gmane.emacs.devel:39702"
     (call-process
     "wmctrl" nil nil nil "-i" "-R"
     (frame-parameter (or frame (selected-frame)) 'outer-window-id)))
(add-hook 'server-switch-hook 'raise-frame)

; org mode
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
