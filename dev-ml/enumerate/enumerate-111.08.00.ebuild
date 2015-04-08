# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/enumerate/enumerate-111.08.00.ebuild,v 1.3 2014/11/10 07:44:51 aballier Exp $

EAPI="5"

inherit oasis

MY_P=${PN/-/_}-${PV}
DESCRIPTION="Syntax extension to produce a list of all values of a type"
HOMEPAGE="http://www.janestreet.com/ocaml"
SRC_URI="http://ocaml.janestreet.com/ocaml-core/${PV%.*}.00/individual/${MY_P}.tar.gz
	http://dev.gentoo.org/~aballier/distfiles/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=dev-ml/type-conv-111.13:=
	|| ( dev-ml/camlp4:= <dev-lang/ocaml-4.02.0 )"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
DOCS=( README.md )
