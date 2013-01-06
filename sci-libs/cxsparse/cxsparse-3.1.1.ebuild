# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cxsparse/cxsparse-3.1.1.ebuild,v 1.2 2012/11/12 02:02:11 bicatali Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="Extended sparse matrix package"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/CXSparse/"
SRC_URI="http://dev.gentoo.org/~bicatali/distfiles/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-fbsd ~x86-linux ~x86-macos"
IUSE="static-libs"

RDEPEND="sci-libs/suitesparseconfig"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
