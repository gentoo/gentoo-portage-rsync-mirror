# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-threads/perl-threads-1.860.0-r1.ebuild,v 1.2 2012/12/22 18:27:47 ago Exp $

DESCRIPTION="Virtual for ${PN#perl-}"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="|| ( =dev-lang/perl-5.16* ~perl-core/${PN#perl-}-${PV} )"
