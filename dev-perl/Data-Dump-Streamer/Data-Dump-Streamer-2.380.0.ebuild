# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Dump-Streamer/Data-Dump-Streamer-2.380.0.ebuild,v 1.1 2015/03/24 16:22:29 monsieurp Exp $

EAPI=5

MODULE_AUTHOR=YVES
MODULE_VERSION=2.38
inherit perl-module

DESCRIPTION="Accurately serialize a data structure as Perl code"

SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE="test"

RDEPEND=">=dev-perl/B-Utils-0.70.0
	virtual/perl-Carp
	virtual/perl-Data-Dumper
	virtual/perl-Exporter
	virtual/perl-IO
	virtual/perl-Text-Balanced
"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	virtual/perl-ExtUtils-CBuilder
	test? (
		virtual/perl-Test-Simple
		dev-perl/JSON-XS
	)
"

SRC_TEST=do

src_prepare() {
	# Add DDS.pm shortcut
	echo 'yes' > "${S}"/.answer
	perl-module_src_prepare
}
