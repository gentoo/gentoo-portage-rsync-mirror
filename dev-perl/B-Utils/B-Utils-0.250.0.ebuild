# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/B-Utils/B-Utils-0.250.0.ebuild,v 1.2 2015/03/04 06:02:01 maekke Exp $

EAPI=5

MODULE_AUTHOR=JJORE
MODULE_VERSION=0.25
inherit perl-module

DESCRIPTION="Helper functions for op tree manipulation"

SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE="test"

RDEPEND="
	virtual/perl-Exporter
	virtual/perl-Scalar-List-Utils
	dev-perl/Task-Weaken
"
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-CBuilder
	>=dev-perl/extutils-depends-0.301.0
	test? (
		virtual/perl-Test-Simple
	)
"

SRC_TEST=do
