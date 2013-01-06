# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/swig/swig-1.3.40-r1.ebuild,v 1.15 2012/12/13 21:01:02 radhermit Exp $

EAPI="3"
DESCRIPTION="Simplified Wrapper and Interface Generator"
HOMEPAGE="http://www.swig.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD BSD-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~ppc-aix ~x86-fbsd ~ia64-hpux ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="ccache doc"
RESTRICT="test"
DEPEND=""
RDEPEND=""

src_prepare () {
	rm -v aclocal.m4 || die "Unable to remove aclocal.m4"
	./autogen.sh || die "Autogen script failed"
}

src_configure () {
	econf \
		$(use_enable ccache)
}

src_install() {
	emake DESTDIR="${D}" install || die "target install failed"
	dodoc ANNOUNCE CHANGES CHANGES.current FUTURE NEW README TODO || die "dodoc failed"
	if use doc; then
		dohtml -r Doc/{Devel,Manual} || die "Failed to install html documentation"
	fi
}
