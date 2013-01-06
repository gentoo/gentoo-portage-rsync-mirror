# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/cvscommand/cvscommand-1.76.ebuild,v 1.3 2010/06/19 00:41:09 abcd Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: CVS integration plugin"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=90"
LICENSE="public-domain"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

VIM_PLUGIN_HELPFILES="cvscommand-contents"
# conflict, bug 62677
RDEPEND="dev-vcs/cvs
	!app-vim/calendar"
