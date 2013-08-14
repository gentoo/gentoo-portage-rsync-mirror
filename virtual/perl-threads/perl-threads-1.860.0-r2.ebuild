# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-threads/perl-threads-1.860.0-r2.ebuild,v 1.1 2013/08/14 05:39:34 patrick Exp $

DESCRIPTION="Virtual for ${PN#perl-}"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="|| ( =dev-lang/perl-5.18* =dev-lang/perl-5.16* ~perl-core/${PN#perl-}-${PV} )"
