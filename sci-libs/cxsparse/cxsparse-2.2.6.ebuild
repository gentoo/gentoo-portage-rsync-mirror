# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cxsparse/cxsparse-2.2.6.ebuild,v 1.2 2012/10/16 02:31:53 naota Exp $

EAPI=4

AUTOTOOLS_AUTORECONF=yes
inherit autotools-utils

MY_PN=CXSparse

DESCRIPTION="Extended sparse matrix package."
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/CXSparse/"
SRC_URI="http://www.cise.ufl.edu/research/sparse/${MY_PN}/versions/${MY_PN}-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE="static-libs"

DEPEND="sci-libs/ufconfig"
RDEPEND=""

DOCS=( README.txt Doc/ChangeLog )
PATCHES=( "${FILESDIR}"/${PN}-2.2.2-autotools.patch )

S="${WORKDIR}/${MY_PN}"
