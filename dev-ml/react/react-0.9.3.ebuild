# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/react/react-0.9.3.ebuild,v 1.3 2012/03/27 21:26:01 aballier Exp $

EAPI="4"

OASIS_BUILD_TESTS=1

inherit oasis

DESCRIPTION="OCaml module for functional reactive programming"
HOMEPAGE="http://erratique.ch/software/react"
SRC_URI="http://erratique.ch/software/react/releases/${P}.tbz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

DOCS=( "CHANGES" "README" )
