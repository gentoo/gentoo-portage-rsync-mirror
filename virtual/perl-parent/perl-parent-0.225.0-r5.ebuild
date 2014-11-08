# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-parent/perl-parent-0.225.0-r5.ebuild,v 1.1 2014/11/08 17:17:16 dilfridge Exp $

EAPI=5

DESCRIPTION="Virtual for ${PN#perl-}"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ppc ppc64 s390 sh sparc x86 ~x86-freebsd ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND="
	|| ( =dev-lang/perl-5.18* ~perl-core/${PN#perl-}-${PV} )
	!<perl-core/${PN#perl-}-${PV}
	!>perl-core/${PN#perl-}-${PV}-r999
"
