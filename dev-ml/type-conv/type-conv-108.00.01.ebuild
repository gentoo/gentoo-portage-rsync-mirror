# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/type-conv/type-conv-108.00.01.ebuild,v 1.2 2012/07/09 21:08:47 ulm Exp $

EAPI="3"

OASIS_BUILD_DOCS=1

inherit oasis

MY_P=${PN/-/_}-${PV}
DESCRIPTION="Mini library required for some other preprocessing libraries"
HOMEPAGE="http://bitbucket.org/yminsky/ocaml-core/wiki/Home"
SRC_URI="http://bitbucket.org/yminsky/ocaml-core/downloads/${MY_P}.tar.gz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

DOCS=( "README.txt" "Changelog" )

S="${WORKDIR}/${MY_P}"
