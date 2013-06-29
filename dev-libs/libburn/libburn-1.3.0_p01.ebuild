# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libburn/libburn-1.3.0_p01.ebuild,v 1.10 2013/06/29 16:32:56 ago Exp $

EAPI=5

MY_PL=01
[[ ${PV/_p} != ${PV} ]] && MY_PL=${PV#*_p}
MY_PV="${PV%_p*}.pl${MY_PL}"

DESCRIPTION="Libburn is an open-source library for reading, mastering and writing optical discs."
HOMEPAGE="http://libburnia-project.org"
SRC_URI="http://files.libburnia-project.org/releases/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc ~x86"
IUSE="cdio debug static-libs track-src-odirect"

RDEPEND="cdio? ( >=dev-libs/libcdio-0.83 )"
DEPEND="$RDEPEND
	virtual/pkgconfig"

S=${WORKDIR}/${P%_p*}

src_configure() {
	econf \
	$(use_enable static-libs static) \
	$(use_enable track-src-odirect) \
	--enable-pkg-check-modules \
	$(use_enable cdio libcdio) \
	--disable-ldconfig-at-install \
	$(use_enable debug)
}

src_install() {
	default

	dodoc CONTRIBUTORS doc/{comments,*.txt}

	docinto cdrskin
	dodoc cdrskin/{*.txt,README}
	docinto cdrskin/html
	dohtml cdrskin/cdrskin_eng.html

	find "${D}" -name '*.la' -exec rm -rf '{}' '+' || die "la removal failed"
}
