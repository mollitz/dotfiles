(define-coding-system-alias 'UTF-8 'utf-8)

(setq org-download-method 'attach)

;; For all programming modes
(add-hook 'prog-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))

(add-hook 'org-capture-mode-hook 'evil-insert-state)

;; only the third line works apparently...
;;(add-hook 'hack-local-variables-hook (lambda () (setq truncate-lines f)))
;;(spacemacs/toggle-truncate-lines-off)
(add-hook 'org-mode-hook #'spacemacs/toggle-truncate-lines-off)

(require 'org-agenda)
(define-key org-agenda-mode-map "i" 'org-agenda-clock-in)
(define-key org-agenda-mode-map "r" 'moritzs/org-process-inbox)
(define-key org-agenda-mode-map "R" 'org-agenda-refile)
(define-key org-agenda-mode-map "c" 'moritzs/org-inbox-capture)

(org-babel-do-load-languages
  'org-babel-load-languages
  '((ipython . t)
    ;; other languages..
    ))
(setq org-confirm-babel-evaluate nil)   ;don't prompt me to confirm everytime I want to evaluate a block

;;; display/update images in the buffer after I evaluate TODO don't know if this is necessary
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)
;; TODO this does not work because org-latex-minted-langs is not set or so..
;; (add-to-list 'org-latex-minted-langs '(ipython "python"))

;; add sketch to org file
(defun moritzs/org-download-sketch ()
  "Draw sketch and download it. Used tool is mypaint"
  (interactive)
  ;; We can use most of the objects from org-download
  (call-process-shell-command (format "rm %s" org-download-screenshot-file)
                              nil "*Shell Command Output*" t)
  (call-process-shell-command (format "/usr/bin/mypaint %s"
                                      org-download-screenshot-file)
                              nil "*Shell Command Output*" t
                              )
  (org-download-image org-download-screenshot-file))

(spacemacs/set-leader-keys
  "fd" 'moritzs/recent-download-file
  )
(spacemacs/set-leader-keys-for-major-mode 'org-mode
  "id" 'moritzs/org-download-sketch)

(spacemacs/set-leader-keys-for-major-mode 'org-mode
  "ip" 'moritzs/download-smartphone-photo)

;; auto org save buffers after refile.
(advice-add 'org-refile :after
            (lambda (&rest _)
              (org-save-all-org-buffers)))
(global-set-key (kbd "<left>") 'evil-window-left)
(global-set-key (kbd "<right>") 'evil-window-right)
(global-set-key (kbd "<up>") 'evil-window-up)
(global-set-key (kbd "<down>") 'evil-window-down)
(define-key evil-motion-state-map (kbd "<left>") 'evil-window-left)
(define-key evil-motion-state-map (kbd "<right>") 'evil-window-right)
(define-key evil-motion-state-map (kbd "<up>") 'evil-window-up)
(define-key evil-motion-state-map (kbd "<down>") 'evil-window-down)

(define-key evil-ex-completion-map [left] 'evil-backward-char)
(define-key evil-ex-completion-map [right] 'evil-forward-char)
(define-key evil-ex-search-keymap [left] 'evil-backward-char)
(define-key evil-ex-search-keymap [right] 'evil-forward-char)

(define-key minibuffer-local-map [up] 'evil-previous-line)
(define-key minibuffer-local-map [down] 'evil-next-line)
(define-key minibuffer-local-map [left] 'evil-backward-char)
(define-key minibuffer-local-map [right] 'evil-forward-char)

;; refine autocompletion behavior
(global-set-key (kbd "M-n") 'hippie-expand)
(global-set-key (kbd "M-n") 'yas-expand)

(use-package org
  :config
  (setq org-startup-indented t))
;; clipboard management
(setq x-select-enable-clipboard nil)
(define-key evil-insert-state-map  (kbd "C-v") (kbd "+"))
(define-key evil-ex-completion-map (kbd "C-v") (kbd "+"))
(define-key evil-ex-search-keymap  (kbd "C-v") (kbd "+"))

(eval-after-load "ansi-term"
  '(define-key ansi-term-raw-map (kbd "C-v") 'term-paste))

(defun org-archive-done-tasks ()
  (interactive)
  (org-map-entries
    (lambda ()
      (org-archive-subtree)
      (setq org-map-continue-from (outline-previous-heading)))
    "/DONE" 'tree))
(spacemacs/set-leader-keys "aoA" 'org-archive-done-tasks)

(add-hook 'ess-mode-hook
          (lambda ()
            (ess-toggle-underscore nil)))
  (require 'exec-path-from-shell)
  (exec-path-from-shell-copy-env "SSH_AGENT_PID")
  (exec-path-from-shell-copy-env "SSH_AUTH_SOCK")
  ;; TODO dont add projectile files...
  ;; (with-eval-after-load 'org-agenda
  ;;   (require 'org-projectile)
  ;;   (setq org-agenda-files (append org-agenda-files (org-projectile-todo-files)))
  ;;   )
  (defvar moritzs/new-project-template
    "
    *Project Purpose/Principles*:

    *Project Outcome*:
    "
    "Project template, inserted when a new project is created")

  (defvar moritzs/is-new-project nil
    "Boolean indicating whether it's during the creation of a new project")

  (defun moritzs/refile-new-child-advice (orig-fun parent-target child)
    (let ((res (funcall orig-fun parent-target child)))
      (save-excursion
        (find-file (nth 1 parent-target))
        (goto-char (org-find-exact-headline-in-buffer child))
        (org-add-note)
        )
      res))

  (advice-add 'org-refile-new-child :around #'moritzs/refile-new-child-advice)
  (defun moritzs/set-todo-state-next ()
    "Visit each parent task and change NEXT states to TODO"
    (org-todo "NEXT"))

  (add-hook 'org-clock-in-hook 'moritzs/set-todo-state-next 'append)
(setq org-agenda-block-separator nil)
(setq org-agenda-start-with-log-mode t)
(setq moritzs/org-agenda-todo-view
      `(" " "Agenda"
        ((agenda ""
                ((org-agenda-span 'day)
                  (org-deadline-warning-days 365)))
        (todo "TODO"
              ((org-agenda-overriding-header "To Refile")
                (org-agenda-files '("~/wiki/gtd/inbox.org"))))
        ;; (todo "TODO"
        ;;       ((org-agenda-overriding-header "Emails")
        ;;         (org-agenda-files '("~/wiki/gtd/emails.org")))) TODO add later..
        (todo "NEXT"
              ((org-agenda-overriding-header "In Progress")
                (org-agenda-files '("~/wiki/gtd/someday.org"
                                    "~/wiki/gtd/projects.org"
                                    "~/wiki/gtd/next.org"))
                ;; (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline 'scheduled))
                ))
        (todo "TODO"
              ((org-agenda-overriding-header "Projects")
                (org-agenda-files '("~/wiki/gtd/projects.org"))
                (org-agenda-skip-function #'moritzs/org-agenda-skip-all-siblings-but-first)))
        (todo "TODO"
              ((org-agenda-overriding-header "One-off Tasks")
                (org-agenda-files '("~/wiki/gtd/next.org"))
                (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline 'scheduled))))
        nil)))

(defun moritzs/org-agenda-skip-all-siblings-but-first ()
  "Skip all but the first non-done entry."
  (let (should-skip-entry)
    (unless (or (org-current-is-todo)
                (not (org-get-scheduled-time (point))))
      (setq should-skip-entry t))
    (save-excursion
      (while (and (not should-skip-entry) (org-goto-sibling t))
        (when (org-current-is-todo)
          (setq should-skip-entry t))))
    (when should-skip-entry
      (or (outline-next-heading)
          (goto-char (point-max))))))

(defun org-current-is-todo ()
  (string= "TODO" (org-get-todo-state)))

(defun moritzs/switch-to-agenda ()
  (interactive)
  (org-agenda nil " ")
  (delete-other-windows))

(bind-key "<f1>" 'moritzs/switch-to-agenda)
(setq org-columns-default-format "%40ITEM(Task) %Effort(EE){:} %CLOCKSUM(Time Spent) %SCHEDULED(Scheduled) %DEADLINE(Deadline)")
(setq org-agenda-custom-commands
    `(,moritzs/org-agenda-inbox-view
      ,moritzs/org-agenda-someday-view
      ,moritzs/org-agenda-todo-view
      ))

(defun moritzs/org-capture-hook ()
  (when (equal (buffer-name) "CAPTURE-receipts.org")
    (newline)
    (moritzs/download-smartphone-photo)
    ))

(add-hook 'org-capture-before-finalize-hook 'moritzs/org-capture-hook)