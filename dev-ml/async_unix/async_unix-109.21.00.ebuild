# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/async_unix/async_unix-109.21.00.ebuild,v 1.1 2013/05/24 17:09:20 aballier Exp $

EAPI="5"

OASIS_BUILD_DOCS=1

inherit oasis

MY_P=${PN/-/_}-${PV}
DESCRIPTION="Jane Street Capital's asynchronous execution library (unix)"
HOMEPAGE="http://www.janestreet.com/ocaml"
SRC_URI="http://ocaml.janestreet.com/ocaml-core/${PV}/individual/${MY_P}.tar.gz
	http://dev.gentoo.org/~aballier/distfiles/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-lang/ocaml-4.00.0:=
	>=dev-ml/bin-prot-109.15.00:=
	>=dev-ml/comparelib-109.15.00:=
	>=dev-ml/herelib-109.15.00:=
	>=dev-ml/pa_ounit-109.18.00:=
	>=dev-ml/pipebang-109.15.00:=
	>=dev-ml/core-109.21.00:=
	>=dev-ml/async_core-109.20.00:=
	>=dev-ml/sexplib-109.20.00:=
	>=dev-ml/fieldslib-109.20.00:=
	"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
