# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-ExtUtils-Manifest/perl-ExtUtils-Manifest-1.580.0-r1.ebuild,v 1.4 2013/01/06 12:04:08 armin76 Exp $

DESCRIPTION="Virtual for ${PN#perl-}"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ~ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="|| ( =dev-lang/perl-5.14* ~perl-core/${PN#perl-}-${PV} )"
