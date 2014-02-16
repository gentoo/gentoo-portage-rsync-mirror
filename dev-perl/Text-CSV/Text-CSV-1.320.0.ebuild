# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-CSV/Text-CSV-1.320.0.ebuild,v 1.3 2014/02/16 21:25:05 maekke Exp $

EAPI=4

MODULE_AUTHOR=MAKAMAKA
MODULE_VERSION=1.32
inherit perl-module

DESCRIPTION="Manipulate comma-separated value strings"

SLOT="0"
KEYWORDS="~alpha ~amd64 arm ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="test"

RDEPEND=""
DEPEND="test? ( dev-perl/Test-Pod )"

SRC_TEST=do
