; Ensure that emacs-lisp is compiled when saved
(require 'auto-async-byte-compile)
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)
