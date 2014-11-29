# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/textutils/textutils-109.53.03.ebuild,v 1.2 2014/11/28 18:06:01 aballier Exp $

EAPI="5"

inherit oasis

DESCRIPTION="Text output utilities"
HOMEPAGE="https://ocaml.janestreet.com/"
SRC_URI="http://ocaml.janestreet.com/ocaml-core/${PV%.*}.00/individual/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	>=dev-ml/core-109.24.00:=
	>=dev-ml/pa_ounit-109.18.00:=
	>=dev-ml/sexplib-109.20.00:=
	dev-ml/async:=
	|| ( dev-ml/camlp4:= <dev-lang/ocaml-4.02.0 )
"
DEPEND="${RDEPEND}"
