# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/typerep/typerep-112.24.00.ebuild,v 1.1 2015/03/18 17:07:51 aballier Exp $

EAPI="5"

inherit oasis

MY_P=${PN/-/_}-${PV}
DESCRIPTION="Library for creating runtime representation of OCaml types"
HOMEPAGE="http://www.janestreet.com/ocaml"
SRC_URI="http://ocaml.janestreet.com/ocaml-core/${PV%.*}/files/${MY_P%.*}.tar.gz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=dev-ml/type-conv-111.13:=
	dev-ml/camlp4:="

RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
