# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-CSV-Simple/Text-CSV-Simple-1.0.0.ebuild,v 1.4 2013/11/04 19:08:05 pinkbyte Exp $

EAPI=4

MODULE_AUTHOR=TMTM
MODULE_VERSION=1.00
inherit perl-module

DESCRIPTION="Text::CSV::Simple - Simpler parsing of CSV files"

SLOT="0"
LICENSE="|| ( GPL-3 GPL-2 )" # GPL-2+
KEYWORDS="amd64 ~arm ~mips ~x86 ~ppc-aix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE="test"

RDEPEND="dev-perl/Text-CSV_XS
	dev-perl/Class-Trigger
	dev-perl/File-Slurp"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST="do"
