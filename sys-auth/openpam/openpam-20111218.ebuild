# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/openpam/openpam-20111218.ebuild,v 1.4 2012/05/24 05:04:52 vapier Exp $

EAPI="2"
# https://bugs.gentoo.org/show_bug.cgi?id=318121
WANT_AUTOMAKE=1.9
inherit multilib autotools eutils libtool

DESCRIPTION="Open source PAM library."
HOMEPAGE="http://www.openpam.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
IUSE="debug vim-syntax"

RDEPEND="!sys-libs/pam"
DEPEND="sys-devel/make
	dev-lang/perl"
PDEPEND="sys-auth/pambase
	vim-syntax? ( app-vim/pam-syntax )"

src_prepare() {
	epatch "${FILESDIR}/${PN}-20071221-gentoo.patch"
	epatch "${FILESDIR}/${PN}-20050201-nbsd.patch"
	epatch "${FILESDIR}/${PN}-20111218-nomajor.patch"

	sed -i -e 's:-Werror::' "${S}/configure.ac"

	mkdir "${S}/m4" # Otherwise aclocal fails since ACLOCAL_AMFLAGS is set in Makefile.am
	eautoreconf
	elibtoolize
}

src_configure() {
	econf ${myconf} \
		--disable-dependency-tracking \
		--with-modules-dir=/$(get_libdir)/security/
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die
	dodoc CREDITS HISTORY RELNOTES README || die

	find "${D}" -name '*.la' -delete || die
}
