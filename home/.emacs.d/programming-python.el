(add-hook 'python-mode-hook 'newline-should-indent)

(add-hook 'python-mode-hook
	  (function (lambda ()
		      (local-set-key (kbd "<tab>") 'indent-or-complete)
                      (add-hook 'write-contents-hooks 'rok-cleanup nil t)
		      )))

;(setq jedi:setup-keys t)
;(add-hook 'python-mode-hook 'jedi:setup)
