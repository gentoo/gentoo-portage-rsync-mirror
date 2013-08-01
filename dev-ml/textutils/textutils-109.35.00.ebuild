# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/textutils/textutils-109.35.00.ebuild,v 1.1 2013/08/01 13:41:37 aballier Exp $

EAPI="5"

inherit oasis

DESCRIPTION="Text output utilities"
HOMEPAGE="https://ocaml.janestreet.com/"
SRC_URI="http://ocaml.janestreet.com/ocaml-core/${PV}/individual/${P}.tar.gz
	http://dev.gentoo.org/~aballier/distfiles/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	>=dev-ml/core-109.24.00:=
	>=dev-ml/pa_ounit-109.18.00:=
	>=dev-ml/sexplib-109.20.00:=
"
DEPEND="${RDEPEND}"
