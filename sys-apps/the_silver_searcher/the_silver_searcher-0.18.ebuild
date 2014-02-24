# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/the_silver_searcher/the_silver_searcher-0.18.ebuild,v 1.2 2014/02/24 01:47:28 phajdan.jr Exp $

EAPI=5
inherit autotools bash-completion-r1

DESCRIPTION="A code-searching tool similar to ack, but faster"
HOMEPAGE="http://github.com/ggreer/the_silver_searcher"
SRC_URI="https://github.com/ggreer/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND="app-arch/xz-utils
		dev-libs/libpcre"
DEPEND="${RDEPEND}
		virtual/pkgconfig"

DOCS="README.md"

src_prepare() {
	sed -i -e 's/ag\.bashcomp\.sh//' Makefile.am || die
	eautoreconf
}

src_install() {
	default
	newbashcomp ag.bashcomp.sh ag
}
