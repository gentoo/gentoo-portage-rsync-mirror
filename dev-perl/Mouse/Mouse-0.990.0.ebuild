# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mouse/Mouse-0.990.0.ebuild,v 1.1 2012/07/03 18:14:03 tove Exp $

EAPI=4

MODULE_AUTHOR=GFUJI
MODULE_VERSION=0.99
inherit eutils perl-module

DESCRIPTION="Moose minus the antlers"
SRC_URI+=" mirror://gentoo/Mouse-0.64-ppport.h.bz2"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86 ~ppc-macos"
IUSE="test"

RDEPEND="virtual/perl-XSLoader"
DEPEND=">=virtual/perl-ExtUtils-ParseXS-2.21
	test? ( dev-perl/Sub-Uplevel
		>=virtual/perl-Test-Simple-0.88 )"

src_prepare() {
	perl-module_src_prepare
	epatch "${FILESDIR}"/0.64-ppport.patch
	mv "${WORKDIR}"/Mouse-0.64-ppport.h "${S}"/ppport.h || die
}

SRC_TEST=do
