# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/session/session-2.7.ebuild,v 1.1 2014/10/18 03:57:07 radhermit Exp $

EAPI=5

inherit vim-plugin

DESCRIPTION="vim plugin: extended session management for vim"
HOMEPAGE="http://peterodding.com/code/vim/session/"
SRC_URI="https://github.com/xolox/vim-${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"

VIM_PLUGIN_HELPFILES="${PN}.txt"

RDEPEND=">=app-vim/vim-misc-1.8.5"

S=${WORKDIR}/vim-${P}

src_prepare() {
	# remove unneeded files
	rm addon-info.json *.md || die
}
