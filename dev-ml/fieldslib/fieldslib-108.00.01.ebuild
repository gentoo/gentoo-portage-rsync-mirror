# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/fieldslib/fieldslib-108.00.01.ebuild,v 1.2 2012/07/09 20:54:36 ulm Exp $

EAPI="3"

OASIS_BUILD_DOCS=1

inherit oasis

MY_P=${PN/-/_}-${PV}
DESCRIPTION="Folding over record fields"
HOMEPAGE="http://www.janestreet.com/ocaml"
SRC_URI="http://bitbucket.org/yminsky/ocaml-core/downloads/${MY_P}.tar.gz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-ml/type-conv-3.0.5"
RDEPEND="${DEPEND}"

DOCS=( "README" )
S="${WORKDIR}/${MY_P}"
