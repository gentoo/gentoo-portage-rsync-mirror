# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libpri/libpri-1.4.12-r1.ebuild,v 1.3 2011/08/07 15:25:51 maekke Exp $

EAPI="3"

inherit base

MY_P="${P/_/-}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Primary Rate ISDN (PRI) library"
HOMEPAGE="http://www.asterisk.org/"
SRC_URI="http://downloads.asterisk.org/pub/telephony/${PN}/releases/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~sparc x86"
IUSE=""

PATCHES=(
	"${FILESDIR}/${PN}-1.4.12-multilib.patch"
	"${FILESDIR}/${PN}-1.4.12-respect-user-flags.patch"
)

src_install() {
	emake INSTALL_PREFIX="${D}" LIBDIR="${D}/usr/$(get_libdir)" install \
		|| die "emake install failed"

	dodoc ChangeLog README TODO || die "dodoc failed"
}
