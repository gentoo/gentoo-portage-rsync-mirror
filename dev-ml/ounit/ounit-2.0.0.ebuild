# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ounit/ounit-2.0.0.ebuild,v 1.2 2014/01/12 20:09:43 pacho Exp $

EAPI="5"

OASIS_BUILD_DOCS=1

inherit oasis

DESCRIPTION="Unit testing framework for OCaml"
HOMEPAGE="http://ounit.forge.ocamlcore.org/"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/1258/${P}.tar.gz"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 ~ppc ~x86"
DEPEND=""
RDEPEND="${DEPEND}"
IUSE=""

DOCS=( "README.txt" "AUTHORS.txt" "changelog" )
