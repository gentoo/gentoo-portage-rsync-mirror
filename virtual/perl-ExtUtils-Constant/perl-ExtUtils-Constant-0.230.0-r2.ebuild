# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-ExtUtils-Constant/perl-ExtUtils-Constant-0.230.0-r2.ebuild,v 1.9 2014/01/20 21:00:01 vapier Exp $

DESCRIPTION="Virtual for ${PN#perl-}"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 arm64 hppa ~ppc ~ppc64 x86"
IUSE=""

RDEPEND="|| ( =dev-lang/perl-5.16* =dev-lang/perl-5.14* ~perl-core/${PN#perl-}-${PV} )"
