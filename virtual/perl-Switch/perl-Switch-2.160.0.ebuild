# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Switch/perl-Switch-2.160.0.ebuild,v 1.4 2013/10/28 19:52:46 jer Exp $

DESCRIPTION="Virtual for ${PN#perl-}"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 ~hppa ppc x86"
IUSE=""

RDEPEND="|| ( =dev-lang/perl-5.12* ~perl-core/${PN#perl-}-${PV} )"
