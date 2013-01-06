# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Module-Loaded/perl-Module-Loaded-0.80.0-r1.ebuild,v 1.2 2012/11/30 06:21:09 bicatali Exp $

DESCRIPTION="Virtual for ${PN#perl-}"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="|| ( =dev-lang/perl-5.16* ~perl-core/${PN#perl-}-${PV} )"
