# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ratpoison/ratpoison-1.4.5.ebuild,v 1.8 2010/08/16 19:44:59 abcd Exp $

EAPI=3

inherit autotools elisp-common eutils

DESCRIPTION="Ratpoison is an extremely light-weight and barebones wm modelled after screen"
HOMEPAGE="http://www.nongnu.org/ratpoison/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux"
IUSE="debug emacs +history +xft"

DEPEND="x11-libs/libXinerama
	x11-libs/libXtst
	virtual/perl-PodParser
	emacs? ( virtual/emacs )
	history? ( sys-libs/readline )
	xft? ( x11-libs/libXft )"
RDEPEND="${DEPEND}"

SITEFILE=50ratpoison-gentoo.el

src_prepare() {
	cd "${S}/contrib"
	epatch "${FILESDIR}/ratpoison.el-gentoo.patch"

	cd "${S}"
	epatch "${FILESDIR}/${PN}-1.4.4-glibc210.patch" \
		"${FILESDIR}/${P}-asneeded.patch"
	eautoreconf
}

src_configure() {
	local myconf
	use history || myconf="--disable-history"
	econf ${myconf} $(use_with xft) $(use_enable debug) || die "econf failed"
}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die "emake failed"
	if use emacs; then
		elisp-compile contrib/ratpoison.el || die "elisp-compile failed"
	fi
}

src_install() {
	einstall || die

	exeinto /etc/X11/Sessions
	newexe "${FILESDIR}"/ratpoison.xsession ratpoison || die

	insinto /usr/share/xsessions
	doins "${FILESDIR}"/${PN}.desktop || die

	dodoc INSTALL TODO README NEWS AUTHORS ChangeLog
	docinto example
	dodoc contrib/{genrpbindings,split.sh} \
		doc/{ipaq.ratpoisonrc,sample.ratpoisonrc}

	rm -rf "${ED}/usr/share/"{doc/ratpoison,ratpoison}

	if use emacs; then
		elisp-install ${PN} contrib/ratpoison.*
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
