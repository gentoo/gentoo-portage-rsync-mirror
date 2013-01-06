# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocamldap/ocamldap-2.1.8.ebuild,v 1.1 2012/09/15 15:13:57 aballier Exp $

EAPI=4

inherit findlib

DESCRIPTION="ldap server and client library for Ocaml"
HOMEPAGE="http://sourceforge.net/projects/ocamldap/"
SRC_URI="mirror://sourceforge/project/${PN}/${PN}/${P}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt doc"

RESTRICT="test"

DEPEND=">=dev-lang/ocaml-3.10.2[ocamlopt?]
	>=dev-ml/ocamlnet-2.2.9-r1
	>=dev-ml/ocaml-ssl-0.4.3"
RDEPEND="${DEPEND}"

src_compile(){
	emake -j1
	use ocamlopt && emake -j1 opt
}

src_install(){
	findlib_src_install
	dodoc README INSTALL Changelog
	use doc && dohtml -r doc/ocamldap/html
}
