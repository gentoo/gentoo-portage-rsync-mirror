# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/bin-prot/bin-prot-112.06.00.ebuild,v 1.1 2014/12/22 09:49:06 aballier Exp $

EAPI=5

OASIS_BUILD_TESTS=1
OASIS_BUILD_DOCS=1

inherit oasis

MY_P=${PN/-/_}-${PV}
DESCRIPTION="A binary protocol generator"
HOMEPAGE="http://ocaml.janestreet.com/?q=node/13"
SRC_URI="http://ocaml.janestreet.com/ocaml-core/${PV%.*}.00/individual/${MY_P}.tar.gz
	http://dev.gentoo.org/~aballier/distfiles/${MY_P}.tar.gz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="doc"

RDEPEND=">=dev-ml/type-conv-109.28.00:=
	dev-ml/camlp4:="
DEPEND="${RDEPEND}
	test? ( >=dev-ml/ounit-1.1.2 )"

DOCS=( "README.md" "CHANGES.md" )
S="${WORKDIR}/${MY_P}"
