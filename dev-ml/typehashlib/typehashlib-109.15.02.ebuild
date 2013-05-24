# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/typehashlib/typehashlib-109.15.02.ebuild,v 1.1 2013/05/24 17:18:21 aballier Exp $

EAPI="5"

inherit oasis

MY_P=${PN/-/_}-${PV}
DESCRIPTION="Syntax extension for deriving 'typehash' functions automatically"
HOMEPAGE="http://www.janestreet.com/ocaml"
SRC_URI="http://ocaml.janestreet.com/ocaml-core/${PV}/individual/${MY_P}.tar.gz
	http://dev.gentoo.org/~aballier/distfiles/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-lang/ocaml-4.00.0:=
	>=dev-ml/type-conv-${PV}:="
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
