;;; Don't know lisp, but I know how to copy...:-)

; packaging
(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
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
