# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libnatspec/libnatspec-0.2.6.ebuild,v 1.18 2014/01/19 10:09:39 vapier Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="library to smooth charset/localization issues"
HOMEPAGE="http://natspec.sourceforge.net/"
SRC_URI="mirror://sourceforge/natspec/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE="doc python"

RDEPEND="python? ( >=dev-lang/python-2.3 )
	dev-libs/popt"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	python? ( dev-lang/tcl )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-iconv.patch
	# regenerate to fix imcompatible readlink usage
	rm -f "${S}"/ltmain.sh "${S}"/libtool
	eautoreconf
}

src_configure() {
	use doc || export ac_cv_prog_DOX=no
	# braindead configure script does not disable python on --without-python
	econf $(use python && use_with python)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog NEWS README TODO
}
