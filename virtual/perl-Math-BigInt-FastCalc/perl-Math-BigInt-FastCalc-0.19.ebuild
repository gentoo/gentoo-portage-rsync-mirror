# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Math-BigInt-FastCalc/perl-Math-BigInt-FastCalc-0.19.ebuild,v 1.12 2011/06/28 19:55:09 tove Exp $

DESCRIPTION="Math::BigInt::Calc with some XS for more speed"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 hppa ppc x86"

IUSE=""
DEPEND=""

RDEPEND="|| ( ~dev-lang/perl-5.12.4 ~dev-lang/perl-5.12.3 ~dev-lang/perl-5.12.2 ~dev-lang/perl-5.10.1 ~perl-core/Math-BigInt-FastCalc-${PV} )"
