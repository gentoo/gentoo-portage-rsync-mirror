# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Unicode-String/Unicode-String-2.90.0.ebuild,v 1.3 2012/12/05 11:35:28 grobian Exp $

EAPI=4

MODULE_AUTHOR=GAAS
MODULE_VERSION=2.09
inherit perl-module

DESCRIPTION="String manipulation for Unicode strings"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-linux"
IUSE=""

RDEPEND=">=virtual/perl-MIME-Base64-2.11"
DEPEND="${RDEPEND}"
