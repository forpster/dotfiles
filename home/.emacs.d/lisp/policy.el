;;; policy.el --- makefile editing commands for Emacs


;;; Code:

(provide 'policy)

;; Sadly we need this for a macro.
(eval-when-compile
  (require 'dabbrev)
  (require 'add-log))

;;; ------------------------------------------------------------
;;; Configurable stuff
;;; ------------------------------------------------------------

(defgroup policy nil
  "policy editing commands for Emacs."
  :group 'tools
  :prefix "policy-")


(defcustom policy-cleanup-continuations-p t
  "*If non-nil, automatically clean up continuation lines when saving.
A line is cleaned up by removing all whitespace following a trailing
backslash.  This is done silently.
IMPORTANT: Please note that enabling this option causes policy mode
to MODIFY A FILE WITHOUT YOUR CONFIRMATION when \"it seems necessary\"."
  :type 'boolean
  :group 'policy)

(defcustom policy-mode-hook nil
  "*Normal hook run by `policy-mode'."
  :type 'hook
  :group 'policy)

;; Note that the first subexpression is used by font lock.  Note
;; that if you change this regexp you might have to fix the imenu
;; index in policy-imenu-generic-expression.
(defconst policy-font-lock-keywords
  (list
   '("\\<\\([a-zA-Z][a-zA-Z0-9_%]*_t\\)\\>" 1 font-lock-variable-name-face)
   '("\\<\\(\\$[0-9]+\\)\\>" 1 font-lock-variable-name-face)
   '("\\<\\([a-z][a-z0-9_A-Z%]*\\)(" 1 font-lock-function-name-face)
   (list (regexp-opt '("capability" "process" "key" "lnk_file" 
                       "packet" "tcp_socket" "fifo_file" "filesystem"
                       "association" "file" "unix_dgram_socket" "dir"
                       "sock_file" "unix_stream_socket" "shm" "sem"
                       "fd" "msg" "msgq" "chr_file" "blk_file" "udp_socket"
                       "socket" "key_socket"
                       ) 'words) 1 'font-lock-type-face)
   (list (regexp-opt '("self"
                       ) 'words) 1 'font-lock-constant-face)
   (list (regexp-opt '("neverallow" "allow" "type" "role" "types" 
                       ) 'words) 1 'font-lock-builtin-face)
   (list (regexp-opt '("entrypoint" "read" "write" "ptrace" 
                       "setuid" "setgid" "signal" "sys_admin" 
                       "sys_tty_config" "send" "recv" "search"
                       "recvfrom" "sendto" "getattr" "setcap"
                       "link" "setrlimit" "sys_module"
                       "getpgid" "setsched" "setpgid" "kill"
                       "swapon" "use" "connectto" "receive"
                       "lock" "ioctl" "add_name" "remove_name"
                       "relabelto" "relabelfrom" "create" "unlink"
                       "append" "rename" "open" "setattr" "execute"
                       "execute_no_trans" "reparent" "rmdir"
                       "associate" "unix_read" "unix_write" "destroy" 
                       "enqueue" "tcp_recv" "tcp_send" "udp_recv" "udp_send"
                       "rawip_recv" "rawip_send" "sigchld" "sigkill" "sigstop"
                       "signull" "bind" "connect" "getopt" "setopt" "shutdown"
                       "mount" "remount" "unmount" "listen" "accept" "execmod"
                       "fork" 
                       ) 'words) 1 'font-lock-constant-face)
   '("\\<\\([a-z][a-z0-9A-Z_%]*\\)\\>" 1 font-lock-string-face)

   ;; Highlight spaces that precede tabs.
   ;; They can make a tab fail to be effective.
   ))

(defcustom policy-up-to-date-buffer-name "*policy Up-to-date overview*"
  "*Name of the Up-to-date overview buffer."
  :type 'string
  :group 'policy)

;;; --- end of up-to-date-overview configuration ------------------

(defvar policy-mode-abbrev-table nil
  "Abbrev table in use in policy buffers.")
(if policy-mode-abbrev-table
    ()
  (define-abbrev-table 'policy-mode-abbrev-table ()))

(defvar policy-mode-map nil
  "The keymap that is used in policy mode.")

(if policy-mode-map
    ()
  (setq policy-mode-map (make-sparse-keymap))
  ;; set up the keymap
  (define-key policy-mode-map "\C-c:" 'policy-insert-target-ref)
  (define-key policy-mode-map "\C-c\C-c" 'comment-region)

  )


(defvar policy-mode-syntax-table nil)
(if policy-mode-syntax-table
    ()
  (setq policy-mode-syntax-table (make-syntax-table))
  (modify-syntax-entry ?\_ "w" policy-mode-syntax-table)
  (modify-syntax-entry ?\% "w" policy-mode-syntax-table)
  (modify-syntax-entry ?\( "()" policy-mode-syntax-table)
  (modify-syntax-entry ?\) ")(" policy-mode-syntax-table)
  (modify-syntax-entry ?\[ "(]" policy-mode-syntax-table)
  (modify-syntax-entry ?\] ")[" policy-mode-syntax-table)
  (modify-syntax-entry ?\{ "(}" policy-mode-syntax-table)
  (modify-syntax-entry ?\} "){" policy-mode-syntax-table)
  (modify-syntax-entry ?\< "(>" policy-mode-syntax-table)
  (modify-syntax-entry ?\> ")<" policy-mode-syntax-table)
  (modify-syntax-entry ?\` "('" policy-mode-syntax-table)
  (modify-syntax-entry ?\' ")`" policy-mode-syntax-table)
  (modify-syntax-entry ?#  "<" policy-mode-syntax-table)
  (modify-syntax-entry ?\n ">" policy-mode-syntax-table))


;;; ------------------------------------------------------------
;;; Internal variables.
;;; You don't need to configure below this line.
;;; ------------------------------------------------------------

(defvar policy-target-table nil
  "Table of all target names known for this buffer.")

(defvar policy-macro-table nil
  "Table of all macro names known for this buffer.")

(defvar policy-has-prereqs nil)
(defvar policy-mode-hook '())

;;; ------------------------------------------------------------
;;; The mode function itself.
;;; ------------------------------------------------------------

;;;###autoload
(defun policy-mode ()
  "Major mode for editing policys.
This function ends by invoking the function(s) `policy-mode-hook'.

\\{policy-mode-map}

policy mode can be configured by modifying the following variables:

"

  (interactive)
  (kill-all-local-variables)
  (make-local-variable 'local-write-file-hooks)
  (make-local-variable 'policy-target-table)
  (make-local-variable 'policy-macro-table)
  (make-local-variable 'policy-has-prereqs)

  ;; Font lock.
  (make-local-variable 'font-lock-defaults)
  (setq font-lock-defaults
	;; SYNTAX-BEGIN set to backward-paragraph to avoid slow-down
	;; near the end of a large buffer, due to parse-partial-sexp's
	;; trying to parse all the way till the beginning of buffer.
	'(policy-font-lock-keywords nil nil nil backward-paragraph))

  ;; Dabbrev.
  (make-local-variable 'dabbrev-abbrev-skip-leading-regexp)
  (setq dabbrev-abbrev-skip-leading-regexp "\\$")

  ;; Other abbrevs.
  (setq local-abbrev-table policy-mode-abbrev-table)

  ;; Filling.
  (make-local-variable 'fill-paragraph-function)
  (setq fill-paragraph-function 'policy-fill-paragraph)

  ;; Comment stuff.
  (make-local-variable 'comment-start)
  (setq comment-start "#")
  (make-local-variable 'comment-end)
  (setq comment-end "")
  (make-local-variable 'comment-start-skip)
  (setq comment-start-skip "#+[ \t]*")

  ;; become the current major mode
  (setq major-mode 'policy-mode)
  (setq mode-name "policy")

  ;; Activate keymap and syntax table.
  (use-local-map policy-mode-map)
  (set-syntax-table policy-mode-syntax-table)

  ;; Real TABs are important in policys
  (setq indent-tabs-mode t)
  (run-hooks 'policy-mode-hook))



;; Filling

(defun policy-fill-paragraph (arg)
  ;; Fill comments, backslashed lines, and variable definitions
  ;; specially.
  (save-excursion
    (beginning-of-line)
    (cond
     ((looking-at "^#+ ")
      ;; Found a comment.  Set the fill prefix and then fill.
      (let ((fill-prefix (buffer-substring-no-properties (match-beginning 0)
							 (match-end 0)))
	    (fill-paragraph-function nil))
	(fill-paragraph nil)
	t))

     ))
  ;; Always return non-nil so we don't fill anything else.
  t)


;;; ------------------------------------------------------------
;;; Continuation cleanup
;;; ------------------------------------------------------------

(defun policy-cleanup-continuations ()
  (if (eq major-mode 'policy-mode)
      (if (and policy-cleanup-continuations-p
	       (not buffer-read-only))
	  (save-excursion
	    (goto-char (point-min))
	    (while (re-search-forward "\\\\[ \t]+$" (point-max) t)
	      (replace-match "\\" t t))))))




;;; ------------------------------------------------------------
;;; Utility functions
;;; ------------------------------------------------------------


(defun policy-beginning-of-line-point ()
  (save-excursion
    (beginning-of-line)
    (point)))

(defun policy-end-of-line-point ()
  (save-excursion
    (end-of-line)
    (point)))

(defun policy-last-line-p ()
  (= (policy-end-of-line-point) (point-max)))

(defun policy-first-line-p ()
  (= (policy-beginning-of-line-point) (point-min)))



;;; policy.el ends here
