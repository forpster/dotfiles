;;
;; Setup puppet-mode for autoloading
;;
(autoload 'puppet-mode "puppet-mode" "Major mode for editing puppet manifests")
(add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))

; Setup custom XML file extensions
(setq auto-mode-alist
      (append '(("\\.vck$"  . nxml-mode)
                ("\\.sol$" . nxml-mode))
              auto-mode-alist))
