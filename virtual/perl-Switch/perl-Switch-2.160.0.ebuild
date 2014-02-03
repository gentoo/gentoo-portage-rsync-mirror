# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Switch/perl-Switch-2.160.0.ebuild,v 1.6 2014/02/03 13:36:41 hattya Exp $

DESCRIPTION="Virtual for ${PN#perl-}"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 ~hppa ~ia64 ppc x86 ~x86-fbsd"
IUSE=""

RDEPEND="|| ( =dev-lang/perl-5.12* ~perl-core/${PN#perl-}-${PV} )"
