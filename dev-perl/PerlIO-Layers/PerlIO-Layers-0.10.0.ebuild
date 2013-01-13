# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PerlIO-Layers/PerlIO-Layers-0.10.0.ebuild,v 1.2 2013/01/13 13:58:10 maekke Exp $

EAPI=4

MODULE_AUTHOR="LEONT"
MODULE_VERSION=0.010

inherit perl-module

DESCRIPTION="Querying your filehandle's capabilities"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND="dev-perl/List-MoreUtils"
DEPEND="${RDEPEND}"
