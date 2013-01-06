# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/reload/reload-0.6.8.ebuild,v 1.1 2012/08/03 22:01:29 radhermit Exp $

EAPI=4

inherit vim-plugin vcs-snapshot

DESCRIPTION="vim plugin: automatic reloading of vim scripts"
HOMEPAGE="http://peterodding.com/code/vim/reload/"
SRC_URI="https://github.com/xolox/vim-${PN}/tarball/${PV} -> ${P}.tar.gz"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-vim/xolox-misc"

VIM_PLUGIN_HELPFILES="${PN}.txt"

src_prepare() {
	rm INSTALL.md README.md || die
	rm -r autoload/xolox/misc || die
}
