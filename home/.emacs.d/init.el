;;; Don't know lisp, but I know how to copy...:-)

; packaging
(require 'package)
;(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

; load custom packages
(let ((default-directory "~/.emacs.d/lisp/"))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))

;; load customisation files

; emacs-lisp config
(load "~/.emacs.d/emacs-lisp")

; look & feel
(load "~/.emacs.d/look-and-feel")

; misc functions
(load "~/.emacs.d/misc_functions")

; global key-bindings
(load "~/.emacs.d/global-keys")

; programming customisations
(load "~/.emacs.d/programming")

; other (non-programming) modes
(load "~/.emacs.d/modes")

; misc
(load "~/.emacs.d/misc")

(set-cursor-color "white")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-etags-requires 1)
 '(package-selected-packages
   (quote
    (magit magit-filenotify magit-find-file magit-gh-pulls magit-gitflow magit-imerge magit-lfs magit-popup zeal-at-point winpoint sr-speedbar puppet-mode psvn pos-tip php-mode markdown-mode+ lacarte jedi icomplete+ hexrgb go-stacktracer go-snippets go-scratch go-rename go-impl go-guru go-gopath go-errcheck go-eldoc go-direx go-complete go-autocomplete gitignore-mode fill-column-indicator feature-mode etags-select crosshairs cmake-mode autopair auto-complete-c-headers auto-async-byte-compile ac-etags ac-c-headers))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
