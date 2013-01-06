# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/esorex/esorex-3.9.6-r1.ebuild,v 1.2 2012/08/05 17:28:46 bicatali Exp $

EAPI=4

AUTOTOOLS_AUTORECONF=1
inherit autotools-utils

DESCRIPTION="ESO Recipe Execution Tool to exec cpl scripts"
HOMEPAGE="http://www.eso.org/sci/software/cpl/esorex.html"
SRC_URI="ftp://ftp.eso.org/pub/dfs/pipelines/libraries/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="examples"

DEPEND=">=sci-astronomy/cpl-6"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-autoconf-26.patch
	"${FILESDIR}"/${P}-use-system-ltdl.patch
	"${FILESDIR}"/${P}-use-shared-libs.patch
	"${FILESDIR}"/${P}-set-default-plugin-path.patch
	"${FILESDIR}"/${P}-move-rcfile-to-etc.patch
)

export CPLDIR="${EPREFIX}/usr"

src_install() {
	autotools-utils_src_install
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
