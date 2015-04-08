# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/text-reform/text-reform-1.200.0-r1.ebuild,v 1.1 2014/08/21 19:35:48 axs Exp $

EAPI=5

MY_PN=Text-Reform
MODULE_AUTHOR=CHORNY
MODULE_VERSION=1.20
inherit perl-module

DESCRIPTION="Manual text wrapping and reformatting"

SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 s390 sparc x86 ~ppc-aix ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="test"

RDEPEND=""
DEPEND="virtual/perl-Module-Build
	test? ( dev-perl/Test-Pod )"

SRC_TEST=do
