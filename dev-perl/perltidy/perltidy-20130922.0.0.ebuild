# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perltidy/perltidy-20130922.0.0.ebuild,v 1.2 2014/03/12 16:54:35 zlogene Exp $

EAPI=5

MY_PN=Perl-Tidy
MODULE_AUTHOR=SHANCOCK
MODULE_VERSION=20130922
inherit perl-module

DESCRIPTION="Perl script indenter and beautifier"
HOMEPAGE="http://perltidy.sourceforge.net/ ${HOMEPAGE}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

SRC_TEST="do"

src_prepare() {
	epatch "${FILESDIR}/${P}-CVE-2014-2277.patch"
}

src_install() {
	perl-module_src_install
	docinto examples
	dodoc "${S}"/examples/*
}
