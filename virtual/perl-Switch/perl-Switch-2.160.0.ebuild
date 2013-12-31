# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Switch/perl-Switch-2.160.0.ebuild,v 1.5 2013/12/30 08:02:27 naota Exp $

DESCRIPTION="Virtual for ${PN#perl-}"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 ~hppa ppc x86 ~x86-fbsd"
IUSE=""

RDEPEND="|| ( =dev-lang/perl-5.12* ~perl-core/${PN#perl-}-${PV} )"
