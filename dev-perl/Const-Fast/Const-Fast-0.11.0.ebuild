# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Const-Fast/Const-Fast-0.11.0.ebuild,v 1.1 2012/06/16 19:55:52 bicatali Exp $

EAPI=4

MODULE_AUTHOR="LEONT"
MODULE_VERSION=0.011

inherit perl-module

DESCRIPTION="Facility for creating read-only scalars, arrays, and hashes"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/Test-Exception
	dev-perl/Sub-Exporter"
