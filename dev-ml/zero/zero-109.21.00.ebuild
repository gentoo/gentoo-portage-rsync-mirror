# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/zero/zero-109.21.00.ebuild,v 1.1 2013/05/24 17:02:47 aballier Exp $

EAPI="5"
OASIS_BUILD_TESTS=1

inherit oasis

DESCRIPTION="Library with general data structures that emphasizes performance over usability"
HOMEPAGE="http://bitbucket.org/yminsky/ocaml-core/wiki/Home"
SRC_URI="http://ocaml.janestreet.com/ocaml-core/${PV}/individual/${P}.tar.gz
	http://dev.gentoo.org/~aballier/distfiles/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=dev-ml/core-109.20.00:=
	>=dev-ml/fieldslib-109.20.00:=
	>=dev-ml/pa_ounit-109.15.00:=
	>=dev-ml/sexplib-109.20.00:=
	"
RDEPEND="${DEPEND}"
