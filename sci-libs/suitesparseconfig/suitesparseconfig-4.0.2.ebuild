# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/suitesparseconfig/suitesparseconfig-4.0.2.ebuild,v 1.2 2012/12/08 12:15:03 maekke Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="Common configurations for all packages in suitesparse"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/SuiteSparse_config"
SRC_URI="http://dev.gentoo.org/~bicatali/distfiles/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE="static-libs"

RDEPEND=""
DEPEND="${RDEPEND}"
