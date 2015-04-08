# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/irssi-otr/irssi-otr-0.3-r1.ebuild,v 1.5 2014/11/28 13:34:03 pacho Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} )
inherit cmake-utils python-any-r1

DESCRIPTION="Off-The-Record messaging (OTR) for irssi"
HOMEPAGE="http://irssi-otr.tuxfamily.org"
SRC_URI="ftp://download.tuxfamily.org/irssiotr/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"
IUSE="debug"

RDEPEND="<net-libs/libotr-4
	dev-libs/glib:2
	dev-libs/libgcrypt:0
	dev-libs/libgpg-error
	net-irc/irssi"

DEPEND="${PYTHON_DEPS}
	${RDEPEND}
	virtual/pkgconfig"

DOCS=( README )

src_prepare() {
	# do not install docs through buildsystem
	sed -i -e '/README LICENSE/d' CMakeLists.txt || die 'sed on CMakeLists.txt failed'

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DDOCDIR="/usr/share/doc/${PF}"
	)
	cmake-utils_src_configure
}
