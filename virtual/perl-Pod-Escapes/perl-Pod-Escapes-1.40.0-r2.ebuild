# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Pod-Escapes/perl-Pod-Escapes-1.40.0-r2.ebuild,v 1.3 2014/01/20 20:35:32 vapier Exp $

DESCRIPTION="Virtual for ${PN#perl-}"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

RDEPEND="|| ( =dev-lang/perl-5.16* =dev-lang/perl-5.14* ~dev-lang/perl-5.12.4 ~dev-lang/perl-5.12.3 ~dev-lang/perl-5.12.2 ~perl-core/${PN#perl-}-${PV}  )"
