# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Form/HTML-Form-6.30.0.ebuild,v 1.8 2012/09/02 18:08:54 armin76 Exp $

EAPI=4

MODULE_AUTHOR=GAAS
MODULE_VERSION=6.03
inherit perl-module

DESCRIPTION="Class that represents an HTML form element"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	!<dev-perl/libwww-perl-6
	>=dev-perl/HTTP-Message-6.30.0
	>=dev-perl/URI-1.10
	dev-perl/HTML-Parser
	>=virtual/perl-Encode-2
"
DEPEND="${RDEPEND}"
