# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/openspecfun/openspecfun-0.4.ebuild,v 1.1 2014/08/21 09:03:51 patrick Exp $

EAPI=5

DESCRIPTION="A collection of special mathematical functions"
HOMEPAGE="http://julialang.org/"
SRC_URI="
	https://github.com/JuliaLang/openspecfun/archive/v${PV}.tar.gz -> ${P}.tar.gz
	"

LICENSE="MIT public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="virtual/fortran"
DEPEND="${RDEPEND}"

src_install() {
	emake DESTDIR="${D}" prefix="/usr" install
}
