# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-Refresh/Module-Refresh-0.170.0-r1.ebuild,v 1.1 2014/08/22 19:37:26 axs Exp $

EAPI=5

MODULE_AUTHOR=ALEXMV
MODULE_VERSION=0.17
inherit perl-module

DESCRIPTION="Refresh %INC files when updated on disk"

SLOT="0"
KEYWORDS="amd64 ~arm ppc x86"
IUSE="test"

RDEPEND=""
DEPEND="test? ( dev-perl/Path-Class )"

SRC_TEST="do"
