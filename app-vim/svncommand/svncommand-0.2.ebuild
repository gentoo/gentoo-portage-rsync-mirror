# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/svncommand/svncommand-0.2.ebuild,v 1.5 2012/11/27 22:45:35 ulm Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: SVN (subversion) integration"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=922"
LICENSE="public-domain"
KEYWORDS="x86 sparc ~hppa ~amd64 alpha ia64"
IUSE=""

# vimspell map conflict, bug #91965
RDEPEND="${RDEPEND}
	dev-vcs/subversion
	!app-vim/vimspell"

VIM_PLUGIN_HELPURI="http://www.vim.org/scripts/script.php?script_id=922"
