# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/core/core-109.23.00.ebuild,v 1.1 2013/05/24 16:50:40 aballier Exp $

EAPI="5"

OASIS_BUILD_DOCS=1
OASIS_BUILD_TESTS=1

inherit oasis

MY_P=${P/_/\~}
DESCRIPTION="Jane Street's alternative to the standard library"
HOMEPAGE="http://www.janestreet.com/ocaml"
SRC_URI="http://ocaml.janestreet.com/ocaml-core/${PV}/individual/${MY_P}.tar.gz
	http://dev.gentoo.org/~aballier/distfiles/${MY_P}.tar.gz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-ml/res:=
	>=dev-ml/sexplib-109.20.00:=
	>=dev-ml/bin-prot-109.15.00:=
	>=dev-ml/fieldslib-109.20.00:=
	>=dev-ml/pa_ounit-109.18.00:=
	>=dev-ml/variantslib-109.15.00:=
	>=dev-ml/comparelib-109.15.00:=
	>=dev-ml/herelib-109.15.00:=
	>=dev-ml/pipebang-109.15.00:="
DEPEND="${RDEPEND}
	test? ( >=dev-ml/ounit-1.1.2 )"
