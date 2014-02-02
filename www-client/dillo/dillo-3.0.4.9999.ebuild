# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/dillo/dillo-3.0.4.9999.ebuild,v 1.1 2014/02/02 19:52:52 jer Exp $

EAPI=5
inherit autotools eutils flag-o-matic mercurial multilib toolchain-funcs

DESCRIPTION="Lean FLTK based web browser"
HOMEPAGE="http://www.dillo.org/"
EHG_REPO_URI="http://hg.dillo.org/dillo"
SRC_URI="mirror://gentoo/${PN}.png"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="doc +gif ipv6 +jpeg +png ssl"

RDEPEND="sys-libs/zlib
	>=x11-libs/fltk-1.3:1[-cairo]
	jpeg? ( virtual/jpeg )
	png? ( >=media-libs/libpng-1.2:0 )
	ssl? ( dev-libs/openssl:0 )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}2-inbuf.patch
	eautoreconf
}

src_configure() {
	append-ldflags "-L/usr/$(get_libdir)/fltk"

	econf  \
		$(use_enable gif) \
		$(use_enable ipv6) \
		$(use_enable jpeg) \
		$(use_enable png) \
		$(use_enable ssl) \
		--docdir="/usr/share/doc/${PF}"
}

src_compile() {
	emake AR=$(tc-getAR)
	if use doc; then
		doxygen Doxyfile || die
	fi
}

src_install() {
	dodir /etc
	default

	use doc && dohtml html/*
	dodoc AUTHORS ChangeLog README NEWS
	dodoc doc/*.txt doc/README

	doicon "${DISTDIR}"/${PN}.png
	make_desktop_entry ${PN} Dillo
}

pkg_postinst() {
	elog "Dillo has installed a default configuration into /etc/dillo/dillorc"
	elog "You can copy this to ~/.dillo/ and customize it"
}
