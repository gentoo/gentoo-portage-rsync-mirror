# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocaml-augeas/ocaml-augeas-0.4.ebuild,v 1.1 2009/02/24 15:49:38 matsuu Exp $

inherit findlib

DESCRIPTION="Ocaml bindings for Augeas"
HOMEPAGE="http://augeas.net/"
SRC_URI="http://augeas.net/download/ocaml/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-admin/augeas"
RDEPEND="${DEPEND}"

src_compile() {
	econf || die
	# parallel make b0rked
	emake -j1 || die
}

src_install() {
	findlib_src_install
}
