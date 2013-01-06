# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Pod-Simple/Pod-Simple-3.220.0.ebuild,v 1.1 2012/05/28 11:07:28 tove Exp $

EAPI=4

MODULE_AUTHOR=DWHEELER
MODULE_VERSION=3.22
inherit perl-module

DESCRIPTION="Framework for parsing Pod"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

DEPEND=">=virtual/perl-Pod-Escapes-1.04"
RDEPEND="${DEPEND}"

SRC_TEST="parallel"
