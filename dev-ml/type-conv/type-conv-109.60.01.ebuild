# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/type-conv/type-conv-109.60.01.ebuild,v 1.1 2014/02/13 12:34:47 aballier Exp $

EAPI="5"

OASIS_BUILD_DOCS=1

inherit oasis

MY_P=${PN/-/_}-${PV}
DESCRIPTION="Mini library required for some other preprocessing libraries"
HOMEPAGE="http://bitbucket.org/yminsky/ocaml-core/wiki/Home"
SRC_URI="http://ocaml.janestreet.com/ocaml-core/${PV%.*}.00/individual/${MY_P}.tar.gz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	>=dev-lang/ocaml-4.0[ocamlopt?]
	>=dev-ml/findlib-1.3.2"

DOCS=( "README.md" "CHANGES.txt" )

S="${WORKDIR}/${MY_P}"
