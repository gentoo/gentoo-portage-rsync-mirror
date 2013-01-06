# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/notes/notes-0.16.17.ebuild,v 1.1 2012/08/03 22:17:29 radhermit Exp $

EAPI=4

inherit vim-plugin vcs-snapshot

DESCRIPTION="vim plugin: easy note taking in vim"
HOMEPAGE="http://peterodding.com/code/vim/notes/"
SRC_URI="https://github.com/xolox/vim-notes/tarball/${PV} -> ${P}.tar.gz"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-vim/xolox-misc-20111124
	|| ( dev-lang/python:2.7[sqlite] dev-lang/python:2.6[sqlite] )"

VIM_PLUGIN_HELPFILES="${PN}.txt"

src_prepare() {
	# remove unnecessary files
	rm INSTALL.md README.md misc/notes/user/README || die
	rm -r autoload/xolox/misc || die
}
