# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocaml-expect/ocaml-expect-0.0.3.ebuild,v 1.1 2012/10/08 12:21:59 aballier Exp $

EAPI=3

OASIS_BUILD_DOCS=1

inherit oasis

DESCRIPTION="Ocaml implementation of expect to help building unitary testing"
HOMEPAGE="http://forge.ocamlcore.org/projects/ocaml-expect/"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/894/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-ml/extlib
	dev-ml/pcre-ocaml"
DEPEND="${RDEPEND}
	dev-ml/ounit"

DOCS=( "README.txt" "CHANGES.txt" "AUTHORS.txt" )
