# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/unrtf/unrtf-0.21.2.ebuild,v 1.1 2011/12/20 04:16:22 robbat2 Exp $

EAPI="4"

inherit autotools eutils

DESCRIPTION="Converts RTF files to various formats"
HOMEPAGE="http://www.gnu.org/software/unrtf/unrtf.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/unrtf-0.21.1-automake-fix.patch
	sed -i \
		-e 's,/usr/local/lib/,/usr/share/,g' \
		"${S}"/src/*.h || die "failed to sed"
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.21.2-iconv-detection.patch
	eautoreconf
}

src_install() {
	default
	dodoc ChangeLog NEWS README AUTHORS
}
