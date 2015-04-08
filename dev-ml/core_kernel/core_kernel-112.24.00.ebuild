# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/core_kernel/core_kernel-112.24.00.ebuild,v 1.1 2015/03/18 17:16:42 aballier Exp $

EAPI="5"

OASIS_BUILD_DOCS=1
OASIS_BUILD_TESTS=1

inherit oasis

DESCRIPTION="System-independent part of Core"
HOMEPAGE="http://www.janestreet.com/ocaml"
SRC_URI="http://ocaml.janestreet.com/ocaml-core/${PV%.*}/files/${P%.*}.tar.gz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	>=dev-ml/bin-prot-112.17.00:=
	>=dev-ml/comparelib-109.27.00:=
	>=dev-ml/fieldslib-109.20.00:=
	>=dev-ml/herelib-109.35.00:=
	>=dev-ml/pa_ounit-109.27.00:=
	>=dev-ml/pipebang-109.15.00:=
	>=dev-ml/sexplib-109.20.00:=
	>=dev-ml/variantslib-109.15.00:=
	dev-ml/pa_test:=
	dev-ml/enumerate:=
	dev-ml/pa_bench:=
	>=dev-ml/typerep-111.17:=
	dev-ml/camlp4:=
	!dev-ml/zero
	"
DEPEND="${RDEPEND}
	test? (
		dev-ml/pa_ounit
		>=dev-ml/core-109.60.00
	)"
DOCS=( "README.md" )
