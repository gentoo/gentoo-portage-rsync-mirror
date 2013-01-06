# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocamldap/ocamldap-2.2.ebuild,v 1.1 2012/10/10 12:08:29 aballier Exp $

EAPI=4

inherit oasis

DESCRIPTION="an implementation of the Light Weight Directory Access Protocol"
HOMEPAGE="http://git-jpdeplaix.dyndns.org/libs/ocamldap.git/"
SRC_URI="http://bitbucket.org/deplai_j/${PN}/downloads/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

DEPEND="dev-ml/pcre-ocaml
	dev-ml/ocaml-ssl
	dev-ml/ocamlnet"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS.txt Changelog INSTALL.txt README.txt )

src_install() {
	oasis_src_install
	use doc && dohtml -r doc/ocamldap/html
}
