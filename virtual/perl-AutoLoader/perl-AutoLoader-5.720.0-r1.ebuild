# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-AutoLoader/perl-AutoLoader-5.720.0-r1.ebuild,v 1.1 2012/05/21 11:50:36 tove Exp $

DESCRIPTION="Virtual for ${PN#perl-}"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-solaris"
IUSE=""

RDEPEND="|| ( =dev-lang/perl-5.16* ~perl-core/${PN#perl-}-${PV} )"
