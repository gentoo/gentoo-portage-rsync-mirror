# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-AutoLoader/perl-AutoLoader-5.730.0.ebuild,v 1.4 2014/07/05 11:27:05 dilfridge Exp $

DESCRIPTION="Virtual for ${PN#perl-}"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~x86-solaris"
IUSE=""

RDEPEND="|| ( =dev-lang/perl-5.18* ~perl-core/${PN#perl-}-${PV} )"
