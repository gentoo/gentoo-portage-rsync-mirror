# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/info/info-1.7-r1.ebuild,v 1.14 2005/04/24 03:25:30 hansmi Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: GNU info documentation browser"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=21"
LICENSE="BSD"
KEYWORDS="x86 alpha sparc ia64 ppc s390 amd64"
IUSE=""
DEPEND="${DEPEND} >=sys-apps/sed-4"

VIM_PLUGIN_HELPTEXT="This plugin adds the :Info command."

src_unpack() {
	unpack ${A}
	cd ${P}/plugin

	# The 'h' key is a bad choice for help.  'H' would have been a
	# much better choice.  I sent this suggestion to the maintainer,
	# but no reply.
	sed -i 's/\(noremap <buffer> \)h/\1H/' info.vim || die 'sed failed'
}
