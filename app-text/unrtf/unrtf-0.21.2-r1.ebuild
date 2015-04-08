# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/unrtf/unrtf-0.21.2-r1.ebuild,v 1.1 2013/06/15 11:59:13 grobian Exp $

EAPI="4"

inherit autotools eutils

DESCRIPTION="Converts RTF files to various formats"
HOMEPAGE="http://www.gnu.org/software/unrtf/unrtf.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-solaris"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/unrtf-0.21.1-automake-fix.patch
	sed -i \
		-e "s,/usr/local/lib/,${EPREFIX}/usr/share/,g" \
		"${S}"/src/*.h "${S}"/doc/${PN}.1 || die "failed to sed"
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.21.2-iconv-detection.patch
	eautoreconf
}

src_install() {
	default
	dodoc ChangeLog NEWS README AUTHORS
}
