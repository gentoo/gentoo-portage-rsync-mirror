# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PerlIO-Layers/PerlIO-Layers-0.10.0.ebuild,v 1.1 2012/06/16 19:52:48 bicatali Exp $

EAPI=4

MODULE_AUTHOR="LEONT"
MODULE_VERSION=0.010

inherit perl-module

DESCRIPTION="Querying your filehandle's capabilities"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/List-MoreUtils"
DEPEND="${RDEPEND}"
