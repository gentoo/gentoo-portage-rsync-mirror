# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Dump-Streamer/Data-Dump-Streamer-2.330.0.ebuild,v 1.1 2012/04/06 12:28:34 tove Exp $

EAPI=4

MODULE_AUTHOR=YVES
MODULE_VERSION=2.33
inherit perl-module

DESCRIPTION="Accurately serialize a data structure as Perl code"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-perl/B-Utils-0.07"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		dev-perl/JSON-XS
	)
"

SRC_TEST=do

src_prepare() {
	# Add DDS.pm shortcut
	echo 'yes' > "${S}"/.answer
	perl-module_src_prepare
}
