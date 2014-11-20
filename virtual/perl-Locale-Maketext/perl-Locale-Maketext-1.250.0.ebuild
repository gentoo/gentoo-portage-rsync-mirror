# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Locale-Maketext/perl-Locale-Maketext-1.250.0.ebuild,v 1.2 2014/11/20 13:55:02 blueness Exp $

EAPI=5

DESCRIPTION="Virtual for ${PN#perl-}"
HOMEPAGE=""
SRC_URI=""

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd"
IUSE=""

RDEPEND="
	|| ( =dev-lang/perl-5.20* ~perl-core/Locale-Maketext-${PV} )
	!<perl-core/Locale-Maketext-${PV}
	!>perl-core/Locale-Maketext-${PV}-r999
"
