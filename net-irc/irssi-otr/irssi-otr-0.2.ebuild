# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/irssi-otr/irssi-otr-0.2.ebuild,v 1.8 2013/06/01 14:42:58 creffett Exp $
EAPI=2

inherit cmake-utils eutils

DESCRIPTION="Off-The-Record messaging (OTR) for irssi"
HOMEPAGE="http://irssi-otr.tuxfamily.org"

# This should probably be exported by cmake-utils as a variable
CMAKE_BINARY_DIR="${WORKDIR}"/${PN}_build
mycmakeargs="-DDOCDIR=/usr/share/doc/${PF}"

SRC_URI="ftp://download.tuxfamily.org/irssiotr/${PF}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~sparc x86"
IUSE="debug"

RDEPEND="net-libs/libotr
	dev-libs/glib
	dev-libs/libgcrypt
	dev-libs/libgpg-error
	|| (
		net-irc/irssi
		net-irc/irssi-svn
	)"

DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4.7
	virtual/pkgconfig
	dev-lang/python"

src_install() {
	cmake-utils_src_install
	rm "${D}"/usr/share/doc/${PF}/LICENSE
	prepalldocs
}
