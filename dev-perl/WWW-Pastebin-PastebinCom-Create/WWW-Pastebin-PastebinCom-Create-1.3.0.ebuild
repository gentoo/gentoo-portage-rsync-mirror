# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WWW-Pastebin-PastebinCom-Create/WWW-Pastebin-PastebinCom-Create-1.3.0.ebuild,v 1.2 2015/04/02 10:23:31 zlogene Exp $

EAPI=5

MODULE_AUTHOR=ZOFFIX
MODULE_VERSION=1.003
inherit perl-module

DESCRIPTION="Paste on www.pastebin.com without API keys"

SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE="test"

RDEPEND="
	>=dev-perl/Moo-1.4.1
	>=dev-perl/WWW-Mechanize-1.730.0
"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		virtual/perl-Test-Simple
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)
"

SRC_TEST="do"
