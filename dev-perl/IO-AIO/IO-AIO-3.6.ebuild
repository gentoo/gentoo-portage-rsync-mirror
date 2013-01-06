# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-AIO/IO-AIO-3.6.ebuild,v 1.1 2010/03/27 21:35:33 robbat2 Exp $

inherit versionator
MODULE_AUTHOR="MLEHMANN"
MY_PV="$(get_major_version).$(delete_all_version_separators $(get_after_major_version))"
MY_P="${PN}-${MY_PV}"
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Asynchronous Input/Output"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~x86"

mydoc="Changes README"
SRC_TEST="do"

DEPEND="dev-perl/common-sense"
RDEPEND="${DEPEND}"
