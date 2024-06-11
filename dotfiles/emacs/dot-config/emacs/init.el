(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)

(set-fringe-mode 15)

(defun hook-hide-line-numbers()
  (display-line-numbers-mode 0))
(column-number-mode)
(global-display-line-numbers-mode t)
(setq display-line-numbers 'relative)
(dolist (mode '(term-mode-hook
                eshell-mode-hook
                shell-mode-hook
                org-mode-hook))
  (add-hook mode #'hook-hide-line-numbers))

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme `doom-plain-dark t)
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package simpleclip
  :config
  (simpleclip-mode 1))

(use-package swiper)

  (use-package counsel
    :bind (("M-x" . counsel-M-x)
           ("C-x b" . counsel-ibuffer)
           ("C-x C-f" . counsel-find-file)
           :map minibuffer-local-map
           ("C-r" . counsel-minibuffer-history))
    :config
    (setq ivy-initial-inputs-alist nil)) ;;dont start searches with ^

  (use-package ivy
    :bind (("C-s" . swiper)
           :map ivy-minibuffer-map
           ("TAB" . ivy-alt-done)
           ("C-l" . ivy-alt-done)
           ("C-j" . ivy-next-line)
           ("C-k" . ivy-previous-line)
           :map ivy-switch-buffer-map
           ("C-k" . ivy-previous-line)
           ("C-l" . ivy-done)
           ("C-d" . ivy-switch-buffer-kill)
           :map ivy-reverse-i-search-map
           ("C-k" . ivy-previous-line)
           ("C-d" . ivy-reverse-i-search-kill))
    :config
    (ivy-mode 1))


(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t) ;; doesnt work?
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)

  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package general
  :config
  (general-evil-setup t)
  (general-create-definer jon/leader
                          :keymaps '(normal insert visual emacs)
                          :prefix "SPC"
                          :global-prefix "C-SPC")
  (jon/leader
    "o" '(:ignore t :which-key "org-mode")
    "oa" '(org-agenda :which-key "org-agenda")
    "oc" '(org-capture :which-key "org-capture")))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(defun jon/org-mode-setup ()
  (org-indent-mode)
  (visual-line-mode 1))

(use-package org
  :hook (org-mode . jon/org-mode-setup)
  :config

  ;; save org buffers on refile
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  (setq org-habit-graph-column 60)

  (setq org-agenda-start-with-log-mode t)
  (setq org-long-done 'time)
  (setq org-log-into-drawer t)

  ;; cmon
  (setq org-read-date-force-compatible-dates nil)

  (setq org-tag-alist
        '((:startgroup)
          ;; @ location tags
          ("@errand" . ?E)
          ("@home" . ?H)
          ("@dad" . ?D)
          (:endgroup)
          ;; categories
          ("finances" . ?f) ;; financial stuff
          ("chore" . ?c)    ;; routine chores
          ("house" . ?h)    ;; house-specific things
          ("health" .?l)    ;; health-care related
          ("agenda" . ?a)
          ("note" . ?n)
          ("idea" . ?i)
          ("recurring" . ?r)))

  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")))

  (setq org-agenda-files
        '("~/org/"))
  (setq org-capture-templates
        '(("t" "Tasks")
          ("tt" "Task" entry (file+olp "~/org/todo.org" "Inbox")
           "* TODO %?\n  %U\n  %a\n" :empty-lines 1)
          ("tb" "Task with backlink" entry (file+olp "~/org/todo.org" "Inbox")
           "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)
          ("j" "Journal Entries")
          ("jj" "Journal" entry
           (file+olp+datetree "~/org/journal.org")
           "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
           :clock-in :clock-resume
           :empty-lines 1)
          ("n" "Note" entry (file+headline "~/org/notes.org" "Random Notes")
           "** %?" :empty-lines 0 :kill-buffer t)
          ("m" "Metrics")
          ("mw" "Weight" table-line (file+headline "~/org/metrics.org" "Weight")
           "| %U | %^{Weight} | %^{Notes} |" :kill-buffer t)
          ("mp" "Blood Pressure" table-line (file+headline "~/org/metrics.org" "Blood Pressure")
           "| %U | %^{Sys} | %^{Dia} | %^{Notes} |" :kill-buffer t))))

(with-eval-after-load 'org
  (org-babel-do-load-languages
      'org-babel-load-languages
      '((emacs-lisp . t)
      (python . t)
      (shell . t)
      (haskell . t)))

  (require 'org-tempo)

  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("hs" . "src haskell")))
;(push '("conf-unix" . conf-unix) org-src-lang-modes)

(defun jon/org-babel-tangle-config ()
  (when (equal (file-name-directory (directory-file-name buffer-file-name))
               (concat (getenv "HOME") "/config/"))
  (let ((org-confirm-babel-evaluate nil))
    (org-babel-tangle))))

  (add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'jon/org-babel-tangle-config)))

(defun jon/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :defer t
  :hook (org-mode . jon/org-mode-visual-fill))

(use-package magit)

(use-package vundo)

(use-package doom-modeline
  :init (doom-modeline-mode 1))

(setq doom-modeline-height 1) ; optional
(custom-set-faces
  '(mode-line ((t (:family "Fira Code Nerd Font" :height 0.9))))
  '(mode-line-active ((t (:family "Fira Code Nerd Font" :height 0.9)))) ; For 29+
  '(mode-line-inactive ((t (:family "Fira Code Nerd Font" :height 0.9)))))


(setq nerd-icons-scale-factor 0.9)

(set-face-attribute 'default nil :font "FiraCode Nerd Font" :height 100)
