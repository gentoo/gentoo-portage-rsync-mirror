# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/fieldslib/fieldslib-108.07.01.ebuild,v 1.2 2012/10/17 12:14:10 aballier Exp $

EAPI="3"

OASIS_BUILD_DOCS=1

inherit oasis

MY_P=${PN/-/_}-${PV}
DESCRIPTION="Folding over record fields"
HOMEPAGE="http://www.janestreet.com/ocaml"
SRC_URI="http://ocaml.janestreet.com/ocaml-core/${PV}/individual/${MY_P}.tar.gz
	http://dev.gentoo.org/~aballier/distfiles/${MY_P}.tar.gz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-ml/type-conv-3.0.5"
RDEPEND="${DEPEND}"

DOCS=( "README.txt" )
S="${WORKDIR}/${MY_P}"
