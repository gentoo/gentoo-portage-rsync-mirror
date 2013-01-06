# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/lambda-term/lambda-term-1.2.ebuild,v 1.1 2012/08/02 12:25:10 aballier Exp $

EAPI=4

OASIS_BUILD_DOCS=1

inherit oasis

DESCRIPTION="A cross-platform library for manipulating the terminal"
HOMEPAGE="http://forge.ocamlcore.org/projects/lambda-term/"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/945/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-ml/lwt-2.4.0[react]
	>=dev-ml/zed-1.2"
RDEPEND="${DEPEND}"

DOCS=( "CHANGES" )
