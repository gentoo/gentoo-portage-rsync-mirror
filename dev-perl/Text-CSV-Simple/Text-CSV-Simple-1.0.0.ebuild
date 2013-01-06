# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-CSV-Simple/Text-CSV-Simple-1.0.0.ebuild,v 1.3 2012/09/01 11:57:58 grobian Exp $

EAPI=4

MODULE_AUTHOR=TMTM
MODULE_VERSION=1.00
inherit perl-module

DESCRIPTION="Text::CSV::Simple - Simpler parsing of CSV files"

SLOT="0"
LICENSE="|| ( GPL-3 GPL-2 )" # GPL-2+
KEYWORDS="amd64 ~x86 ~ppc-aix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
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
