# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-LibXSLT/XML-LibXSLT-1.760.0.ebuild,v 1.9 2012/09/30 18:42:28 armin76 Exp $

EAPI=4

MODULE_AUTHOR=SHLOMIF
MODULE_VERSION=1.76
inherit perl-module

DESCRIPTION="A Perl module to parse XSL Transformational sheets using gnome's libXSLT"

SLOT="0"
KEYWORDS="amd64 ~mips ppc ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND=">=dev-libs/libxslt-1.1.8
	>=dev-perl/XML-LibXML-1.70"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

SRC_TEST="do"
