# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/core/core-108.07.01.ebuild,v 1.2 2012/10/17 12:13:23 aballier Exp $

EAPI="3"

OASIS_BUILD_DOCS=1
OASIS_BUILD_TESTS=1

inherit oasis base

MY_P=${P/_/\~}
DESCRIPTION="Jane Street's alternative to the standard library"
HOMEPAGE="http://www.janestreet.com/ocaml"
SRC_URI="http://ocaml.janestreet.com/ocaml-core/${PV}/individual/${MY_P}.tar.gz
	http://dev.gentoo.org/~aballier/distfiles/${MY_P}.tar.gz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="dev-ml/res
	>=dev-ml/sexplib-108.07.01
	>=dev-ml/bin-prot-108.07.01
	>=dev-ml/fieldslib-108.07.01
	>=dev-ml/pa_ounit-108.07.01
	>=dev-ml/variantslib-108.07.01
	>=dev-ml/comparelib-108.07.01
	>=dev-ml/pipebang-108.07.01"
DEPEND="${RDEPEND}
	test? ( >=dev-ml/ounit-1.1.2 )"
