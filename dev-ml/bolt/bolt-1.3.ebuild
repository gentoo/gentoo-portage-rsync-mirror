# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/bolt/bolt-1.3.ebuild,v 1.1 2012/08/22 14:19:53 aballier Exp $

EAPI=4

inherit findlib

DESCRIPTION="Logging tool for the Objective Caml language"
HOMEPAGE="http://bolt.x9c.fr/"
SRC_URI="http://bolt.x9c.fr/distrib/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

DEPEND=">=dev-lang/ocaml-3.11[ocamlopt]"
RDEPEND="${DEPEND}"

src_configure() {
	sh configure
}

src_compile() {
	emake all
	use doc && emake doc
}

src_test() {
	emake tests
}

src_install() {
	findlib_src_install
	dodoc README CHANGES FEATURES
	use doc && dohtml ocamldoc/*
}
