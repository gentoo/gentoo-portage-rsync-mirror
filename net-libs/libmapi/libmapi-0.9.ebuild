# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libmapi/libmapi-0.9.ebuild,v 1.1 2010/02/23 12:31:58 dagger Exp $

EAPI="2"

MY_PN=openchange
MY_P=${MY_PN}-${PV}-COCHRANE

DESCRIPTION="Portable open-source implementations of Exchange protocols."
HOMEPAGE="http://www.openchange.org/"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="python"

RDEPEND=">=net-fs/samba-4.0.0_alpha11
	dev-lang/python"

DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_configure() {
	ECONF="--disable-coverage
		--disable-swig-perl
		$(use_enable python pymapi)"

	econf ${ECONF}
}

src_compile() {
	emake libmapi || die "libmapi compilation failed"
	if use python ; then
		emake pymapi || die "pymapi compilation failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" libmapi-install || die "libmapi install failed"
	emake DESTDIR="${D}" libmapixx-install || die "libmapicxx install failed"

	if use python ; then
		emake DESTDIR="${D}" pymapi-install || die "pymapi install failed"
	fi
}
