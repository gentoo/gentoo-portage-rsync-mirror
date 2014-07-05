# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Data-Dumper/perl-Data-Dumper-2.151.0.ebuild,v 1.1 2014/07/05 21:54:46 dilfridge Exp $

EAPI=5

DESCRIPTION="Virtual for ${PN#perl-}"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="|| ( =dev-lang/perl-5.20* ~perl-core/${PN#perl-}-${PV} )"
