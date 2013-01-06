# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/session/session-1.5.ebuild,v 1.1 2012/08/03 22:10:50 radhermit Exp $

EAPI=4

inherit vim-plugin vcs-snapshot

DESCRIPTION="vim plugin: extended session management for vim"
HOMEPAGE="http://peterodding.com/code/vim/session/"
SRC_URI="https://github.com/xolox/vim-session/tarball/${PV} -> ${P}.tar.gz"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""

VIM_PLUGIN_HELPFILES="${PN}.txt"

RDEPEND=">=app-vim/xolox-misc-20111124"

src_prepare() {
	# remove unneeded files
	rm *.md || die
	rm -r autoload/xolox/misc || die
}
