# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/unrtf/unrtf-0.21.1.ebuild,v 1.2 2010/03/09 11:19:14 grobian Exp $

inherit eutils autotools

DESCRIPTION="Converts RTF files to various formats"
HOMEPAGE="http://www.gnu.org/software/unrtf/unrtf.html"
SRC_URI="http://www.gnu.org/software/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/unrtf-0.21.1-automake-fix.patch
	sed -i \
		-e 's,/usr/local/lib/,/usr/share/,g' \
		"${S}"/src/*.h || die "failed to sed"
	cd "${S}"
	epatch "${FILESDIR}"/${P}-iconv-detection.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog NEWS README AUTHORS
}
