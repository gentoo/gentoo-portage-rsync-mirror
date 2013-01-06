# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/xmlm/xmlm-1.1.0.ebuild,v 1.2 2012/03/27 21:25:52 aballier Exp $

EAPI=3

OASIS_BUILD_TESTS=1

inherit oasis

DESCRIPTION="Ocaml XML manipulation module"
HOMEPAGE="http://erratique.ch/software/xmlm"
SRC_URI="http://erratique.ch/software/${PN}/releases/${P}.tbz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

DOCS=( "CHANGES" "README" )
