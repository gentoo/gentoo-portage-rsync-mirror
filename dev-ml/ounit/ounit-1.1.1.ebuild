# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ounit/ounit-1.1.1.ebuild,v 1.5 2012/05/29 19:37:39 ranger Exp $

EAPI="3"

OASIS_BUILD_DOCS=1

inherit oasis

DESCRIPTION="Unit testing framework for OCaml"
HOMEPAGE="http://ounit.forge.ocamlcore.org/"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/762/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc x86"
DEPEND=""
RDEPEND="${DEPEND}"
IUSE=""

DOCS=( "README.txt" "AUTHORS.txt" "changelog" )
