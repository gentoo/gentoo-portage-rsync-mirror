# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/core_extended/core_extended-109.11.00.ebuild,v 1.1 2013/03/06 16:38:31 aballier Exp $

EAPI="5"

OASIS_BUILD_DOCS=1
OASIS_BUILD_TESTS=1

inherit oasis

DESCRIPTION="Jane Street's alternative to the standard library"
HOMEPAGE="http://www.janestreet.com/ocaml"
SRC_URI="http://ocaml.janestreet.com/ocaml-core/${PV}/individual/${P}.tar.gz
	http://dev.gentoo.org/~aballier/distfiles/${P}.tar.gz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-ml/pcre-ocaml:=
	dev-ml/res:=
	>=dev-ml/core-${PV}:=
	>=dev-ml/sexplib-${PV}:=
	>=dev-ml/bin-prot-${PV}:=
	>=dev-ml/fieldslib-${PV}:=
	>=dev-ml/pa_ounit-${PV}:=
	>=dev-ml/variantslib-${PV}:=
	>=dev-ml/comparelib-${PV}:=
	>=dev-ml/pipebang-${PV}:="
DEPEND="${RDEPEND}
	test? ( >=dev-ml/ounit-1.1.0 )"
