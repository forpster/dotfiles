(add-hook 'perl-mode-hook 'newline-should-indent)
(add-hook 'c-mode-hook 'newline-should-indent)
(add-hook 'c++-mode-hook 'newline-should-indent)
;(add-hook 'python-mode-hook 'newline-should-indent)
(defun newline-should-indent ()
  "Do some things specific to perl mode"
  (interactive)
  (local-set-key "\C-m" 'newline-and-indent)
)

; Mode specific hoooks
(add-hook 'c-mode-common-hook
	  (function (lambda ()
		      (local-set-key (kbd "<tab>") 'indent-or-complete)
		      )))
(add-hook 'c-mode-common-hook
  (lambda ()
    (require 'doxymacs)
    (doxymacs-mode t)
    (doxymacs-font-lock)))
; HideShow - code folding/collapsing
(add-hook 'c-mode-common-hook
  (lambda()
    (local-set-key (kbd "C-c <right>") 'hs-show-block)
    (local-set-key (kbd "C-c <left>")  'hs-hide-block)
    (local-set-key (kbd "C-c <up>")    'hs-hide-all)
    (local-set-key (kbd "C-c <down>")  'hs-show-all)
    (hs-minor-mode t)
    (setq hs-isearch-open t)))

;(add-hook 'python-mode-hook
;	  (function (lambda ()
;		      (local-set-key (kbd "<tab>") 'indent-or-complete)
;                      (add-hook 'write-contents-hooks 'rok-cleanup nil t)
;		      )))

(add-hook 'perl-mode-hook
	  (function (lambda ()
		      (local-set-key (kbd "<tab>") 'indent-or-complete)
                      (add-hook 'write-contents-hooks 'rok-cleanup nil t)
		      )))

(defun rok-linux-c-mode-hook ()
  (c-set-style "linux")
  (setq indent-tabs-mode t)
  (setq c-basic-offset 4))

(defun rok-pace-c-mode-hook ()
  (c-set-style "k&r")
  (setq c-basic-offset 3)
  (setq c-indent-level 3)
  (setq c-tab-always-indent t)
  (setq c-argdecl-indent 0)
  (setq backward-delete-function nil)
  (c-set-offset 'innamespace 0)
  (add-hook 'write-contents-hooks 'rok-cleanup nil t))

(defun rok-c-mode-hook ()
  (c-set-style "bsd")
  (setq c-basic-offset 2)
  (setq c-indent-level 2)
  (setq c-tab-always-indent t)
  (setq c-argdecl-indent 0)
  (c-set-offset 'innamespace 0)
  (setq backward-delete-function nil)
  (add-hook 'write-contents-hooks 'rok-cleanup nil t))

(defun my-c-mode-hook ()
;  (if (string-match "linux-kernel/" buffer-file-name)
;      (rok-linux-c-mode-hook) ; kernel mode only for kernel editing!
;    (rok-c-mode-hook) ; my style otherwise
;    ))
(cond ((string-match "linux-kernel/" buffer-file-name) (rok-linux-c-mode-hook) nil)
      ((string-match "pace/" buffer-file-name) (rok-pace-c-mode-hook) nil)
      (t (rok-c-mode-hook) nil))
)
(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)

(setq auto-mode-alist
      (append '(("\\.C$"  . c++-mode)
                ("\\.cc$" . c++-mode)
                ("\\.hh$" . c++-mode)
                ("\\.c$"  . c-mode)
                ("\\.h$"  . c++-mode)
                ("\\.hpp$" . c++-mode)
                ("\\.cpp$" . c++-mode)
                ("\\.t$" . perl-mode)
                ("\\.mak$" . makefile-mode))
              auto-mode-alist))

; auto find the associated header/cpp
(add-hook 'c-mode-common-hook
          (lambda()
            (local-set-key  (kbd "C-c o") 'ff-find-other-file)))
; tell it to look for the correct sort of associated filename extension
(setq cc-other-file-alist
      '(("\\.cpp$" (".hpp" ".h"))
        ("\\.h$" (".c" ".cpp"))
        ("\\.hpp$" (".cpp"))
        ))

; Setup some search directories for where to look for header files
; todo workout how to avoid .svn folders
(setq cc-search-directories
      '("." "z:/dev/source/*/h" "z:/dev/source/*/h/*" "z:/dev/source/*/h/*/*"))

; automatically add in the closing brackets
(require 'autopair)
(autopair-global-mode 1)

; Add cmake listfile names to the mode list.
(setq auto-mode-alist
	  (append
	   '(("CMakeLists\\.txt\\'" . cmake-mode))
	   '(("\\.cmake\\'" . cmake-mode))
	   auto-mode-alist))
(require 'cmake-mode)

(defun cmake-rename-buffer ()
  "Renames a CMakeLists.txt buffer to cmake-<directory name>."
  (interactive)
  ;(print (concat "buffer-filename = " (buffer-file-name)))
  ;(print (concat "buffer-name     = " (buffer-name)))
  (when (and (buffer-file-name) (string-match "CMakeLists.txt" (buffer-name)))
      ;(setq file-name (file-name-nondirectory (buffer-file-name)))
      (setq parent-dir (file-name-nondirectory (directory-file-name (file-name-directory (buffer-file-name)))))
      ;(print (concat "parent-dir = " parent-dir))
      (setq new-buffer-name (concat "cmake-" parent-dir))
      ;(print (concat "new-buffer-name= " new-buffer-name))
      (rename-buffer new-buffer-name t)
      )
  )

(add-hook 'cmake-mode-hook (function cmake-rename-buffer))

; JPO's selinux policy one
(setq auto-mode-alist
      (append
       '(("\\.te$" . policy-mode))
       '(("\\.if$" . policy-mode))
       '(("\\.te.gen$" . policy-mode))
       '(("\\.if.gen$" . policy-mode))
       '(("\\.fc$" . policy-mode))
       auto-mode-alist))
(require 'policy)
(add-hook 'policy-mode-hook
	  (function (lambda ()
                      (add-hook 'write-contents-hooks 'rok-cleanup nil t)
		      )))

(require 'php-mode)
(setq auto-mode-alist
      (append
       '(("\\.php$" . php-mode))
       auto-mode-alist))

; Key bindings for doxymacs! Cuz i will forget the buggers otherwise
; C-c d ? will look up documentation for the symbol under the point.
; C-c d r will rescan your Doxygen tags file.
; C-c d f will insert a Doxygen comment for the next function.
; C-c d i will insert a Doxygen comment for the current file.
; C-c d ; will insert a Doxygen comment for a member variable on the current line (like M-;).
; C-c d m will insert a blank multi-line Doxygen comment.
; C-c d s will insert a blank single-line Doxygen comment.
; C-c d @ will insert grouping comments around the current region.
(setq doxymacs-command-character "\\")

; cscope
(require 'xcscope)
(setq cscope-do-not-update-database t)

; Use the GDB visual debugging mode
(setq gdb-many-windows t)
(setq gdb-speedbar-auto-raise t)

; etags with vim style select
(require 'etags-select)
; back up directory tree to get a TAGS file automatically
(defun etags-select-get-tag-files ()
    "Get tag files."
    (if etags-select-use-xemacs-etags-p
        (buffer-tag-table-list)
      (mapcar 'tags-expand-table-name tags-table-list)
      (tags-table-check-computed-list)
      tags-table-computed-list))

(global-set-key "\M-?" 'etags-select-find-tag-at-point)
(global-set-key "\M-." 'etags-select-find-tag)

; tab width = 2
(setq-default tab-width 2)
;(setq-default tab-stop-list '(2 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))
(setq-default indent-tabs-mode nil)

; enable semantic
(require 'semantic)
(semantic-mode 1)
(setq root-include (let ((rootsys (getenv "ROOTSYS")))
                     (if rootsys
                         (concat rootsys "/include")
                       "/usr/include/")))

(add-hook 'c-mode-common-hook
          (lambda ()
            (unless (and (featurep 'semantic/ia)
                         ;; (featurep 'semantic/sb)
                         ;; (featurep 'semantic/ia-sb)
                         )
              (load-library "semantic/ia")
              ;; (load-library "semantic/sb")
              ;; (load-library "semantic/ia-sb")
              )
            (define-key c-mode-base-map (kbd "C-c ?") 'semantic-ia-complete-symbol)
            (define-key c-mode-base-map (kbd "C-c t") 'semantic-ia-complete-tip)
            (define-key c-mode-base-map (kbd "C-c v") 'semantic-ia-show-variants)
            (define-key c-mode-base-map (kbd "C-c d") 'semantic-ia-show-doc)
            (define-key c-mode-base-map (kbd "C-c s") 'semantic-ia-show-summary)
            ;; for semantic imenu
            (setq imenu-create-index-function 'semantic-create-imenu-index)
            (imenu-add-to-menubar "C++-Tags")))
(semantic-add-system-include root-include 'c++-mode)
(semantic-add-system-include root-include 'c-mode)
; C-c , l     - possible completitions
; C-c , <SPC> - completition


; auto-complete mode
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)           ;enable global-mode
(setq ac-auto-start t)                  ;automatically start
(setq ac-dwim t)                        ;Do what i mean
(setq ac-override-local-map nil)        ;don't override local map
(global-set-key "\M-/" 'auto-complete)

; defer loading of ac-etags until etags is loaded
(custom-set-variables '(ac-etags-requires 1))
(eval-after-load "etags"
  '(progn (ac-etags-setup)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; C-common-mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Enables omnicompletion with `c-mode-common'.
(add-hook 'c-mode-common-hook
          '(lambda ()
             (add-to-list 'ac-omni-completion-sources
                          (cons "\\." '(ac-source-semantic)))
             (add-to-list 'ac-omni-completion-sources
                          (cons "->" '(ac-source-semantic)))
             (add-to-list 'ac-sources 'ac-source-semantic)
; ROK 17/02/14 - These cause auto-complete to fail, don't know why!
;             (add-to-list 'ac-sources 'ac-source-c-headers)
;             (add-to-list 'ac-sources 'ac-source-c-header-symbols)
             (add-to-list 'ac-sources 'ac-source-etags)))

;; Various key bindings
;; M-; - Comments in any mode
;; M-- - Negate what the following cmd would go so M-- M-; removes comments

;; psvn - tools menu or M-x svn-status
(require 'psvn)

; Rename buffers that match with parts of the path
(require 'uniquify)
(setq
  uniquify-buffer-name-style 'post-forward
  uniquify-separator ":")

;; Fix hex strings into a C array format
;; C-u M-| ~/hexstr.py

; load python config
(load "~/.emacs.d/programming-python")

; basic jess support
(add-hook 'lisp-mode-hook
	  (function (lambda ()
                      (add-hook 'write-contents-hooks 'rok-cleanup nil t)
		      )))
(setq auto-mode-alist
      (append '(("\\.clp$"  . lisp-mode))
              auto-mode-alist))

; ruby script modes
(add-hook 'ruby-mode-hook
	  (function (lambda ()
                      (add-hook 'write-contents-hooks 'rok-cleanup nil t)
		      )))
(setq auto-mode-alist
      (append '(("\\.rb$"  . ruby-mode))
              auto-mode-alist))

; print margin support
(require 'fill-column-indicator)
(setq fci-rule-use-dashes 1)
(setq fci-rule-column 120)
(setq fci-rule-color "royalblue")
(setq fci-rule-width 1)
(add-hook 'java-mode-hook 'fci-mode)
(add-hook 'lisp-mode-hook 'fci-mode)

; cucumber feature mode
(require 'feature-mode)
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))
(setq feature-step-search-path "/home/rkirk/rapid7/nexpose/src/internal/private/cucumber/features/**/step_definitions/*steps.rb")

; brah
(load "~/.emacs.d/bro-mode")
(require 'bro-mode)
