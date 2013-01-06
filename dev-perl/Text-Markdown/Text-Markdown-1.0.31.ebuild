# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Markdown/Text-Markdown-1.0.31.ebuild,v 1.1 2011/02/26 10:15:18 tove Exp $

EAPI=3

MODULE_AUTHOR=BOBTFISH
MODULE_VERSION=1.000031
inherit perl-module

DESCRIPTION="Convert MultiMarkdown syntax to (X)HTML"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="virtual/perl-Digest-MD5
	virtual/perl-Getopt-Long
	virtual/perl-Text-Balanced"

DEPEND="${RDEPEND}
	test? ( virtual/perl-Test-Simple
		dev-perl/Text-Diff
		dev-perl/List-MoreUtils
		dev-perl/Test-Differences
		dev-perl/Test-Exception )"
#		dev-perl/Test-Pod
#		dev-perl/Test-Pod-Coverage

SRC_TEST=do
mydoc="Readme.text Todo"
