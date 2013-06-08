# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/esorex/esorex-3.10.ebuild,v 1.1 2013/06/07 23:38:01 bicatali Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=1
inherit autotools-utils

DESCRIPTION="ESO Recipe Execution Tool to exec cpl scripts"
HOMEPAGE="http://www.eso.org/sci/software/cpl/esorex.html"
SRC_URI="ftp://ftp.eso.org/pub/dfs/pipelines/libraries/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="examples"

DEPEND=">=sci-astronomy/cpl-6.3"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/${PN}-3.9.6-use-shared-libs.patch )

export CPLDIR="${EPREFIX}/usr"

src_install() {
	autotools-utils_src_install
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
