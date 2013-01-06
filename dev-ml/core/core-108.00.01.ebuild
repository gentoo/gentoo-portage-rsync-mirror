# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/core/core-108.00.01.ebuild,v 1.2 2012/07/09 20:52:33 ulm Exp $

EAPI="3"

OASIS_BUILD_DOCS=1
OASIS_BUILD_TESTS=1

inherit oasis base

MY_P=${P/_/\~}
DESCRIPTION="Jane Street's alternative to the standard library"
HOMEPAGE="http://www.janestreet.com/ocaml"
SRC_URI="http://bitbucket.org/yminsky/ocaml-core/downloads/${P}.tar.gz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="dev-ml/res
	>=dev-ml/sexplib-108.00.01
	>=dev-ml/bin-prot-108.00.01
	>=dev-ml/fieldslib-108.00.01
	>=dev-ml/pa_ounit-108.00.01
	>=dev-ml/variantslib-108.00.01
	>=dev-ml/pipebang-108.00.01"
DEPEND="${RDEPEND}
	>=dev-ml/oasis-0.3
	test? ( >=dev-ml/ounit-1.0.2 )"

PATCHES=( "${FILESDIR}/${P}-nocust.patch" "${FILESDIR}/${P}-noinl.patch" )

src_prepare() {
	base_src_prepare
	oasis setup || die
}
