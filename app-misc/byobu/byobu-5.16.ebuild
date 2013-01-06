# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/byobu/byobu-5.16.ebuild,v 1.1 2012/03/13 06:46:20 radhermit Exp $

EAPI="4"
PYTHON_DEPEND="2"

inherit python

DESCRIPTION="A set of profiles for the GNU Screen console window manager (app-misc/screen)"
HOMEPAGE="https://launchpad.net/byobu"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P/-/_}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="screen"

RDEPEND="screen? ( app-misc/screen )
	!screen? ( app-misc/tmux )
	dev-libs/newt"

src_prepare() {
	python_convert_shebangs -r 2 .

	# Set default system backend to screen
	if use screen ; then
		sed -i -e 's/#\(BYOBU_BACKEND\).*/\1="screen"/' etc/byobu/backend || die
	fi
}

src_install() {
	emake DESTDIR="${D}" install

	# Create symlinks for backends
	dosym ${PN} /usr/bin/${PN}-screen
	dosym ${PN} /usr/bin/${PN}-tmux
}
