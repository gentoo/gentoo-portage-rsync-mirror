# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/variantslib/variantslib-108.07.01.ebuild,v 1.2 2012/10/17 12:16:09 aballier Exp $

EAPI="4"

OASIS_BUILD_DOCS=1

inherit oasis

DESCRIPTION="OCaml variants as first class values"
HOMEPAGE="http://bitbucket.org/yminsky/ocaml-core/wiki/Home"
SRC_URI="http://ocaml.janestreet.com/ocaml-core/${PV}/individual/${P}.tar.gz
	http://dev.gentoo.org/~aballier/distfiles/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-ml/type-conv-3.0.5"
RDEPEND="${DEPEND}"

DOCS=( "README.txt" )
