# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/App-Nopaste/App-Nopaste-0.900.0.ebuild,v 1.2 2013/01/15 22:10:31 maekke Exp $

EAPI=4

MODULE_AUTHOR=SARTAK
MODULE_VERSION=0.90
inherit perl-module

DESCRIPTION="Easy access to any pastebin"

SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="+pastebin clipboard github"

DEPEND="
	dev-perl/Class-Load
	dev-perl/Getopt-Long-Descriptive
	dev-perl/JSON
	dev-perl/WWW-Mechanize
	virtual/perl-Module-Pluggable
	dev-perl/URI
	pastebin? (
		dev-perl/WWW-Pastebin-PastebinCom-Create
	)
	clipboard? (
		dev-perl/Clipboard
	)
	github? (
		dev-vcs/git[perl]
	)
"
#	github? (
#		|| (
#			dev-vcs/git[perl]
#			dev-perl/Config-GitLike
#		)
#	)
RDEPEND="${DEPEND}"
SRC_TEST="do"
