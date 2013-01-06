# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-DB_File/perl-DB_File-1.826.0-r2.ebuild,v 1.1 2012/06/19 19:11:58 tove Exp $

EAPI=2

DESCRIPTION="Virtual for ${PN#perl-}"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

RDEPEND="|| ( =dev-lang/perl-5.16*[berkdb] ~perl-core/${PN#perl-}-${PV} )"
