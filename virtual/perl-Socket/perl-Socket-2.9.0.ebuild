# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Socket/perl-Socket-2.9.0.ebuild,v 1.4 2014/01/19 09:00:28 pacho Exp $

DESCRIPTION="Virtual for ${PN#perl-}"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 hppa ~ppc ~ppc64 x86"
IUSE=""

RDEPEND="|| ( =dev-lang/perl-5.18* ~perl-core/${PN#perl-}-${PV} )"
