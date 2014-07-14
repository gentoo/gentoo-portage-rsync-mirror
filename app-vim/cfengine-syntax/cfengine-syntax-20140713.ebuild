# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/cfengine-syntax/cfengine-syntax-20140713.ebuild,v 1.1 2014/07/14 18:41:45 radhermit Exp $

EAPI=5
inherit vim-plugin

DESCRIPTION="vim plugin: Cfengine configuration files syntax"
HOMEPAGE="http://dev.gentoo.org/~ramereth/vim/syntax/cfengine.vim"
LICENSE="vim.org"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"

VIM_PLUGIN_HELPTEXT=\
"This plugin provides syntax highlighting for Cfengine configuration
files. Detection is by filename (/var/cfengine/inputs/)."
