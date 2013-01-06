# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclxml/tclxml-3.2-r1.ebuild,v 1.10 2011/03/27 19:46:03 ranger Exp $

EAPI="3"

inherit eutils multilib

DESCRIPTION="Pure Tcl implementation of an XML parser."
HOMEPAGE="http://tclxml.sourceforge.net/"
SRC_URI="mirror://sourceforge/tclxml/${P}.tar.gz"

IUSE="debug threads"
LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"

DEPEND="
	>=dev-lang/tcl-8.2
	dev-libs/libxslt
	>=dev-tcltk/tcllib-1.2
	>=dev-libs/libxml2-2.6.9
	dev-libs/expat
	!dev-tcltk/tcldom"
#	test? ( dev-tcltk/tclparser )
RDEPEND="${DEPEND}"

RESTRICT="test"

src_prepare() {
	epatch "${FILESDIR}"/"${P}"-fix-implicit-declarations.patch
}

src_configure() {
	local myconf=""

	use threads && myconf="${myconf} --enable-threads"

	econf ${myconf} \
		--with-xml2-config="${EPREFIX}"/usr/bin/xml2-config \
		--with-xslt-config="${EPREFIX}"/usr/bin/xslt-config \
		--with-tclinclude="${EPREFIX}"/usr/include \
		--with-tcl="${EPREFIX}"/usr/$(get_libdir) \
		$(use_enable amd64 64bit) \
		$(use_enable debug symbols)
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc ANNOUNCE ChangeLog || die
	dohtml doc/*.html || die
}
