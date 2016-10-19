;; duplicate a line and comment the first
(global-set-key (kbd "C-c c") (lambda()(interactive)(rok-duplicate-line t)))

;;; vi roolz! (why doesn't emacs like \C-. for a key specification?
;;(global-set-key [(\M-.)] 'call-last-kdb-macro)

(global-set-key [(meta return)] 'hippie-expand)
(global-set-key [f7] 'compile)
;(global-set-key (kbd "C-.") 'find-tag)
(global-set-key "\M-g" 'goto-line)
(global-set-key (kbd "C-c u") 'untabify)
(global-set-key (kbd "C-c i") 'indent-region)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x b") 'switch-to-buffer)
(global-set-key (kbd "C-c C-v") 'uncomment-region)
